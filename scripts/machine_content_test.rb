#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

class MachineContentTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)

  def test_normal_pages_build_generates_only_public_content_and_matching_alias
    Dir.mktmpdir("machine-content") do |temporary_root|
      root = File.realpath(temporary_root)
      %w[_config.yml _layouts _includes _posts assets index.md about.md projects.md
         reasoning-machines.md paintings blog feed.xml llms.txt llms-full.txt full-llms.txt].each do |path|
        FileUtils.cp_r(File.join(ROOT, path), root)
      end
      FileUtils.mkdir_p(File.join(root, "docs"))
      FileUtils.mkdir_p(File.join(root, "_drafts"))
      File.write(File.join(root, "docs", "internal.md"), "INTERNAL_SENTINEL")
      File.write(File.join(root, "_drafts", "draft.md"), "---\nlayout: post\ntitle: Draft\n---\nDRAFT_SENTINEL")
      File.write(File.join(root, "unlisted.md"), "---\nlayout: default\n---\nUNLISTED_SENTINEL")
      write_post(root, "2000-01-01-private.md", "published: false", "PRIVATE_SENTINEL")
      write_post(root, "2999-01-01-future.md", "", "FUTURE_SENTINEL")
      code_body = "if [ 1 -lt 2 ]; then echo '<keep>'; fi\n<html>\nlayout: example\npermalink: /example/\n{% literal %}"
      code = "```sh\n#{code_body}\n```"
      File.write(File.join(root, "_posts", "fixture-snippet.txt"), "RELATIVE_SNIPPET_SENTINEL")
      write_post(root, "2000-01-02-public.md", "", "PUBLIC_SENTINEL\n\n{{ page.title }}\n\n{% include_relative fixture-snippet.txt %}\n\n{% raw %}#{code}{% endraw %}\n\n[Home](/)")
      stdout, stderr, status = Open3.capture3(
        "bundle", "exec", "jekyll", "build", "--safe", "--source", root,
        "--destination", File.join(root, "_site"), chdir: ROOT
      )
      assert status.success?, "#{stdout}\n#{stderr}"
      full = File.read(File.join(root, "_site", "llms-full.txt"))
      assert_equal full, File.read(File.join(root, "_site", "full-llms.txt"))
      assert full.start_with?("# Jameson Stone"), full[0, 100]
      assert_includes full, "PUBLIC_SENTINEL"
      assert_includes full, code_body
      assert_match(/```\n#{Regexp.escape(code_body)}\n+```/, full)
      assert_includes full, "RELATIVE_SNIPPET_SENTINEL"
      public_post = full.split("Source: https://jamesonstone.io/blog/2000/01/02/public.html").last
      assert_includes public_post, "Fixture"
      assert_includes full, "[Home](https://jamesonstone.io/)"
      %w[INTERNAL_SENTINEL DRAFT_SENTINEL PRIVATE_SENTINEL FUTURE_SENTINEL UNLISTED_SENTINEL].each do |secret|
        refute_includes full, secret
      end
      # Generated shell/metadata must be clean; fenced examples may contain these strings.
      generated = full.gsub(/```[^\n]*\n.*?```/m, "")
      refute_match(/<\/?(?:html|body|nav|footer|header|ul|li)\b|^layout:|^permalink:|\{%/, generated)
      %w[amoteofdust continuity thelightthatbeckons].each do |painting|
        assert_includes full, "https://jamesonstone.io/assets/images/paintings/#{painting}.jpg"
      end
      assert_includes full, "![A Mote of Dust Suspended in a Sunbeam]"
      %w[reasoningmachines.co github.com/appliedsymbolics ambientos.dev opencarrier.dev
         openvital.co limina-dev.github.io github.com/spectral7-ltd
         scout.jamesonstone.io narrowband.jamesonstone.io].each do |host|
        assert_includes full, "https://#{host}"
      end
      assert_includes full, "The Internet was Always Just a Transport Layer"
      index = File.read(File.join(root, "_site", "index.html"))
      assert_includes index, 'id="site-family"'
      refute_includes index, 'site-family-list'
      page = File.read(File.join(root, "_site", "reasoning-machines", "index.html"))
      assert_includes page, '<h1 id="reasoning-machines">Reasoning Machines</h1>'
      assert_includes page, 'href="/llms.txt" aria-label='
      assert_includes page, 'href="/full-llms.txt" aria-label='
      assert_includes page, 'rel="describedby"'
      refute_includes page, '<pre'
      assert_includes page, '<a href="https://reasoningmachines.co/">Reasoning Machines</a>'
      # Preview flags must not expand the machine-readable publication boundary.
      stdout, stderr, status = Open3.capture3(
        "bundle", "exec", "jekyll", "build", "--safe", "--drafts", "--unpublished", "--future",
        "--source", root, "--destination", File.join(root, "_site"), chdir: ROOT
      )
      assert status.success?, "#{stdout}\n#{stderr}"
      preview_full = File.read(File.join(root, "_site", "llms-full.txt"))
      assert_equal full.gsub(/\n{3,}/, "\n\n").strip, preview_full.gsub(/\n{3,}/, "\n\n").strip

    end
  end

  private

  def write_post(root, name, extra, body)
    File.write(File.join(root, "_posts", name),
               "---\nlayout: post\ntitle: Fixture\ndate: #{name[0, 10]}\n#{extra}\n---\n#{body}\n")
  end
end
