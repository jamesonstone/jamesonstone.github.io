#!/usr/bin/env ruby
# frozen_string_literal: true

require "cgi"
require "yaml"
require "date"
require "time"

ROOT = File.expand_path("..", __dir__)
SITE = File.join(ROOT, "_site")

LEGACY_POSTS = {
  "2019-12-28-i-hop" => "/blog/2019/12/28/i-hop.html",
  "2020-01-12-weather-pre" => "/blog/2020/01/12/weather-pre.html",
  "2020-01-17-makefile-semver" => "/blog/2020/01/17/makefile-semver.html",
  "2020-01-18-manage-struct" => "/blog/2020/01/18/manage-struct.html",
  "2020-01-18-post-commit-semver" => "/blog/2020/01/18/post-commit-semver.html",
  "2020-01-25-debezium" => "/blog/2020/01/25/debezium.html",
  "2020-02-01-team-slack" => "/blog/2020/02/01/team-slack.html",
  "2020-02-15-compose-kafka" => "/blog/2020/02/15/compose-kafka.html",
  "2020-02-22-pt1-k8s-dashboard" => "/blog/2020/02/22/pt1-k8s-dashboard.html",
  "2020-02-22-pt2-k8s-dashboard" => "/blog/2020/02/22/pt2-k8s-dashboard.html",
  "2020-02-26-kubeless" => "/blog/2020/02/26/kubeless.html",
  "2020-03-01-kotlinconsumer" => "/blog/2020/03/01/kotlinconsumer.html",
  "2020-03-04-avro-schema" => "/blog/2020/03/04/avro-schema.html"
}.freeze

REQUIRED_ROUTES = [
  "/index.html",
  "/llms.txt",
  "/blog/index.html",
  "/paintings/index.html",
  "/projects/index.html",
  "/about/index.html",
  "/reasoning-machines/index.html",
  "/llms-full.txt",
  "/full-llms.txt",
  "/feed.xml"
].freeze

LLMS_REQUIRED_SITE_ROUTES = [
  "/",
  "/blog/",
  "/paintings/",
  "/projects/",
  "/about/",
  "/reasoning-machines/",
  "/llms-full.txt",
  "/full-llms.txt",
  "/feed.xml"
].freeze

LLMS_LATEST_POST_LIMIT = 5
SOCIAL_WIDTH = 1200
SOCIAL_HEIGHT = 630
SOCIAL_DESCRIPTION_LIMIT = 500
PNG_SIGNATURE = "\x89PNG\r\n\x1A\n".b

ALLOWED_WORKFLOWS = [
  "auto-assign.yml",
  "update-projects.yml"
].freeze

HIDDEN_DRAFT_SLUGS = %w[
  zen-team
  walled-garden
  right-problem
  prog-dev-eng
].freeze

SOURCE_PATHS = [
  "index.md",
  "llms.txt",
  "projects.md",
  "about.md"
].freeze

SOURCE_GLOBS = [
  "_posts/*.md",
  "blog/**/*.md",
  "paintings/**/*.md"
].freeze

def fail_with(message)
  warn "validate_site: #{message}"
  exit 1
end

