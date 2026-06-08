#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

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

    %w[index projects about].each do |name|
      File.write(File.join(root, "#{name}.md"), "#{name}\n")
    end

    %w[
      index.html
      blog/index.html
      paintings/index.html
      projects/index.html
      about/index.html
      feed.xml
    ].each do |route|
      write_site_file(root, route)
    end

    LEGACY_POSTS.each do |post_id, route|
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
      write_site_file(root, route.delete_prefix("/"))
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
    write_site_file(root, "blog/2026/06/07/new-post.html")
  end

  def write_post(root, post_id, metadata)
    post_path = File.join(root, "_posts", "#{post_id}.md")
    FileUtils.mkdir_p(File.dirname(post_path))
    File.write(post_path, "---\n#{metadata}---\n\nBody.\n")
  end

  def write_site_file(root, route)
    path = File.join(root, "_site", route)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, "<!doctype html>\n")
  end

  def run_validator(root)
    Open3.capture3("ruby", "scripts/validate_site.rb", chdir: root)
  end
end
