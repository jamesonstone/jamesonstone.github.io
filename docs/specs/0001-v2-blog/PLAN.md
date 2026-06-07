---
kit_metadata_version: 1
artifact: plan
feature:
  id: 0001
  slug: v2-blog
  dir: 0001-v2-blog
parallelization_mode: "rlm"
confidence: 96
unresolved_assumptions: 0
references:
  - id: spec
    name: v2 blog specification
    type: feature_doc
    target: docs/specs/0001-v2-blog/SPEC.md
    relation: constrains
    read_policy: must
    used_for: fixed feature contract, non-goals, acceptance criteria, and edge cases
    status: active
  - id: brainstorm
    name: v2 blog brainstorm
    type: feature_doc
    target: docs/specs/0001-v2-blog/BRAINSTORM.md
    relation: informs
    read_policy: must
    used_for: source repository findings, migration options, and resolved user decisions
    status: active
  - id: constitution
    name: Constitution
    type: repo_doc
    target: docs/CONSTITUTION.md
    relation: constrains
    read_policy: must
    used_for: spec-driven workflow classification and project-level constraints
    status: active
  - id: agents-readme
    name: Agent docs README
    type: repo_doc
    target: docs/agents/README.md
    relation: guides
    read_policy: must
    used_for: repo-local instruction routing and progressive loading
    status: active
  - id: workflows-doc
    name: Workflows doc
    type: repo_doc
    target: docs/agents/WORKFLOWS.md
    relation: guides
    read_policy: must
    used_for: source-of-truth order and plan-phase behavior
    status: active
  - id: guardrails-doc
    name: Guardrails doc
    type: repo_doc
    target: docs/agents/GUARDRAILS.md
    relation: guides
    read_policy: must
    used_for: completion bar, scaffold cleanup, validation, and doc-only scope
    status: active
  - id: tooling-doc
    name: Tooling doc
    type: repo_doc
    target: docs/agents/TOOLING.md
    relation: guides
    read_policy: must
    used_for: project-directory workflow and secondary input policy
    status: active
  - id: rlm-doc
    name: RLM doc
    type: repo_doc
    target: docs/agents/RLM.md
    relation: guides
    read_policy: must
    used_for: just-in-time prior-work and repository discovery
    status: active
  - id: kit-map
    name: Kit feature map
    type: command
    target: kit map 0001-v2-blog
    relation: informs
    read_policy: evidence
    used_for: phase check, artifact presence, and relationship check
    status: active
  - id: project-progress-summary
    name: Project progress summary
    type: repo_doc
    target: docs/PROJECT_PROGRESS_SUMMARY.md
    relation: informs
    read_policy: conditional
    used_for: RLM prior-work shortlist and plan-phase progress state
    status: active
  - id: current-site
    name: Current jamesonstone.github.io site
    type: repo
    target: /Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io
    relation: implements
    read_policy: must
    used_for: target file structure, legacy shell, current Jekyll dependency state, and documentation destinations
    status: active
  - id: current-gemfile
    name: Current Gemfile
    type: repo_file
    target: Gemfile
    relation: informs
    read_policy: must
    used_for: dependency refresh strategy
    status: active
  - id: current-gemfile-lock
    name: Current Gemfile lock
    type: repo_file
    target: Gemfile.lock
    relation: informs
    read_policy: must
    used_for: current GitHub Pages dependency state and local build validation expectations
    status: active
  - id: old-blog
    name: Deprecated legacy blog repo
    type: repo
    target: /Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io
    relation: informs
    read_policy: must
    used_for: migration source for public posts, paintings, project links, image assets, hidden drafts, and old domain evidence
    status: active
  - id: geohot-short-post-reference
    name: Geohot short Jekyll post reference
    type: url
    target: "https://geohot.github.io/blog/jekyll/update/2026/05/01/ai-will-create-jobs.html"
    relation: guides
    read_policy: evidence
    used_for: concise post reading shape, minimal chrome, and footer density
    status: active
  - id: github-pages-publishing-source
    name: GitHub Pages publishing source documentation
    type: url
    target: "https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site"
    relation: guides
    read_policy: evidence
    used_for: branch publishing versus custom GitHub Actions deployment tradeoff
    status: active
  - id: github-pages-jekyll-content
    name: GitHub Pages Jekyll content documentation
    type: url
    target: "https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-content-to-your-github-pages-site-using-jekyll"
    relation: guides
    read_policy: evidence
    used_for: pages, posts, Markdown front matter, and local preview expectations
    status: active
---
# PLAN

## SUMMARY

Implement `v2-blog` as a minimal Jekyll/GitHub Pages rebuild: replace the generated shell with shared layouts, Markdown pages, a dated post archive, copied legacy content assets, one CSS entrypoint, and README guidance for Codex-created posts. The implementation stays static and source-first, defaults to branch-based GitHub Pages publishing, and treats migration as controlled content normalization rather than a redesign of old posts.