def assert_file(path)
  return if File.file?(path)

  fail_with("missing file: #{path.delete_prefix("#{ROOT}/")}")
end

def assert_post_permalink(post_id, route)
  return if File.file?(site_path(route))

  fail_with("#{post_id} missing rendered permalink: #{route}")
end

def site_path(url)
  File.join(SITE, url.delete_prefix("/"))
end

def source_files
  explicit_paths = SOURCE_PATHS.map { |path| File.join(ROOT, path) }
  glob_paths = SOURCE_GLOBS.flat_map { |glob| Dir.glob(File.join(ROOT, glob)) }

  (explicit_paths + glob_paths).uniq
end

def post_sources
  Dir.glob(File.join(ROOT, "_posts", "*.md")).sort
end

def front_matter(path)
  text = File.read(path)
  match = text.match(/\A---\n(.*?)\n---\n/m)
  fail_with("missing front matter: #{path.delete_prefix("#{ROOT}/")}") unless match

  YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: false) || {}
end

def site_config
  @site_config ||= YAML.safe_load(File.read(File.join(ROOT, "_config.yml")), aliases: false) || {}
end

def site_base_url
  url = site_config["url"].to_s.delete_suffix("/")
  fail_with("_config.yml missing url") if url.empty?

  baseurl = site_config["baseurl"].to_s
  baseurl = "/#{baseurl}" unless baseurl.empty? || baseurl.start_with?("/")

  "#{url}#{baseurl}".delete_suffix("/")
end

def absolute_site_url(route)
  route = "/#{route}" unless route.start_with?("/")

  return "#{site_base_url}/" if route == "/"

  "#{site_base_url}#{route}"
end

def post_time(post_id, value)
  fail_with("#{post_id} missing required date front matter") unless value

  case value
  when Time
    value
  when Date
    Time.new(value.year, value.month, value.day)
  else
    Time.parse(value.to_s)
  end
rescue ArgumentError
  fail_with("#{post_id} has invalid date front matter")
end

def post_slug(path)
  post_id = File.basename(path, ".md")
  match = post_id.match(/\A\d{4}-\d{2}-\d{2}-(.+)\z/)
  fail_with("invalid post filename: _posts/#{File.basename(path)}") unless match

  match[1]
end

def social_default_path
  File.join(ROOT, "assets", "images", "social", "default.png")
end

def social_post_path(slug)
  File.join(ROOT, "assets", "images", "social", "posts", "#{slug}.png")
end

def png_chunks(path)
  chunks = []
  File.open(path, "rb") do |file|
    return nil unless file.read(8) == PNG_SIGNATURE

    until file.eof?
      length_bytes = file.read(4)
      break if length_bytes.nil? || length_bytes.bytesize < 4

      length = length_bytes.unpack1("N")
      type = file.read(4)
      data = file.read(length)
      file.read(4)
      break if type.nil? || data.nil? || data.bytesize < length

      chunks << [type, data]
      break if type == "IEND"
    end
  end
  chunks
end

def png_dimensions(chunks)
  chunk = chunks.find { |type, _data| type == "IHDR" }
  return nil unless chunk && chunk[1].bytesize >= 8

  chunk[1].unpack("NN")
end

def png_title(chunks)
  marker = "Title\0".b
  chunk = chunks.find { |type, data| type == "tEXt" && data.start_with?(marker) }
  return nil unless chunk

  chunk[1].byteslice(marker.bytesize..-1).force_encoding("UTF-8")
end

def assert_social_card(path, title)
  relative = path.delete_prefix("#{ROOT}/")
  unless File.file?(path)
    fail_with("missing social card: #{relative} (run python3 scripts/generate_social_cards.py)")
  end

  chunks = png_chunks(path)
  fail_with("#{relative} is not a PNG social card") unless chunks

  width, height = png_dimensions(chunks)
  unless [width, height] == [SOCIAL_WIDTH, SOCIAL_HEIGHT]
    fail_with("#{relative} must be #{SOCIAL_WIDTH}x#{SOCIAL_HEIGHT}")
  end

  card_title = png_title(chunks)
  return if card_title == title

  fail_with("#{relative} card title is #{card_title.inspect}, expected #{title.inspect}")
end

def meta_content(html, attribute, name)
  html[/<meta\s+#{attribute}="#{Regexp.escape(name)}"\s+content="([^"]*)"/, 1]
end

def decoded_meta(html, attribute, name)
  value = meta_content(html, attribute, name)
  return nil if value.nil?

  CGI.unescapeHTML(value)
end

def assert_absolute_url(label, value)
  fail_with("#{label} missing absolute URL") if value.nil? || value.empty?
  return if value == "#{site_base_url}/" || value.start_with?("#{site_base_url}/")

  fail_with("#{label} is not an absolute site URL: #{value}")
end

def assert_social_tags(html, label, type:, image:, title: nil)
  og_title = decoded_meta(html, "property", "og:title")
  description = decoded_meta(html, "property", "og:description")
  og_url = meta_content(html, "property", "og:url")
  canonical = html[/rel="canonical"\s+href="([^"]+)"/, 1]
  og_type = meta_content(html, "property", "og:type")
  og_image = meta_content(html, "property", "og:image")
  width = meta_content(html, "property", "og:image:width")
  height = meta_content(html, "property", "og:image:height")
  card = meta_content(html, "name", "twitter:card")
  twitter_image = meta_content(html, "name", "twitter:image")

  fail_with("#{label} missing og:title") if og_title.nil? || og_title.strip.empty?
  fail_with("#{label} og:title is #{og_title.inspect}, expected #{title.inspect}") if title && og_title != title
  fail_with("#{label} missing og:description") if description.nil? || description.strip.empty?
  if description.length > SOCIAL_DESCRIPTION_LIMIT
    fail_with("#{label} og:description is longer than #{SOCIAL_DESCRIPTION_LIMIT} characters")
  end
  fail_with("#{label} og:type is #{og_type.inspect}, expected #{type.inspect}") unless og_type == type
  fail_with("#{label} og:image is #{og_image.inspect}, expected #{image}") unless og_image == image
  fail_with("#{label} og:image:width is #{width.inspect}") unless width == SOCIAL_WIDTH.to_s
  fail_with("#{label} og:image:height is #{height.inspect}") unless height == SOCIAL_HEIGHT.to_s
  fail_with("#{label} twitter:card is #{card.inspect}") unless card == "summary_large_image"
  fail_with("#{label} twitter:image does not match og:image") unless twitter_image == og_image
  assert_absolute_url("#{label} og:url", og_url)
  fail_with("#{label} canonical does not match og:url") unless canonical == og_url
  fail_with("#{label} must not set twitter:site") if html.include?('name="twitter:site"')
  fail_with("#{label} must not set twitter:creator") if html.include?('name="twitter:creator"')

  [og_title, description, og_url]
end

def post_date_path(post_id, value)
  post_time(post_id, value).strftime("%Y/%m/%d")
end

def assert_post_front_matter(post_id, metadata)
  fail_with("#{post_id} missing required layout front matter") unless metadata.key?("layout")
  fail_with("#{post_id} must use post layout") unless metadata["layout"] == "post"
  fail_with("#{post_id} missing required title front matter") if metadata["title"].to_s.strip.empty?
  fail_with("#{post_id} missing required date front matter") unless metadata.key?("date")
end

def latest_post_records
  post_sources.map do |source_path|
    post_id = File.basename(source_path, ".md")
    metadata = front_matter(source_path)

    {
      path: source_path,
      date: post_time(post_id, metadata["date"]),
      route: "/blog/#{post_date_path(post_id, metadata["date"])}/#{post_slug(source_path)}.html"
    }
  end.sort_by { |post| [post[:date], post[:path]] }.reverse.first(LLMS_LATEST_POST_LIMIT)
end

def project_urls
  text = File.read(File.join(ROOT, "projects.md"))
  href_urls = text.scan(%r{href="(https://[^"]+)"}).flatten
  markdown_urls = markdown_links(text).select { |url| url.start_with?("https://") }

  (href_urls + markdown_urls).sort.uniq
end

def markdown_links(text)
  text.scan(/\[[^\]]+\]\(([^)\s]+)\)/).flatten
