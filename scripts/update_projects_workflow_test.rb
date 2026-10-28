#!/usr/bin/env ruby
# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require "fileutils"
require "open3"
require "yaml"

class UpdateProjectsWorkflowTest < Minitest::Test
  WORKFLOW = YAML.load_file(File.expand_path("../.github/workflows/update-projects.yml", __dir__))
  STEPS = WORKFLOW.fetch("jobs").fetch("update-projects").fetch("steps")

  def test_existing_branch_keeps_pending_changes_and_current_source
    with_repository do |root, source|
      prepare(root, source)
      assert_equal "pending\n", File.read(File.join(root, "pending.txt"))
      assert_equal "current\n", File.read(File.join(root, "current.txt"))
      assert_equal "GH-68 fixture", git(root, "log", "-1", "--format=%s", source).strip
      git(root, "merge-base", "--is-ancestor", "origin/automation/update-projects", "HEAD")
      git(root, "merge-base", "--is-ancestor", source, "HEAD")
    end
  end

  def test_missing_branch_starts_at_triggering_source
    with_repository(existing_branch: false) do |root, source|
      prepare(root, source)
      assert_equal source, git(root, "rev-parse", "HEAD").strip
    end
  end

  def test_conflict_stops_without_updating_remote_branch
    with_repository(conflict: true) do |root, source|
      remote_before = git(root, "rev-parse", "origin/automation/update-projects")
      _out, error, status = run_step(root, "Check out or create projects update branch", source)
      refute status.success?, error
      assert_equal remote_before, git(root, "rev-parse", "origin/automation/update-projects")
      assert_includes git(root, "status", "--porcelain"), "UU conflict.txt"
    end
  end

  def test_index_only_change_is_detected_and_both_outputs_are_delivered
    with_repository do |root, source|
      prepare(root, source)
      File.write(File.join(root, "llms.txt"), "repaired index\n")
      output = File.join(root, "step-output")
      _out, error, status = run_step(root, "Detect projects page changes", source, "GITHUB_OUTPUT" => output)
      assert status.success?, error
      assert_equal "changed=true\n", File.read(output)
      File.write(File.join(root, "projects.md"), "updated projects\n")
      bin = fake_gh(root)
      _out, error, status = run_step(root, "Create or update projects page pull request", source,
                                    "PATH" => "#{bin}:#{ENV.fetch('PATH')}", "GH_TEST_LOG" => File.join(root, "gh-log"))
      assert status.success?, error
      remote = git(root, "rev-parse", "origin/automation/update-projects").strip
      assert_equal "repaired index\n", git(root, "show", "#{remote}:llms.txt")
      assert_equal "updated projects\n", git(root, "show", "#{remote}:projects.md")
      assert_equal "pending\n", git(root, "show", "#{remote}:pending.txt")
      git(root, "merge-base", "--is-ancestor", source, remote)
      log = File.read(File.join(root, "gh-log"))
      assert_includes log, "--state open"
      assert_includes log, "pr create --base main --head automation/update-projects"

      _out, error, status = run_step(root, "Create or update projects page pull request", source,
                                    "PATH" => "#{bin}:#{ENV.fetch('PATH')}",
                                    "GH_TEST_LOG" => File.join(root, "gh-log"), "GH_TEST_OPEN_PR" => "123")
      assert status.success?, error
      assert_equal remote, git(root, "rev-parse", "HEAD").strip
      assert_includes File.read(File.join(root, "gh-log")), "pr edit 123"
    end
  end

  def test_committed_pending_output_is_validated_and_handed_off_without_empty_commit
    with_repository do |root, source|
      prepare(root, source)
      File.write(File.join(root, "llms.txt"), "pending committed index\n")
      git(root, "add", "llms.txt")
      git(root, "commit", "-m", "pending generated output")
      head = git(root, "rev-parse", "HEAD").strip
      output = File.join(root, "step-output")
      _out, error, status = run_step(root, "Detect projects page changes", source, "GITHUB_OUTPUT" => output)
      assert status.success?, error
      assert_equal "changed=true\n", File.read(output)
      bin = fake_gh(root)
      _out, error, status = run_step(root, "Create or update projects page pull request", source,
                                    "PATH" => "#{bin}:#{ENV.fetch('PATH')}", "GH_TEST_LOG" => File.join(root, "gh-log"))
      assert status.success?, error
      assert_equal head, git(root, "rev-parse", "HEAD").strip
      assert_equal head, git(root, "rev-parse", "origin/automation/update-projects").strip
      assert_includes File.read(File.join(root, "gh-log")), "pr create --base main --head automation/update-projects"
    end
  end

  private

  def fake_gh(root)
    bin = File.join(root, "fake-bin")
    Dir.mkdir(bin)
    File.write(File.join(bin, "gh"), <<~SHELL)
      #!/bin/sh
      echo "$*" >> "$GH_TEST_LOG"
      if [ "$1 $2" = "pr list" ]; then
        echo "${GH_TEST_OPEN_PR:-}"
      fi
    SHELL
    File.chmod(0o755, File.join(bin, "gh"))
    bin
  end

  def prepare(root, source)
    _out, error, status = run_step(root, "Check out or create projects update branch", source)
    assert status.success?, error
  end

  def run_step(root, name, source, extra_env = {})
    script = STEPS.find { |step| step["name"] == name }.fetch("run")
    Open3.capture3({ "UPDATE_BRANCH" => "automation/update-projects", "GITHUB_SHA" => source }.merge(extra_env),
                  "bash", "-euo", "pipefail", "-c", script, chdir: root)
  end

  def git(root, *args)
    out, error, status = Open3.capture3("git", *args, chdir: root)
    raise "git #{args.join(' ')}: #{error}" unless status.success?

    out
  end

  def with_repository(existing_branch: true, conflict: false)
    Dir.mktmpdir("projects-workflow-test") do |dir|
      remote = File.join(dir, "remote.git")
      root = File.join(dir, "work")
      Dir.mkdir(root)
      git(dir, "init", "--bare", remote)
      git(root, "init", "-b", "main")
      git(root, "config", "user.name", "Jameson Stone")
      git(root, "config", "user.email", "jameson@stone.tc")
      %w[projects.md llms.txt conflict.txt].each { |name| File.write(File.join(root, name), "base\n") }
      git(root, "add", "projects.md", "llms.txt", "conflict.txt")
      git(root, "commit", "-m", "fixture base")
      git(root, "remote", "add", "origin", remote)
      if existing_branch
        git(root, "switch", "-c", "pending-fixture")
        File.write(File.join(root, "pending.txt"), "pending\n")
        File.write(File.join(root, "conflict.txt"), "pending\n") if conflict
        git(root, "add", "pending.txt", "conflict.txt")
        git(root, "commit", "-m", "pending projects")
        git(root, "push", "origin", "HEAD:refs/heads/automation/update-projects")
        git(root, "switch", "main")
      end
      File.write(File.join(root, "current.txt"), "current\n")
      File.write(File.join(root, "conflict.txt"), "current\n") if conflict
      git(root, "add", "current.txt", "conflict.txt")
      git(root, "commit", "-m", "GH-68 fixture")
      source = git(root, "rev-parse", "HEAD").strip
      git(root, "push", "origin", "main")
      git(root, "fetch", "origin")
      yield root, source
    end
  end
end
