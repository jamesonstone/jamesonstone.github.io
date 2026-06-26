#!/usr/bin/env ruby
# frozen_string_literal: true

require "base64"
require "cgi"
require "json"
require "net/http"
require "optparse"
require "time"
require "uri"

ROOT = File.expand_path("..", __dir__)

ProjectEntry = Struct.new(:name, :url, :description, keyword_init: true)

class GitHubClient
  def initialize(api_base: "https://api.github.com", token: nil)
    @api_base = api_base.delete_suffix("/")
    @token = token
  end

  def repositories(owner)
    repos = []
    page = 1

    loop do
      batch = get_json("/users/#{owner}/repos?per_page=100&page=#{page}&sort=created&direction=desc")
      break if batch.nil? || batch.empty?

      repos.concat(batch)
      break if batch.length < 100

      page += 1
    end

    repos
  end

  def readme_text(owner, repo_name)
    payload = get_json("/repos/#{owner}/#{repo_name}/readme")
    return nil unless payload && payload["content"]

    Base64.decode64(payload["content"])
  end

  private

  def get_json(path)
    uri = URI("#{@api_base}#{path}")
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/vnd.github+json"
    request["User-Agent"] = "jamesonstone.github.io-projects-updater"
    request["Authorization"] = "Bearer #{@token}" if @token && !@token.empty?

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    case response.code.to_i
    when 200
      JSON.parse(response.body)
    when 404
      nil
    else
      raise "GitHub API request failed: #{response.code} #{response.message} #{uri}"
    end
  end
end

class JsonRepoClient
  def initialize(path)
    @repos = JSON.parse(File.read(path))
  end

  def repositories(_owner)
    @repos
  end

  def readme_text(_owner, _repo_name)
    nil
  end
end