end

def required_llms_urls
  site_urls = LLMS_REQUIRED_SITE_ROUTES.map { |route| absolute_site_url(route) }
  post_urls = latest_post_records.map { |post| absolute_site_url(post[:route]) }

  (site_urls + post_urls + project_urls).uniq
end

def assert_llms_txt_current
  source_path = File.join(ROOT, "llms.txt")
  output_path = site_path("/llms.txt")
  assert_file(source_path)
  assert_file(output_path)

  source_text = File.read(source_path)
  fail_with("llms.txt must start with an H1 title") unless source_text.start_with?("# ")
  fail_with("llms.txt missing blockquote summary") unless source_text.match?(/^>\s+\S/)
  fail_with("llms.txt missing at least one H2 section") unless source_text.match?(/^##\s+\S/)
  fail_with("generated llms.txt does not match source llms.txt") unless File.read(output_path) == source_text

  links = markdown_links(source_text)
  required_llms_urls.each do |url|
    next if links.include?(url)

    fail_with("llms.txt missing required link: #{url}")
  end
end

fail_with("_site is missing; run bundle exec jekyll build first") unless Dir.exist?(SITE)

REQUIRED_ROUTES.each do |route|
  assert_file(site_path(route))
end

assert_social_card(social_default_path, site_config["title"].to_s)

post_sources.each do |source_path|
  post_id = File.basename(source_path, ".md")
  metadata = front_matter(source_path)
  assert_post_front_matter(post_id, metadata)

  slug = post_slug(source_path)
  route = "/blog/#{post_date_path(post_id, metadata["date"])}/#{slug}.html"
  assert_post_permalink(post_id, route)
  assert_social_card(social_post_path(slug), metadata["title"].to_s)

  html = File.read(site_path(route))
  _og_title, description, og_url = assert_social_tags(
    html,
    post_id,
    type: "article",
    image: absolute_site_url("/assets/images/social/posts/#{slug}.png"),
    title: metadata["title"].to_s
  )
  site_description = site_config["description"].to_s.strip
  if !site_description.empty? && description == site_description
    fail_with("#{post_id} og:description still uses the site-wide description")
  end

  published = meta_content(html, "property", "article:published_time")
  expected_date = post_time(post_id, metadata["date"]).strftime("%Y-%m-%d")
  if published.nil? || !published.include?(expected_date)
    fail_with("#{post_id} missing article:published_time for #{expected_date}")
  end
  expected_url = absolute_site_url(route)
  fail_with("#{post_id} og:url is #{og_url}, expected #{expected_url}") unless og_url == expected_url
end

expected_cards = post_sources.map { |source_path| "#{post_slug(source_path)}.png" }
Dir.glob(File.join(ROOT, "assets", "images", "social", "posts", "*.png")).each do |path|
  name = File.basename(path)
  next if expected_cards.include?(name)

  fail_with("orphan social card: assets/images/social/posts/#{name}")
end

home_html = File.read(site_path("/index.html"))
_home_title, home_description, _home_url = assert_social_tags(
  home_html,
  "home",
  type: "website",
  image: absolute_site_url("/assets/images/social/default.png"),
  title: site_config["title"].to_s
)
site_description = site_config["description"].to_s.strip
if !site_description.empty? && home_description != site_description
  fail_with("home og:description is #{home_description.inspect}")
end
fail_with("home must not use article:published_time") if home_html.include?("article:published_time")

%w[
  /blog/index.html
  /paintings/index.html
  /projects/index.html
  /about/index.html
  /reasoning-machines/index.html
].each do |route|
  assert_social_tags(
    File.read(site_path(route)),
    route,
    type: "website",
    image: absolute_site_url("/assets/images/social/default.png")
  )
end

LEGACY_POSTS.each do |post_id, route|
  source_path = File.join(ROOT, "_posts", "#{post_id}.md")
  assert_file(source_path)
  assert_file(site_path(route))

  metadata = front_matter(source_path)
  fail_with("#{post_id} must use post layout") unless metadata["layout"] == "post"
  fail_with("#{post_id} must be marked archive") unless metadata["archive"] == true
  fail_with("#{post_id} missing date_source") unless metadata["date_source"]
  fail_with("#{post_id} missing title") unless metadata["title"]
  fail_with("#{post_id} missing date") unless metadata["date"]
end

assert_llms_txt_current

forbidden_sources = [
  File.join(ROOT, "params.json"),
  File.join(ROOT, "javascripts", "scale.fix.js"),
  File.join(ROOT, "stylesheets", "styles.css"),
  File.join(ROOT, "stylesheets", "pygment_trac.css")
]
forbidden_sources.each do |path|
  fail_with("forbidden source exists: #{path.delete_prefix("#{ROOT}/")}") if File.exist?(path)
end

forbidden_outputs = %w[
  /Gemfile
  /Gemfile.lock
  /README.md
  /scripts/validate_site.rb
]
forbidden_outputs.each do |path|
  fail_with("forbidden generated output exists: #{path}") if File.exist?(site_path(path))
end

workflow_files = Dir.glob(File.join(ROOT, ".github", "workflows", "*")).map { |path| File.basename(path) }
unexpected_workflows = workflow_files - ALLOWED_WORKFLOWS
fail_with("unexpected GitHub Actions workflow exists: #{unexpected_workflows.first}") unless unexpected_workflows.empty?

scan_files = source_files + Dir.glob(File.join(SITE, "**", "*")).select { |path| File.file?(path) }
HIDDEN_DRAFT_SLUGS.each do |slug|
  offenders = scan_files.select { |path| File.read(path).include?(slug) }
  offenders.reject! { |path| path.include?("/docs/") }
  next if offenders.empty?

  fail_with("hidden draft slug #{slug.inspect} found in #{offenders.first.delete_prefix("#{ROOT}/")}")
end

source_files.each do |path|
  text = File.read(path)

  text.scan(%r{(?:!\[[^\]]*\]\(|src=")(/assets/[^)"\s]+)}) do |match|
    asset_path = File.join(ROOT, match.first.delete_prefix("/"))
    assert_file(asset_path)
  end

  text.scan(%r{\]\((/blog/\d{4}/\d{2}/\d{2}/[^)#\s]+\.html)\)}) do |match|
    assert_file(site_path(match.first))
  end
end

puts "validate_site: ok"
