#!/usr/bin/env ruby
# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"

require_relative "update_projects_from_github"

class UpdateProjectsFromGithubTest < Minitest::Test
  CUTOFF = "2026-06-08T00:00:00-04:00"

  def test_adds_new_public_non_duplicate_repositories
    with_projects_page do |path|
      client = FakeClient.new(
        [
          repo("old-tool", created_at: "2026-06-08T03:59:59Z", description: "Too old"),
          repo("duplicate-tool", created_at: "2026-06-08T05:00:00Z", description: "Already listed"),
          repo("fork-tool", created_at: "2026-06-08T05:00:00Z", description: "Fork", fork: true),
          repo("archived-tool", created_at: "2026-06-08T05:00:00Z", description: "Archived", archived: true),
          repo("new-tool", created_at: "2026-06-08T05:00:00Z", description: "🧪 New project helper")
        ]
      )

      entries = updater(path, client).run
      text = File.read(path)

      assert_equal ["new-tool"], entries.map(&:name)
      assert_includes text, '<a href="https://github.com/jamesonstone/new-tool">new-tool</a>'
      assert_includes text, "New project helper."
      refute_includes text, "fork-tool"
      refute_includes text, "archived-tool"
      assert_equal 1, text.scan(%r{<a href="https://github.com/jamesonstone/duplicate-tool">duplicate-tool</a>}).length
    end
  end

  def test_uses_readme_sentence_when_description_is_missing
    with_projects_page do |path|
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

      entries = updater(path, client).run
      text = File.read(path)

      assert_equal ["readme-tool"], entries.map(&:name)
      assert_includes text, "readme-tool keeps small project notes synchronized."
    end
  end

  def test_dry_run_reports_entries_without_writing
    with_projects_page do |path|
      original = File.read(path)
      client = FakeClient.new(
        [repo("dry-run-tool", created_at: "2026-06-08T05:00:00Z", description: "Dry run helper")]
      )

      entries = updater(path, client).run(dry_run: true)

      assert_equal ["dry-run-tool"], entries.map(&:name)
      assert_equal original, File.read(path)
    end
  end

  def test_requires_current_tools_list
    Dir.mktmpdir("projects-updater-test") do |root|
      path = File.join(root, "projects.md")
      File.write(path, "# Projects\n")
      client = FakeClient.new(
        [repo("new-tool", created_at: "2026-06-08T05:00:00Z", description: "New project helper")]
      )

      error = assert_raises(RuntimeError) { updater(path, client).run }
      assert_includes error.message, "missing a Current Tools project list"
    end
  end

  private

  def updater(path, client)
    ProjectsUpdater.new(owner: "jamesonstone", cutoff: CUTOFF, projects_path: path, client: client)
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

  def with_projects_page
    Dir.mktmpdir("projects-updater-test") do |root|
      path = File.join(root, "projects.md")
      File.write(path, <<~MARKDOWN)
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

      yield path
    end
  end

  class FakeClient
    def initialize(repos, readmes = {})
      @repos = repos
      @readmes = readmes
    end

    def repositories(_owner)
      @repos
    end

    def readme_text(_owner, repo_name)
      @readmes[repo_name]
    end
  end
end