class ProjectsUpdater
  CURRENT_TOOLS_PATTERN = /
    (?<prefix>\#\#\s+Current\s+Tools\b.*?<ul\s+class="project-list">\n)
    (?<items>.*?)
    (?<suffix><\/ul>)
  /mx

  LLMS_PROJECTS_PATTERN = /
    (?<prefix>\#\#\s+Projects\b.*?\n\n)
    (?<items>.*?)
    (?<suffix>\n\#\#\s+Machine\s+Indexes\b)
  /mx

  def initialize(owner:, cutoff:, projects_path:, llms_path:, client:)
    @owner = owner
    @cutoff = Time.iso8601(cutoff)
    @projects_path = projects_path
    @llms_path = llms_path
    @client = client
  end

  def run(dry_run: false)
    projects_text = File.read(@projects_path)
    entries = new_entries(projects_text)
    return [] if entries.empty?

    updated_projects = insert_entries(projects_text, entries)
    updated_llms = insert_llms_entries(File.read(@llms_path), entries)

    unless dry_run
      File.write(@projects_path, updated_projects)
      File.write(@llms_path, updated_llms)
    end
    entries
  end

  private

  def new_entries(projects_text)
    existing_urls = projects_text.scan(%r{https://github\.com/#{Regexp.escape(@owner)}/[A-Za-z0-9_.-]+}).uniq

    @client.repositories(@owner)
           .select { |repo| eligible_repo?(repo) }
           .reject { |repo| existing_urls.include?(repo_url(repo)) }
           .sort_by { |repo| Time.iso8601(repo.fetch("created_at")) }
           .map { |repo| build_entry(repo) }
  end

  def eligible_repo?(repo)
    created_at = Time.iso8601(repo.fetch("created_at"))
    created_at >= @cutoff && !repo["fork"] && !repo["archived"] && repo["private"] != true
  rescue KeyError, ArgumentError
    false
  end

  def build_entry(repo)
    name = repo.fetch("name")
    ProjectEntry.new(
      name: name,
      url: repo_url(repo),
      description: description_for(repo)
    )
  end

  def repo_url(repo)
    repo["html_url"] || "https://github.com/#{@owner}/#{repo.fetch("name")}"
  end

  def description_for(repo)
    raw = repo["description"].to_s
    raw = first_readme_sentence(repo.fetch("name")).to_s if raw.strip.empty?
    raw = "A public project tracked from GitHub repository metadata." if raw.strip.empty?
    normalize_description(raw)
  end

  def first_readme_sentence(repo_name)
    text = @client.readme_text(@owner, repo_name)
    return nil unless text

    useful_paragraphs(text).each do |paragraph|
      sentence = paragraph.split(/(?<=[.!?])\s+/).first
      return sentence if sentence && sentence.match?(/[A-Za-z]{3}/)
    end

    nil
  end

  def useful_paragraphs(text)
    in_code = false
    blocks = []
    current = []

    text.each_line do |line|
      stripped = line.strip
      if stripped.start_with?("```")
        in_code = !in_code
        next
      end
      next if in_code
      next if stripped.start_with?("#")

      if stripped.empty?
        blocks << current.join(" ") unless current.empty?
        current = []
      else
        current << strip_markdown(stripped)
      end
    end

    blocks << current.join(" ") unless current.empty?
    blocks.map { |block| block.gsub(/\s+/, " ").strip }
          .select { |block| block.length >= 12 && block.match?(/[A-Za-z]{3}/) }
  end

  def strip_markdown(text)
    text.gsub(/\A#+\s*/, "")
        .gsub(/\*\*([^*]+)\*\*/, "\\1")
        .gsub(/`([^`]+)`/, "\\1")
        .gsub(/\[([^\]]+)\]\([^)]+\)/, "\\1")
        .strip
  end

  def normalize_description(text)
    cleaned = text.gsub(/[[:cntrl:]]/, " ")
                  .gsub(/\s+/, " ")
                  .gsub(/\A[^\p{Alnum}`]+/, "")
                  .strip
                  .delete_suffix(".")
    "#{cleaned}."
  end

  def insert_entries(text, entries)
    match = text.match(CURRENT_TOOLS_PATTERN)
    raise "projects page is missing a Current Tools project list" unless match

    rendered = entries.map { |entry| render_project_entry(entry) }.join("\n")
    text.sub(CURRENT_TOOLS_PATTERN) do
      "#{match[:prefix]}#{match[:items].rstrip}\n#{rendered}\n#{match[:suffix]}"
    end
  end

  def insert_llms_entries(text, entries)
    match = text.match(LLMS_PROJECTS_PATTERN)
    raise "llms.txt is missing a Projects section" unless match

    rendered = entries.map { |entry| render_llms_entry(entry) }.join("\n")
    text.sub(LLMS_PROJECTS_PATTERN) do
      "#{match[:prefix]}#{match[:items].rstrip}\n#{rendered}#{match[:suffix]}"
    end
  end

  def render_project_entry(entry)
    name = CGI.escapeHTML(entry.name)
    url = CGI.escapeHTML(entry.url)
    description = CGI.escapeHTML(entry.description)

    "  <li><strong><a href=\"#{url}\">#{name}</a></strong>: #{description}</li>"
  end

  def render_llms_entry(entry)
    name = markdown_text(entry.name)
    url = entry.url
    description = markdown_text(entry.description)

    "- [#{name}](#{url}): #{description}"
  end

  def markdown_text(text)
    CGI.escapeHTML(text).gsub(/([\\`*_{}\[\]()])/, "\\\\\\1")
  end
end

def parse_options(argv)
  options = {
    owner: ENV.fetch("PROJECTS_OWNER", "jamesonstone"),
    cutoff: ENV.fetch("PROJECTS_CUTOFF", "2026-06-08T00:00:00-04:00"),
    projects_path: File.join(ROOT, "projects.md"),
    llms_path: File.join(ROOT, "llms.txt"),
    repos_json: nil,
    dry_run: false
  }

  OptionParser.new do |parser|
    parser.banner = "Usage: update_projects_from_github.rb [options]"
    parser.on("--owner OWNER", "GitHub owner to inspect") { |value| options[:owner] = value }
    parser.on("--cutoff ISO8601", "Repository created_at cutoff") { |value| options[:cutoff] = value }
    parser.on("--projects PATH", "Projects page path") { |value| options[:projects_path] = value }
    parser.on("--llms PATH", "llms.txt path to keep in sync") { |value| options[:llms_path] = value }
    parser.on("--repos-json PATH", "Read repository JSON from a file instead of GitHub") { |value| options[:repos_json] = value }
    parser.on("--dry-run", "Print planned additions without writing projects.md") { options[:dry_run] = true }
  end.parse!(argv)

  options
end

if $PROGRAM_NAME == __FILE__
  options = parse_options(ARGV)
  token = ENV["GH_TOKEN"] || ENV["GITHUB_TOKEN"]
  client = options[:repos_json] ? JsonRepoClient.new(options[:repos_json]) : GitHubClient.new(token: token)
  updater = ProjectsUpdater.new(
    owner: options[:owner],
    cutoff: options[:cutoff],
    projects_path: options[:projects_path],
    llms_path: options[:llms_path],
    client: client
  )

  entries = updater.run(dry_run: options[:dry_run])
  if entries.empty?
    puts "No new repositories found."
  else
    puts "Added #{entries.length} project#{entries.length == 1 ? "" : "s"}:"
    entries.each { |entry| puts "- #{entry.name}: #{entry.description}" }
  end
end