## APPROACH

1. Use the fixed `SPEC.md` as the scope boundary.
   - The implementation should not add product scope that is not already present in the spec.
   - `BRAINSTORM.md` is evidence for why decisions were made, not a source for adding extra features.

2. Rebuild around native Jekyll conventions.
   - Keep the repository root as the Pages source.
   - Introduce `_config.yml` for site metadata, permalink policy, Markdown settings, and excludes.
   - Use `_layouts/default.html` for the global shell and `_layouts/post.html` for dated post pages.
   - Prefer Markdown pages for `index`, `blog`, `paintings`, `projects`, and `about` content.
   - Use one stylesheet at `assets/css/site.css`; old theme CSS should either be removed or disconnected from rendered pages.

3. Keep the deploy path boring.
   - Default to GitHub Pages branch publishing from the repository root because the site remains Jekyll-compatible and does not need a custom build pipeline.
   - Treat a custom Pages workflow as a fallback only if implementation finds a concrete requirement such as unsupported branch publishing behavior, unsupported plugins, or a reproducibility need that cannot be met by the default path.
   - Do not add `CNAME` during this feature.

4. Migrate content as archive material.
   - Public old-blog Markdown files become Jekyll posts under `_posts`.
   - Hidden dot-prefixed old-blog Markdown files remain excluded from navigation, copied content, and rendered output.
   - Old public post bodies should stay close to source, with only metadata, link, asset-path, Markdown compatibility, and identity-normalization edits needed for the new site.
   - Use old-repo Git history to derive dates where front matter is missing; mark uncertain dates with front matter metadata rather than inventing certainty.

5. Normalize identity without corrupting historical examples.
   - Current-facing profile links, account labels, and project-owner URLs should use `jamesonstone`.
   - Historical code examples, package names, registry strings, and archived prose should be preserved when rewriting would change the technical meaning; any remaining `jstone28` occurrences should be intentional, non-navigational, and reviewable.

6. Use a small but complete information architecture.
   - `Blog` is the primary archive and future post entrypoint.
   - `Paintings` is a visual archive sourced from linked old painting pages and image files.
   - `Projects` is a checked, lightweight list derived from the old homepage, with stale or uncertain links handled as archived rather than current.
   - `About` owns profile, contact, and footer-linked identity information.

7. Make new-post creation deterministic.
   - Document the post filename, front matter fields, optional image location, local preview command, and publish-on-push expectation in `README.md`.
   - Use README documentation as the future-post template rather than publishing a dummy example post.

## COMPONENTS

1. Site configuration
   - Owns title, description, permalink pattern, Markdown processor settings, excludes, and any defaults for posts or pages.
   - Must avoid custom plugins unless a later implementation finding justifies custom Actions deployment.

2. Layouts
   - `default` owns document structure, metadata, navigation, main content frame, and footer.
   - `post` owns title/date presentation, concise reading width, archive metadata, and previous/next or archive return affordances if used.

3. Content pages
   - Homepage provides direct entry into the blog-first site without marketing-page structure.
   - Blog archive lists posts by date and distinguishes current short posts from migrated archive material through metadata or section labeling.
   - Paintings page presents linked artwork with readable captions and stable image paths.
   - Projects page presents checked project links without overstating stale work as current.
   - About page holds contact and profile links.

4. Content migration
   - Converts public old-blog Markdown into Jekyll posts with front matter.
   - Copies only referenced blog images into the chosen asset namespace.
   - Copies linked painting pages and artwork into the chosen content and asset namespaces.
   - Performs targeted link and identity normalization.

5. Styling
   - A single CSS file defines typography, spacing, color tokens, code blocks, images, navigation, footer, and responsive behavior.
   - Visual detail should come from restrained color, link treatments, rhythm, and small accents, not JavaScript or heavy decorative assets.

6. Documentation
   - README explains local setup, preview, post creation, image placement, and publishing expectations.
   - Implementation notes, if needed, should stay concise and should not become a second source of truth for requirements.

## DATA

1. Post files
   - Location: `_posts/YYYY-MM-DD-slug.md`.
   - Required front matter: `layout: post`, `title`, `date`.
   - Recommended front matter: `archive: true` for migrated posts, `date_source`, `date_uncertain`, `excerpt`, and `tags` when useful.
   - Permalink behavior is controlled by `_config.yml` and must produce `/blog/YYYY/MM/DD/slug.html`.

2. Page files
   - Expected files: `index.md`, `blog/index.md`, `paintings/index.md`, `projects.md`, and `about.md`.
   - Page front matter should include `layout`, `title`, and `permalink` where the default path would be unclear.

3. Blog assets
   - Destination: `assets/images/blog/`.
   - Source: referenced files from `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/images`.
   - Markdown image paths in migrated posts should be rewritten to stable site-root paths.

