#!/usr/bin/env ruby
# frozen_string_literal: true

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
  "/feed.xml"
].freeze

LLMS_REQUIRED_SITE_ROUTES = [
  "/",
  "/blog/",
  "/paintings/",
  "/projects/",
  "/about/",
  "/feed.xml"
].freeze

LLMS_LATEST_POST_LIMIT = 5

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

post_sources.each do |source_path|
  post_id = File.basename(source_path, ".md")
  metadata = front_matter(source_path)
  assert_post_front_matter(post_id, metadata)

  route = "/blog/#{post_date_path(post_id, metadata["date"])}/#{post_slug(source_path)}.html"
  assert_post_permalink(post_id, route)
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
