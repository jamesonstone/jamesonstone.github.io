---
kit_metadata_version: 1
artifact: spec
feature:
  id: 0001
  slug: v2-blog
  dir: 0001-v2-blog
parallelization_mode: "rlm"
confidence: 96
unresolved_assumptions: 0
skills:
  - id: rlm
    name: RLM
    path: docs/agents/RLM.md
    trigger: Use for broad repository analysis, prior-feature discovery, scan repository requests, large repository analysis, analyze codebase requests, and recursive language model context routing when full-context loading would be noisy.
    used_for: Bound discovery to the current feature, explicit references, and source-attributed facts before planning or implementation.
    status: active
references:
  - id: brainstorm
    name: v2 blog brainstorm
    type: feature_doc
    target: docs/specs/0001-v2-blog/BRAINSTORM.md
    relation: informs
    read_policy: must
    used_for: validated user decisions, codebase findings, migration scope, and recommended strategy
    status: active
  - id: constitution
    name: Constitution
    type: repo_doc
    target: docs/CONSTITUTION.md
    relation: constrains
    read_policy: must
    used_for: spec-driven workflow classification and project constraints
    status: active
  - id: agents-entrypoint
    name: AGENTS entrypoint
    type: repo_doc
    target: AGENTS.md
    relation: guides
    read_policy: must
    used_for: repository instruction routing
    status: active
  - id: claude-entrypoint
    name: CLAUDE entrypoint
    type: repo_doc
    target: CLAUDE.md
    relation: guides
    read_policy: must
    used_for: repository instruction routing
    status: active
  - id: copilot-entrypoint
    name: Copilot instruction entrypoint
    type: repo_doc
    target: .github/copilot-instructions.md
    relation: guides
    read_policy: must
    used_for: repository instruction routing
    status: active
  - id: agents-readme
    name: Agent docs README
    type: repo_doc
    target: docs/agents/README.md
    relation: guides
    read_policy: must
    used_for: repo-local instruction navigation and read order
    status: active
  - id: workflows-doc
    name: Workflows doc
    type: repo_doc
    target: docs/agents/WORKFLOWS.md
    relation: guides
    read_policy: must
    used_for: spec-driven workflow and clarification requirements
    status: active
  - id: guardrails-doc
    name: Guardrails doc
    type: repo_doc
    target: docs/agents/GUARDRAILS.md
    relation: guides
    read_policy: must
    used_for: documentation completion bar and safety constraints
    status: active
  - id: tooling-doc
    name: Tooling doc
    type: repo_doc
    target: docs/agents/TOOLING.md
    relation: guides
    read_policy: must
    used_for: project-directory workflow, skills discovery, and secondary input policy
    status: active
  - id: rlm-doc
    name: RLM doc
    type: repo_doc
    target: docs/agents/RLM.md
    relation: guides
    read_policy: must
    used_for: just-in-time prior-work pass and bounded repository discovery
    status: active
  - id: references-readme
    name: References README
    type: repo_doc
    target: docs/references/README.md
    relation: guides
    read_policy: conditional
    used_for: durable reference routing and front matter reference expectations
    status: active
  - id: kit-map
    name: Kit feature map
    type: command
    target: kit map 0001-v2-blog
    relation: informs
    read_policy: evidence
    used_for: current feature artifact state, relationship check, and reference resolution
    status: active
  - id: project-progress-summary
    name: Project progress summary
    type: repo_doc
    target: docs/PROJECT_PROGRESS_SUMMARY.md
    relation: informs
    read_policy: conditional
    used_for: RLM shortlist for prior feature relevance and current feature phase
    status: active
  - id: current-site
    name: Current jamesonstone.github.io site
    type: repo
    target: /Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io
    relation: implements
    read_policy: must
    used_for: target repository structure, current Jekyll and GitHub Pages baseline, legacy assets, and future affected file list
    status: active
  - id: old-blog
    name: Deprecated legacy blog repo
    type: repo
    target: /Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io
    relation: informs
    read_policy: must
    used_for: old blog content inventory, information architecture, paintings and image assets, hidden draft handling, username migration source, and migration scope
    status: active
  - id: geohot-short-post-reference
    name: Geohot short Jekyll post reference
    type: url
    target: "https://geohot.github.io/blog/jekyll/update/2026/05/01/ai-will-create-jobs.html"
    relation: guides
    read_policy: evidence
    used_for: concise post shape reference including title, date, short body, minimal chrome, and simple footer
    status: active
  - id: github-pages-publishing-source
    name: GitHub Pages publishing source documentation
    type: url
    target: "https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site"
    relation: guides
    read_policy: evidence
    used_for: deployment-source options, branch publishing behavior, and custom GitHub Actions publishing tradeoffs
    status: active
  - id: github-pages-jekyll-content
    name: GitHub Pages Jekyll content documentation
    type: url
    target: "https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-content-to-your-github-pages-site-using-jekyll"
    relation: guides
    read_policy: evidence
    used_for: Jekyll pages, posts, Markdown front matter, and Codex-created post workflow
    status: active
