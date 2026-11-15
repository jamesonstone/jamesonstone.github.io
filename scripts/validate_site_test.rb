#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"
require "zlib"

REPO_ROOT = File.expand_path("..", __dir__)
VALIDATOR = File.join(REPO_ROOT, "scripts", "validate_site.rb")

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

class ValidateSiteTest < Minitest::Test
  def test_valid_site_fixture_passes
    with_site_fixture do |root|
      stdout, stderr, status = run_validator(root)

      assert status.success?, stderr
      assert_includes stdout, "validate_site: ok"
    end
  end

  def test_missing_required_post_title_fails
    with_site_fixture do |root|
      write_post(
        root,
        "2026-06-07-new-post",
        <<~YAML
          layout: post
          date: 2026-06-07 12:00:00 -0400
        YAML
      )

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "2026-06-07-new-post missing required title front matter"
    end
  end

  def test_missing_rendered_permalink_fails
    with_site_fixture do |root|
      FileUtils.rm_f(File.join(root, "_site", "blog", "2026", "06", "07", "new-post.html"))

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "2026-06-07-new-post missing rendered permalink: /blog/2026/06/07/new-post.html"
    end
  end

  def test_invalid_post_filename_fails
    with_site_fixture do |root|
      write_post(
        root,
        "bad-filename",
        <<~YAML
          layout: post
          title: Bad Filename
          date: 2026-06-07 12:00:00 -0400
        YAML
      )

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "invalid post filename: _posts/bad-filename.md"
    end
  end

  def test_allowed_projects_workflow_passes
    with_site_fixture do |root|
      workflow_dir = File.join(root, ".github", "workflows")
      FileUtils.mkdir_p(workflow_dir)
      File.write(File.join(workflow_dir, "update-projects.yml"), "name: Update projects page\n")

      stdout, stderr, status = run_validator(root)

      assert status.success?, stderr
      assert_includes stdout, "validate_site: ok"
    end
  end

  def test_allowed_auto_assign_workflow_passes
    with_site_fixture do |root|
      workflow_dir = File.join(root, ".github", "workflows")
      FileUtils.mkdir_p(workflow_dir)
      File.write(File.join(workflow_dir, "auto-assign.yml"), "name: Auto assign\n")

      stdout, stderr, status = run_validator(root)

      assert status.success?, stderr
      assert_includes stdout, "validate_site: ok"
    end
  end

  def test_custom_domain_cname_passes
    with_site_fixture do |root|
      File.write(File.join(root, "CNAME"), "jamesonstone.io\n")
      write_site_file(root, "CNAME", "jamesonstone.io\n")

      stdout, stderr, status = run_validator(root)

      assert status.success?, stderr
      assert_includes stdout, "validate_site: ok"
    end
  end

  def test_unexpected_workflow_fails
    with_site_fixture do |root|
      workflow_dir = File.join(root, ".github", "workflows")
      FileUtils.mkdir_p(workflow_dir)
      File.write(File.join(workflow_dir, "deploy.yml"), "name: Deploy\n")

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "unexpected GitHub Actions workflow exists: deploy.yml"
    end
  end

  def test_missing_llms_latest_post_link_fails
    with_site_fixture do |root|
      llms_path = File.join(root, "llms.txt")
      text = File.read(llms_path)
                 .gsub("https://jamesonstone.github.io/blog/2026/06/07/new-post.html", "https://example.com/missing-post")
      write_llms_text(root, text)

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "llms.txt missing required link: https://jamesonstone.github.io/blog/2026/06/07/new-post.html"
    end
  end

  def test_missing_llms_project_link_fails
    with_site_fixture do |root|
      File.write(
        File.join(root, "projects.md"),
        <<~HTML
          <ul class="project-list">
            <li><strong><a href="https://github.com/jamesonstone/new-tool">new-tool</a></strong>: New tool.</li>
          </ul>
        HTML
      )

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "llms.txt missing required link: https://github.com/jamesonstone/new-tool"
    end
  end

  def test_missing_llms_public_project_link_fails
    with_site_fixture do |root|
      File.write(
        File.join(root, "projects.md"),
        <<~HTML
          <ul class="project-list project-list--featured">
            <li><a href="https://scout.jamesonstone.io/">Scout</a></li>
          </ul>
        HTML
      )

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "llms.txt missing required link: https://scout.jamesonstone.io/"
    end
  end

  def test_missing_social_card_fails
    with_site_fixture do |root|
      FileUtils.rm_f(File.join(root, "assets", "images", "social", "posts", "new-post.png"))

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "missing social card: assets/images/social/posts/new-post.png"
    end
  end

  def test_stale_social_card_title_fails
    with_site_fixture do |root|
      write_card_png(File.join(root, "assets", "images", "social", "posts", "new-post.png"), "Old Title")

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, 'card title is "Old Title"'
    end
  end

  def test_post_without_og_image_fails
    with_site_fixture do |root|
      write_site_file(
        root,
        "blog/2026/06/07/new-post.html",
        article_html("New Post", "/blog/2026/06/07/new-post.html", "2026-06-07").sub(
          %r{<meta property="og:image" content="[^"]+">\n},
          ""
        )
      )

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "2026-06-07-new-post og:image"
    end
  end

  def test_sitewide_post_description_fails
    with_site_fixture do |root|
      File.write(
        File.join(root, "_config.yml"),
        <<~YAML
          title: Jameson Stone
          url: "https://jamesonstone.github.io"
          baseurl: ""
          description: Shared site description.
        YAML
      )
      post_path = File.join(root, "_site", "blog", "2026", "06", "07", "new-post.html")
      html = File.read(post_path).sub(
        'content="Fixture description for New Post."',
        'content="Shared site description."'
      )
      File.write(post_path, html)

      _stdout, stderr, status = run_validator(root)

      refute status.success?
      assert_includes stderr, "og:description still uses the site-wide description"
    end
  end

  private

  def with_site_fixture
    Dir.mktmpdir("validate-site-test") do |root|
      build_site_fixture(root)
      yield root
    end
  end

  def build_site_fixture(root)
    FileUtils.mkdir_p(File.join(root, "scripts"))
    FileUtils.cp(VALIDATOR, File.join(root, "scripts", "validate_site.rb"))

    File.write(
      File.join(root, "_config.yml"),
      <<~YAML
        title: Jameson Stone
        url: "https://jamesonstone.github.io"
        baseurl: ""
      YAML
    )

    %w[index projects about].each do |name|
      File.write(File.join(root, "#{name}.md"), "#{name}\n")
    end

    {
      "index.html" => "Jameson Stone",
      "blog/index.html" => "Blog",
      "paintings/index.html" => "Paintings",
      "projects/index.html" => "Projects",
      "about/index.html" => "About",
      "reasoning-machines/index.html" => "Reasoning Machines"
    }.each do |route, title|
      write_site_file(root, route, website_html(title))
    end
    write_card_png(File.join(root, "assets", "images", "social", "default.png"), "Jameson Stone")

    %w[
      llms-full.txt
      full-llms.txt
      feed.xml
    ].each do |route|
      write_site_file(root, route)
    end

    LEGACY_POSTS.each do |post_id, _route|
      write_post(
        root,
        post_id,
        <<~YAML
          layout: post
          title: Legacy #{post_id}
          date: #{post_id[0, 10]} 12:00:00 -0500
          archive: true
          date_source: legacy_git_first_commit
        YAML
      )
    end

    write_post(
      root,
      "2026-06-07-new-post",
      <<~YAML
        layout: post
        title: New Post
        date: 2026-06-07 12:00:00 -0400
      YAML
    )
    write_llms_file(root)
  end

  def write_post(root, post_id, metadata)
    post_path = File.join(root, "_posts", "#{post_id}.md")
    FileUtils.mkdir_p(File.dirname(post_path))
    File.write(post_path, "---\n#{metadata}---\n\nBody.\n")
    title = metadata[/^title:\s*(.+)$/, 1]&.strip
    return unless title
    return unless post_id.match?(/\A\d{4}-\d{2}-\d{2}-.+\z/)

    slug = post_id.sub(/\A\d{4}-\d{2}-\d{2}-/, "")
    date = post_id[0, 10]
    route = "/blog/#{date.tr("-", "/")}/#{slug}.html"
    write_card_png(File.join(root, "assets", "images", "social", "posts", "#{slug}.png"), title)
    write_site_file(root, route.delete_prefix("/"), article_html(title, route, date))
  end

  def website_html(title)
    url = "https://jamesonstone.github.io/"
    image = "https://jamesonstone.github.io/assets/images/social/default.png"
    <<~HTML
      <!doctype html>
      <html><head>
      <link rel="canonical" href="#{url}">
      <meta property="og:title" content="#{title}">
      <meta property="og:description" content="Fixture page.">
      <meta property="og:url" content="#{url}">
      <meta property="og:type" content="website">
      <meta property="og:image" content="#{image}">
      <meta property="og:image:width" content="1200">
      <meta property="og:image:height" content="630">
      <meta name="twitter:card" content="summary_large_image">
      <meta name="twitter:image" content="#{image}">
      </head></html>
    HTML
  end

  def article_html(title, route, date)
    url = "https://jamesonstone.github.io#{route}"
    image = "https://jamesonstone.github.io/assets/images/social/posts/#{File.basename(route, ".html")}.png"
    <<~HTML
      <!doctype html>
      <html><head>
      <link rel="canonical" href="#{url}">
      <meta property="og:title" content="#{title}">
      <meta property="og:description" content="Fixture description for #{title}.">
      <meta property="og:url" content="#{url}">
      <meta property="og:type" content="article">
      <meta property="og:image" content="#{image}">
      <meta property="og:image:width" content="1200">
      <meta property="og:image:height" content="630">
      <meta property="article:published_time" content="#{date}T12:00:00-05:00">
      <meta name="twitter:card" content="summary_large_image">
      <meta name="twitter:image" content="#{image}">
      </head></html>
    HTML
  end

  def write_card_png(path, title, width = 1200, height = 630)
    row = "\x00".b + ("\xFB\xFA\xF4".b * width)
    raw = row * height
    ihdr = [width, height, 8, 2, 0, 0, 0].pack("NNCCCCC")
    text = "Title\0#{title}".b
    png = "\x89PNG\r\n\x1A\n".b
    png << png_chunk("IHDR", ihdr)
    png << png_chunk("tEXt", text)
    png << png_chunk("IDAT", Zlib::Deflate.deflate(raw, 9))
    png << png_chunk("IEND", "".b)
    FileUtils.mkdir_p(File.dirname(path))
    File.binwrite(path, png)
  end

  def png_chunk(type, data)
    [data.bytesize].pack("N") + type + data + [Zlib.crc32(type + data)].pack("N")
  end

  def write_llms_file(root)
    write_llms_text(
      root,
      <<~MARKDOWN
        # Jameson Stone

        > Personal site fixture for posts, projects, and public pages.

        ## Primary Pages

        - [Home](https://jamesonstone.github.io/): Site index.
        - [Blog](https://jamesonstone.github.io/blog/): Writing archive.
        - [Paintings](https://jamesonstone.github.io/paintings/): Painting archive.
        - [Projects](https://jamesonstone.github.io/projects/): Project notes.
        - [About](https://jamesonstone.github.io/about/): Profile and contact.
        - [Reasoning Machines](https://jamesonstone.github.io/reasoning-machines/): Directory.
        - [Full content](https://jamesonstone.github.io/llms-full.txt): Content.
        - [Full alias](https://jamesonstone.github.io/full-llms.txt): Alias.
        - [RSS](https://jamesonstone.github.io/feed.xml): Feed.

        ## Latest Posts

        - [New Post](https://jamesonstone.github.io/blog/2026/06/07/new-post.html): Fixture post.
        - [Avro Schema](https://jamesonstone.github.io/blog/2020/03/04/avro-schema.html): Fixture post.
        - [Kotlin Consumer](https://jamesonstone.github.io/blog/2020/03/01/kotlinconsumer.html): Fixture post.
        - [Kubeless](https://jamesonstone.github.io/blog/2020/02/26/kubeless.html): Fixture post.
        - [Kubernetes Dashboard Part 2](https://jamesonstone.github.io/blog/2020/02/22/pt2-k8s-dashboard.html): Fixture post.
      MARKDOWN
    )
  end

  def write_llms_text(root, text)
    File.write(File.join(root, "llms.txt"), text)
    write_site_file(root, "llms.txt", text)
  end

  def write_site_file(root, route, body = "<!doctype html>\n")
    path = File.join(root, "_site", route)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, body)
  end

  def run_validator(root)
    Open3.capture3("ruby", "scripts/validate_site.rb", chdir: root)
  end
end