4. Painting assets
   - Destination: `assets/images/paintings/`.
   - Source: linked painting JPEG files from `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/paintings`.
   - Unlinked painting JPEG files should remain out of scope unless implementation explicitly records why they are needed.

5. Excluded data
   - Dot-prefixed old-blog Markdown files are not copied into publishable content.
   - `_site`, old `params.json`, old `javascripts/scale.fix.js`, and old custom-domain files are not source data for the new site.

## INTERFACES

1. Local preview command
   - Input: repository root with Ruby dependencies installed.
   - Expected command shape: `bundle exec jekyll serve` for interactive preview and `bundle exec jekyll build` for deterministic build validation.
   - Output: generated Jekyll site in `_site` during validation only.
   - Side effect: `_site` may be generated locally and must remain untracked.

2. New-post authoring contract
   - Input: title, date, Markdown body, optional tags, optional excerpt, optional images.
   - Output: one `_posts/YYYY-MM-DD-slug.md` file plus optional assets under `assets/images/blog/`.
   - Side effect: pushing approved source changes publishes through GitHub Pages.

3. Content migration source contract
   - Input: public files listed by the old `blog/index.md`, linked painting Markdown pages, and their referenced image assets.
   - Output: normalized target Markdown files and copied assets in the new site.
   - Side effect: no mutation of `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io`.

4. Deployment contract
   - Input: committed source files on the configured Pages branch.
   - Output: GitHub Pages build and publish for `jamesonstone.github.io`.
   - Side effect: no domain cutover because `CNAME` is excluded from this feature.

5. Documentation contract
   - Input: final implementation choices and local build commands.
   - Output: README instructions that let a future Codex thread add a short post without rediscovering the workflow.

## DEPENDENCIES

References are tracked in front matter.

Implementation should use the existing repository, the deprecated legacy blog repository as read-only source material, GitHub Pages, Jekyll, Ruby/Bundler, Markdown, and local browser rendering for visual verification. No JavaScript framework, package manager for frontend assets, CMS, database, or external design system is part of the plan.

## RISKS

1. Old dependency lock may not build on a modern machine.
   - Mitigation: refresh `Gemfile.lock` against a current GitHub Pages-compatible dependency set, document the local Ruby/Bundler command, and avoid unsupported plugins.

2. Legacy posts may have missing or ambiguous dates.
   - Mitigation: derive dates from old-repo Git history, record `date_source`, and mark uncertainty explicitly when history is not conclusive.

3. Link and asset rewrites can silently break archive posts.
   - Mitigation: run build validation, scan generated output for missing local references, and spot-check migrated posts with images and cross-post links.

4. Identity normalization can damage historical technical content if applied blindly.
   - Mitigation: classify `jstone28` occurrences before rewriting; update current-facing profile/project links while preserving code examples or package identifiers where meaning depends on the old string.

5. Default branch publishing may conflict with current GitHub Pages settings.
   - Mitigation: keep the source structure compatible with default branch publishing and document any discovered need for custom Actions before adding workflow files.

6. Visual style can become decorative at the expense of reading.
   - Mitigation: validate rendered pages at desktop and mobile widths, keep the first viewport blog-first, and prioritize contrast, line length, spacing, and image behavior.

## TESTING

1. Build validation
   - Evidence: `bundle exec jekyll build` exits successfully.
   - Maps to: Jekyll structure, Markdown/front matter validity, permalink generation, and excluded hidden drafts.

2. Route and permalink validation
   - Evidence: generated post URLs under `_site/blog/YYYY/MM/DD/slug.html`.
   - Maps to: configured permalink contract and archive navigation.

3. Hidden-content validation
   - Evidence: generated output and navigation do not include `.zen-team`, `.walled-garden`, `.right-problem`, or `.prog-dev-eng`.
   - Maps to: hidden draft exclusion.

4. Link and asset validation
   - Evidence: migrated pages render images from `assets/images/blog/` or `assets/images/paintings/`, internal blog links resolve to migrated targets, and no copied page points at a missing local asset.
   - Maps to: archive migration correctness.

5. Identity validation
   - Evidence: current-facing profile/navigation/project links use `jamesonstone`; any remaining `jstone28` occurrences are reviewed and justified as historical archive or code content.
   - Maps to: username normalization without corrupting archival accuracy.

6. Scope validation
   - Evidence: no `CNAME`, custom Pages workflow, SPA framework, CMS, database, analytics, newsletter, comments, or search feature is introduced.
   - Maps to: non-goals and deployment baseline.

7. Documentation validation
   - Evidence: README includes local preview, new-post filename/front matter, optional image placement, and publish-on-push guidance.
   - Maps to: Codex-assisted post workflow.

8. Rendered visual validation
   - Evidence: local browser checks at mobile and desktop widths confirm readable line length, stable navigation, high contrast, non-overlapping text, and usable image scaling.
   - Maps to: visual design and responsiveness acceptance.