---
# SPEC

## SUMMARY

Rebuild `jamesonstone.github.io` as a source-first, readable Jekyll blog for concise Markdown posts, with public legacy `jstone28.github.io` content migrated into archives. The feature must keep deployment low-friction through GitHub Pages, exclude unpublished hidden drafts, normalize public identity to `jamesonstone`, and avoid unnecessary app or frontend build complexity.

## PROBLEM

The current site is an old generated GitHub Pages shell rather than a useful personal blog. It still carries starter-template content, stale `jstone28` identity links, legacy theme assets, a single Textile post, and no clear Codex-friendly path for creating and publishing short Markdown posts.

The deprecated `jstone28.github.io` repository contains the useful public blog, project, painting, profile, and contact content, but its old identity, theme, custom domain, and hidden draft files should not be copied wholesale into the new site.

## GOALS

1. Replace the legacy generated shell with a readable, whimsical but restrained, blog-first site.
2. Make new posts easy for Codex to create as short Markdown entries with YAML front matter.
3. Preserve public legacy blog posts and paintings as archive content without rewriting them into the new short-post style.
4. Normalize public-facing account, profile, and repository-owner references from `jstone28` to `jamesonstone` where copied content is presented as current.
5. Publish first at `jamesonstone.github.io` using the lowest-friction GitHub Pages path that satisfies the feature.
6. Keep the information architecture small: `Blog`, `Paintings`, `Projects`, and `About`.
7. Keep the site static, fast, high contrast, responsive, and readable without app-like JavaScript or an unnecessary frontend framework.

## NON-GOALS

1. Do not publish dot-prefixed Markdown files from the old blog unless separately approved.
2. Do not copy the old `axiomatic.dev` `CNAME` or perform custom-domain cutover in this feature.
3. Do not modify the deprecated `jstone28.github.io` repository for redirects or deprecation messaging in the first implementation.
4. Do not add comments, newsletter signup, analytics, search indexing, CMS behavior, database storage, server runtime, SPA architecture, or a frontend JavaScript build pipeline.
5. Do not preserve the old generated GitHub Pages shell, orderedlist theme behavior, or `jekyll-theme-hacker` identity as the new visual direction.
6. Do not present stale old project links as current featured work without checking them during implementation.

## USERS

1. Jameson Stone, who needs a simple source-first site and a repeatable Codex-assisted post publishing workflow.
2. Readers visiting the public blog, archive posts, paintings, projects, and about/contact pages.
3. Future coding agents maintaining the site, adding posts, or migrating archive content from the old repository.

## SKILLS

Skills are tracked in canonical front matter.

The selected skill is `rlm`, backed by `docs/agents/RLM.md`, because this feature has noisy prior context, source-repository migration decisions, and explicit references that should be loaded just in time instead of through broad repository scans.

## RELATIONSHIPS

Relationships are tracked in canonical front matter.

No explicit feature relationship is required. `kit map 0001-v2-blog` reports no incoming relationships and no outgoing relationships, and this is the first feature in this repository.

## DEPENDENCIES

References are tracked in canonical front matter.

The feature depends on GitHub Pages and Jekyll as the publishing and content model, Markdown files with YAML front matter as the authoring contract, and public content/assets from the deprecated `jstone28.github.io` repository as migration source material. No additional runtime service, frontend framework, CMS, database, external design system, or required custom GitHub Actions workflow is part of the baseline contract.

