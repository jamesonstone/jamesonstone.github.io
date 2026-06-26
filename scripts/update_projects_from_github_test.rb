#!/usr/bin/env ruby
# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"

require_relative "update_projects_from_github"

class UpdateProjectsFromGithubTest < Minitest::Test
  CUTOFF = "2026-06-08T00:00:00-04:00"

  def test_adds_new_public_non_duplicate_repositories
    with_fixture do |projects_path, llms_path|
      client = FakeClient.new(
        [
          repo("old-tool", created_at: "2026-06-08T03:59:59Z", description: "Too old"),
          repo("duplicate-tool", created_at: "2026-06-08T05:00:00Z", description: "Already listed"),
          repo("fork-tool", created_at: "2026-06-08T05:00:00Z", description: "Fork", fork: true),
          repo("archived-tool", created_at: "2026-06-08T05:00:00Z", description: "Archived", archived: true),
          repo("new-tool", created_at: "2026-06-08T05:00:00Z", description: "🧪 New project helper")
        ]
      )

      entries = updater(projects_path, llms_path, client).run
      text = File.read(projects_path)
      llms_text = File.read(llms_path)

      assert_equal ["new-tool"], entries.map(&:name)
      assert_includes text, '<a href="https://github.com/jamesonstone/new-tool">new-tool</a>'
      assert_includes text, "New project helper."
      assert_includes llms_text, "- [new-tool](https://github.com/jamesonstone/new-tool): New project helper."
      refute_includes text, "fork-tool"
      refute_includes text, "archived-tool"
      assert_equal 1, text.scan(%r{<a href="https://github.com/jamesonstone/duplicate-tool">duplicate-tool</a>}).length
    end
  end

  def test_uses_readme_sentence_when_description_is_missing
    with_fixture do |projects_path, llms_path|
      client = FakeClient.new(
        [repo("readme-tool", created_at: "2026-06-08T05:00:00Z", description: nil)],
        "readme-tool" => <<~README
          # Readme Tool

          ```text
          ASCII ART
          ```

          **`readme-tool` keeps small project notes synchronized.** Extra detail follows.
        README
      )

      entries = updater(projects_path, llms_path, client).run
      text = File.read(projects_path)
      llms_text = File.read(llms_path)

      assert_equal ["readme-tool"], entries.map(&:name)
      assert_includes text, "readme-tool keeps small project notes synchronized."
      assert_includes llms_text, "readme-tool keeps small project notes synchronized."
    end
  end

  def test_escapes_markdown_sensitive_llms_text
    with_fixture do |projects_path, llms_path|
      client = FakeClient.new(
        [repo("tool[kit]", created_at: "2026-06-08T05:00:00Z", description: "Fast <beta> [guide]")],
        {},
        "tool[kit]" => "https://github.com/jamesonstone/tool-kit"
      )

      updater(projects_path, llms_path, client).run
      llms_text = File.read(llms_path)

      assert_includes llms_text, "- [tool\\[kit\\]](https://github.com/jamesonstone/tool-kit): Fast &lt;beta&gt; \\[guide\\]."
    end
  end

  def test_dry_run_reports_entries_without_writing
    with_fixture do |projects_path, llms_path|
      original_projects = File.read(projects_path)
      original_llms = File.read(llms_path)
      client = FakeClient.new(
        [repo("dry-run-tool", created_at: "2026-06-08T05:00:00Z", description: "Dry run helper")]
      )

      entries = updater(projects_path, llms_path, client).run(dry_run: true)

      assert_equal ["dry-run-tool"], entries.map(&:name)
      assert_equal original_projects, File.read(projects_path)
      assert_equal original_llms, File.read(llms_path)
    end
  end

  def test_requires_current_tools_list
    Dir.mktmpdir("projects-updater-test") do |root|
      projects_path = File.join(root, "projects.md")
      llms_path = File.join(root, "llms.txt")
      File.write(projects_path, "# Projects\n")
      File.write(llms_path, "## Projects\n\n## Machine Indexes\n")
      client = FakeClient.new(
        [repo("new-tool", created_at: "2026-06-08T05:00:00Z", description: "New project helper")]
      )

      error = assert_raises(RuntimeError) { updater(projects_path, llms_path, client).run }
      assert_includes error.message, "missing a Current Tools project list"
    end
  end

  def test_requires_llms_projects_section
    Dir.mktmpdir("projects-updater-test") do |root|
      projects_path = File.join(root, "projects.md")
      File.write(projects_path, fixture_projects_page)

      llms_path = File.join(root, "llms.txt")
      File.write(llms_path, "# Title\n")

      client = FakeClient.new(
        [repo("new-tool", created_at: "2026-06-08T05:00:00Z", description: "New project helper")]
      )

      error = assert_raises(RuntimeError) { updater(projects_path, llms_path, client).run }
      assert_includes error.message, "llms.txt is missing a Projects section"
    end
  end

  private

  def updater(projects_path, llms_path, client)
    ProjectsUpdater.new(
      owner: "jamesonstone",
      cutoff: CUTOFF,
      projects_path: projects_path,
      llms_path: llms_path,
      client: client
    )
  end

  def repo(name, created_at:, description:, fork: false, archived: false)
    {
      "name" => name,
      "html_url" => "https://github.com/jamesonstone/#{name}",
      "created_at" => created_at,
      "description" => description,
      "fork" => fork,
      "archived" => archived,
      "private" => false
    }
  end

  def with_fixture
    Dir.mktmpdir("projects-updater-test") do |root|
      projects_path = File.join(root, "projects.md")
      File.write(projects_path, fixture_projects_page)

      llms_path = File.join(root, "llms.txt")
      File.write(llms_path, fixture_llms_text)

      yield projects_path, llms_path
    end
  end

  def fixture_projects_page
    <<~MARKDOWN
      ---
      layout: default
      title: Projects
      permalink: /projects/
      ---

      # Projects

      ## Current Tools

      <ul class="project-list">
        <li><strong><a href="https://github.com/jamesonstone/duplicate-tool">duplicate-tool</a></strong>: Already listed.</li>
      </ul>

      ## Archive

      <ul class="project-list">
        <li><strong>old</strong>: Old project.</li>
      </ul>
    MARKDOWN
  end

  def fixture_llms_text
    <<~MARKDOWN
      # Jameson Stone

      > Test fixture.

      ## Projects

      - [duplicate-tool](https://github.com/jamesonstone/duplicate-tool): Already listed.

      ## Machine Indexes

      - [llms.txt](https://jamesonstone.github.io/llms.txt): Curated LLM entrypoint for this site.
    MARKDOWN
  end

  class FakeClient
    def initialize(repos, readmes = {}, html_urls = {})
      @repos = repos
      @readmes = readmes
      @html_urls = html_urls
    end

    def repositories(_owner)
      @repos.map do |repo|
        next repo unless @html_urls.key?(repo["name"])

        repo.merge("html_url" => @html_urls.fetch(repo["name"]))
      end
    end

    def readme_text(_owner, repo_name)
      @readmes[repo_name]
    end
  end
end