## REQUIREMENTS

1. The site must use a source-first Jekyll structure suitable for GitHub Pages and future Markdown post authoring.
2. The blog post URL shape must be `/blog/YYYY/MM/DD/slug.html`.
3. New posts must be authored as concise Markdown posts with front matter containing the data needed to render title, date, layout, and optional classification or excerpt metadata.
4. The homepage must make the new blog identity clear and provide direct navigation to `Blog`, `Paintings`, `Projects`, and `About`.
5. The blog archive must list migrated public posts and future posts in a clear dated reading order.
6. Public legacy blog posts from the old repository must be migrated as archive material mostly verbatim, with only necessary formatting, metadata, link, asset-path, and public-identity normalization changes.
7. Dot-prefixed old-blog Markdown files must remain unpublished and out of the migration unless a later approval explicitly changes scope.
8. Migrated posts without reliable front matter dates must derive dates from old-repo Git history when practical and mark uncertainty in metadata or implementation notes when the date cannot be proven.
9. Painting pages and linked painting assets from the old repository must be represented as a visual archive.
10. Old image assets must be copied only when referenced by migrated public pages or explicitly needed by the new site.
11. Public-facing `jstone28` profile, account, and repository-owner references in copied current-facing content must be normalized to `jamesonstone`; `jstone28.github.io` may remain only as historical source-repository evidence in documentation or migration notes.
12. The site must not include generated legacy artifacts such as `_site`, `params.json`, or `javascripts/scale.fix.js`.
13. Deployment must default to GitHub Pages publishing on push without a custom Pages workflow unless implementation discovers a concrete need for custom Actions behavior.
14. The implementation must document local preview and the Codex-assisted new-post workflow.
15. The visual design must be whimsical but restrained, high contrast, readable, responsive, and blog-first, with no marketing-style landing page or heavy decorative treatment that competes with reading.
16. The implementation must keep product code, templates, styles, and content structure minimal and explicit.

## ACCEPTANCE

1. A local Jekyll preview can build and render the site without publishing hidden draft files.
2. The homepage, blog archive, at least one migrated long-form archive post, at least one future-style concise post example or documented template, paintings archive, projects page, and about/contact page render through the new shared site structure.
3. Blog post permalinks follow `/blog/YYYY/MM/DD/slug.html`.
4. Public migrated content has working internal links and image references after migration.
5. Dot-prefixed old-blog Markdown files are absent from rendered output and navigation.
6. Public-facing current identity uses `jamesonstone`; stale `jstone28` profile links are removed or rewritten except where preserved only as historical source evidence.
7. The old `axiomatic.dev` `CNAME` is not added to the target repository.
8. The deprecated `jstone28.github.io` repository is not modified.
9. No SPA framework, database, CMS, analytics, newsletter, comment system, or required custom JavaScript build tool is introduced.
10. The documented deploy path explains whether the feature uses default GitHub Pages branch publishing or a custom Actions workflow, and any custom workflow must be justified by a concrete requirement discovered during implementation.
11. README or equivalent supporting documentation explains local preview and the repeatable Codex-created post flow.
12. Visual verification confirms the site is readable, responsive, high contrast, and not dominated by a single low-contrast or overly decorative palette.

## EDGE-CASES

1. If an old public post lacks a trustworthy date, use Git history when practical and preserve uncertainty rather than inventing a confident date.
2. If an old post references an image that is missing or untracked, keep the post migration blocked until the missing asset is resolved or the broken reference is explicitly accepted.
3. If an old project/profile link is stale or still points at `jstone28`, do not present it as current without checking and normalizing or labeling it appropriately.
4. If default GitHub Pages publishing cannot support the final source structure, document the reason and treat a custom GitHub Actions Pages workflow as an implementation decision requiring clear justification.
5. If a migrated archive post requires format cleanup, preserve meaning and provenance rather than rewriting tone or shortening it to match future posts.
6. If a public old-blog page links to hidden dot-prefixed content, omit that hidden target from navigation and do not publish it without explicit approval.
7. If painting image dimensions or file sizes create poor rendering or performance, keep the source artwork intact and use layout constraints or optimized derived assets only when the implementation plan explicitly accounts for provenance.

## OPEN-QUESTIONS

none
