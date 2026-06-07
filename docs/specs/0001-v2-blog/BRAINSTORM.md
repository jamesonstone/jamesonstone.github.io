---
kit_metadata_version: 1
artifact: brainstorm
feature:
  id: 0001
  slug: v2-blog
  dir: 0001-v2-blog
references:
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
    used_for: spec-driven brainstorm workflow and clarification requirements
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
    used_for: project-directory workflow and secondary input policy
    status: active
  - id: rlm-doc
    name: RLM doc
    type: repo_doc
    target: docs/agents/RLM.md
    relation: guides
    read_policy: must
    used_for: just-in-time prior-work pass and bounded repository discovery
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
  - id: feature-notes
    name: Feature notes
    type: notes
    target: docs/notes/0001-v2-blog
    relation: informs
    read_policy: conditional
    used_for: optional pre-brainstorm research input; no usable non-placeholder note files existed during this pass
    status: optional
  - id: current-site
    name: Current jamesonstone.github.io site
    type: repo
    target: /Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io
    relation: implements
    read_policy: must
    used_for: target repository structure, current Jekyll/GitHub Pages baseline, legacy assets, and future affected file list
    status: active
  - id: old-blog
    name: Deprecated legacy blog repo
    type: repo
    target: /Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io
    relation: informs
    read_policy: must
    used_for: old blog content inventory, information architecture, paintings/assets, hidden draft handling, username migration source, and migration scope
    status: active
  - id: geohot-short-post-reference
    name: Geohot short Jekyll post reference
    type: url
    target: "https://geohot.github.io/blog/jekyll/update/2026/05/01/ai-will-create-jobs.html"
    relation: guides
    read_policy: evidence
    used_for: "concise post format reference: title, date, short body, minimal chrome, and simple blog footer"
    status: active
  - id: github-pages-publishing-source
    name: GitHub Pages publishing source documentation
    type: url
    target: "https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site"
    relation: guides
    read_policy: evidence
    used_for: deployment-source options and custom GitHub Actions publishing tradeoffs
    status: active
  - id: github-pages-jekyll-content
    name: GitHub Pages Jekyll content documentation
    type: url
    target: "https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-content-to-your-github-pages-site-using-jekyll"
    relation: guides
    read_policy: evidence
    used_for: Jekyll front matter, page/post authoring model, and Codex-created post workflow
    status: active
---
# BRAINSTORM

## SUMMARY

This feature should replace the current legacy GitHub Pages shell in `jamesonstone.github.io` with a source-first, easy-to-read Jekyll blog optimized for short Markdown posts and automatic deployment on push. The implementation should migrate public content from the legacy `jstone28.github.io` source path, keep hidden drafts unpublished, normalize public identity to `jamesonstone`, and preserve old long-form posts as archive material while making new entries concise.

## USER THESIS

Populate this `BRAINSTORM.md` with the information from the previous brainstorm artifact. The old artifact was accidentally deleted, so this file is reconstructed from the current conversation context plus a bounded live inspection of:

1. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io`
2. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io`

Recovered user thesis from the deleted brainstorm context:

1. Update this project to include a new whimsical, easy-to-read website.
2. Use modern readable formatting, style, and color.
3. Organize the site around the content in `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io`, which is the existing blog intended for deprecation.
4. Optimize the new blog around an easy deploy pipeline where Codex thread actions can create blog posts and publish them quickly.
5. Use the short-post style represented by `https://geohot.github.io/blog/jekyll/update/2026/05/01/ai-will-create-jobs.html`: title, date, short body, minimal chrome, and direct prose.
6. Normalize public username/profile/repo-owner naming from `jstone28` to `jamesonstone` because the GitHub username changed. The literal `jstone28.github.io` name remains only as the historical source repository path.

Resolved user approvals from the prior clarification batch:

1. Launch the new site at `jamesonstone.github.io` first, without copying the old `axiomatic.dev` `CNAME` yet.
2. Migrate only public old-blog pages and paintings by default; exclude dot-prefixed Markdown files such as `.zen-team.md` unless explicitly approved later.
3. Preserve old public posts mostly verbatim as archive content; use the concise style for new posts.
4. Use URLs shaped like `/blog/YYYY/MM/DD/slug.html`.
5. Derive migrated post dates from old repo Git history when no front matter date exists, marking uncertainty when needed.
6. Keep the visual style whimsical but restrained, readable, high contrast, and blog-first.
7. Use default GitHub Pages Jekyll publishing on push for the first deploy pipeline.
8. Remove generated legacy artifacts immediately from `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io`: `_site`, `params.json`, and `javascripts/scale.fix.js`.
9. Keep redirects or deprecation changes in `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io` out of first implementation scope.
10. Use top-level navigation `Blog`, `Paintings`, `Projects`, and `About`, with contact/profile links inside `About` and the footer.

## RELATIONSHIPS

Relationships are tracked in front matter.

No explicit feature relationship is required.

1. `kit map 0001-v2-blog` reports no incoming relationships and no outgoing relationships.
2. `docs/PROJECT_PROGRESS_SUMMARY.md` shows this is the first feature in this repository and is in brainstorm phase.
3. The deleted prior brainstorm was a staging artifact in another planning context; it is source evidence for this reconstructed document, not a separate canonical feature dependency in this repo.

## CODEBASE FINDINGS

1. The active feature docs are in brainstorm phase only.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/docs/specs/0001-v2-blog/BRAINSTORM.md` is the current feature artifact.
   - `kit map 0001-v2-blog` reports `BRAINSTORM.md` present and `SPEC.md`, `PLAN.md`, `TASKS.md`, and `ANALYSIS.md` missing.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/docs/notes/0001-v2-blog` contains only `.gitkeep`, so there are no durable note conclusions to copy.

2. Repo workflow constraints limit this pass to research and documentation.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/docs/CONSTITUTION.md` is still mostly the Kit scaffold, but it identifies `docs/CONSTITUTION.md` as the canonical project contract and classifies substantial feature work as spec-driven.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/docs/agents/WORKFLOWS.md` requires clarification until confidence is high and unresolved assumptions are zero.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/docs/agents/GUARDRAILS.md` requires required brainstorm sections to be populated and canonical front matter references/relationships to stay current.
   - No product code, runtime config, generated output, or implementation files should be modified during this brainstorm step.

3. The target `jamesonstone.github.io` repository is a small legacy GitHub Pages/Jekyll site.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/Gemfile` declares only `gem 'github-pages'`.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/Gemfile.lock` pins the old `github-pages (20)` stack with `jekyll (1.5.1)`, `RedCloth`, and legacy Markdown/rendering dependencies.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/index.html` is an old generated GitHub Pages theme shell. It still includes placeholder copy, `{{ content }}`, a `Click here!` heading, a fixed sidebar layout, and a stale profile link to `https://github.com/jstone28`.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/stylesheets/styles.css` is old orderedlist-style fixed sidebar CSS using Lato from Google Fonts and 2010s GitHub Pages styling.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_posts/2014-07-05-first-post.textile` is the only source post and uses Textile, not Markdown.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_site`, `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/params.json`, and `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/javascripts/scale.fix.js` were removed after explicit approval because they are generated or old-theme artifacts.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/.github` exists from the Kit/bootstrap setup, but the target site still has no confirmed custom Pages deployment workflow requirement.

4. The deprecated legacy blog repo is the practical content and structure source.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/_config.yml` sets `theme: jekyll-theme-hacker`, `name: Axiomatic[Dev]`, and `title: Axiomatic[Dev]`.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/index.md` organizes content into Blogs, Painting, Projects, Profiles, and Contact.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/index.md` contains public username/profile naming such as `gitlab/jstone28`, `github/jstone28`, and GitLab/GitHub project URLs under `jstone28`; copied public-facing identity should become `jamesonstone`.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog/index.md` lists 13 public post links plus one external previous-work link.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog` also contains four dot-prefixed Markdown files: `.zen-team.md`, `.walled-garden.md`, `.right-problem.md`, and `.prog-dev-eng.md`.
   - Dot-prefixed Markdown files are treated as drafts or intentionally unpublished by default because they are hidden files and were excluded by explicit user approval.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/paintings/index.md` lists three painting pages: `amoteofdust.md`, `continuity.md`, and `thelightthat.md`.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/paintings` contains five JPEG files: `amoteofdust.jpg`, `continuity.jpg`, `mindandtime.jpg`, `thelightthatbeckons.jpg`, and `vision.jpg`; only three are linked by current painting Markdown pages.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/images` contains 24 blog-support images referenced by public posts.
   - `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/CNAME` contains `axiomatic.dev`; the target repo should not copy this until domain cutover is explicitly approved.

5. The old public blog content is longer-form than the desired future format.
   - Public old blog files range from 19 to 424 lines, excluding `blog/index.md`.
   - Longer technical tutorial/archive posts include `avro-schema.md`, `kotlinconsumer.md`, `compose-kafka.md`, `pt1-k8s-dashboard.md`, `pt2-k8s-dashboard.md`, `debezium.md`, `kubeless.md`, `makefile-semver.md`, and `post-commit-semver.md`.
   - Shorter essay-style archive posts include `team-slack.md`, `manage-struct.md`, `i-hop.md`, and `weather-pre.md`.
   - The implementation should preserve public posts as archive material instead of rewriting old posts into the future short-post style.

6. The desired post format is intentionally small.
   - The geohot reference supports a reading surface with title, date, compact body paragraphs, sparse navigation, and a small footer/blog identity.
   - The useful requirement is short, direct, easy-to-scan post shape, not copying the visual identity, exact taxonomy, or prose tone of the reference site.
   - No newsletter workflow, comments system, search index, analytics, or app-like JavaScript is justified for v2.

7. GitHub Pages and Jekyll remain the lowest-friction deployment fit.
   - GitHub Pages can publish from a configured branch/folder or from custom GitHub Actions.
   - GitHub Pages Jekyll supports pages and posts with YAML front matter, which maps directly to a Codex-created Markdown post workflow.
   - The simplest production path is: Codex creates `_posts/YYYY-MM-DD-slug.md`, optional images are added, changes are committed and pushed after approval, and GitHub Pages publishes on push.
   - A custom `.github/workflows/pages.yml` should remain optional unless default Pages publishing cannot satisfy local build/version/deploy requirements.

8. The information architecture should stay small.
   - Primary navigation should be `Blog`, `Paintings`, `Projects`, and `About`.
   - Contact/profile links should live in `About` and the footer.
   - Old blog posts should become a dated archive under `/blog/`.
   - Paintings should become a visual archive under `/paintings/`.
   - Projects from the old homepage can be preserved as a lightweight list, but stale links should be checked during implementation before being presented as current featured work.

9. The frontend implementation should avoid unnecessary complexity.
   - A static Jekyll site with layouts, minimal includes if needed, one CSS entrypoint, and Markdown posts is enough.
   - React, SPA architecture, server runtime, database, CMS, client-side search, and build-time JavaScript are not justified by the feature.
   - The whimsical visual direction can be achieved through typography, spacing, contrast, color tokens, link treatments, and small design details.
   - Performance should stay strong because the site can ship as static HTML/CSS with content images only.

10. Current understanding is 96%.
   - The prior clarification batch resolved launch domain, hidden-draft handling, archive strategy, URL shape, date derivation, visual direction, deployment default, old-repo deprecation scope, navigation shape, cleanup of generated artifacts, and public username normalization.

## AFFECTED FILES

Target repository files likely affected in the later implementation phase:

1. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_config.yml`
   - Likely new file for site title, description, permalink policy, Markdown settings, defaults, and optional collections.
2. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/Gemfile`
   - Likely update to a modern GitHub Pages compatible dependency declaration or a pinned local Jekyll stack.
3. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/Gemfile.lock`
   - Likely regenerated if the implementation updates dependencies; currently locks very old GitHub Pages/Jekyll versions.
4. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/index.html`
   - Likely replace with `index.md` or a cleaner Liquid/HTML homepage using the new layout.
5. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_layouts/default.html`
   - Likely new site shell for shared header, navigation, content, and footer.
6. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_layouts/post.html`
   - Likely new blog post layout optimized for concise entries.
7. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/stylesheets/styles.css`
   - Likely replace with the new readable, whimsical visual system or move to `assets/css/site.css`.
8. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/stylesheets/pygment_trac.css`
   - Likely remove or stop using if syntax styling is handled by the new CSS.
9. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_posts/2014-07-05-first-post.textile`
   - Likely remove or convert; Textile is inconsistent with the desired Markdown-based Codex authoring workflow.
10. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_posts/*.md`
    - Likely destination for migrated public posts and future short Codex-created posts.
11. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/blog/index.md`
    - Likely new archive page listing old and new posts.
12. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/paintings/index.md`
    - Likely new paintings archive if old paintings are migrated.
13. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/assets/images` or `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/images`
    - Likely destination for old blog images. The implementation should choose one path and update references consistently.
14. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/CNAME`
    - Optional and deferred. Needed only if the new site should take over `axiomatic.dev` or another custom domain.
15. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/.github/workflows/pages.yml`
    - Optional and deferred. Needed only if the implementation chooses custom GitHub Actions publishing instead of GitHub Pages default Jekyll publishing.
16. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/README.md`
    - Should document local preview and the Codex-friendly new-post workflow.
17. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/_site`
    - Already removed after explicit approval because it was generated output.
18. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/params.json`
    - Already removed after explicit approval because it was legacy GitHub Pages generator metadata.
19. `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io/javascripts/scale.fix.js`
    - Already removed after explicit approval because it belonged to the old orderedlist theme.

Source repository files that should inform migration, but should not be modified by this feature unless explicitly approved:

1. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/index.md`
   - Old information architecture source and public identity normalization source.
2. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog/index.md`
   - Public blog table of contents and old post list.
3. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog/*.md`
   - Public old post source content.
4. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog/.*.md`
   - Hidden draft or unpublished post candidates; migration is excluded by default.
5. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/images/*`
   - Public old post image assets.
6. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/paintings/*.md`
   - Old paintings page content.
7. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/paintings/*.jpg`
   - Old paintings image assets.
8. `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/CNAME`
   - Existing old-site custom domain evidence; do not copy yet.

## DEPENDENCIES

References are tracked in front matter.

Implementation dependencies are expected to stay small:

1. GitHub Pages and Jekyll are sufficient for the initial implementation.
2. Markdown with YAML front matter should be the authoring contract for future posts.
3. No JavaScript framework, backend service, package manager for frontend assets, database, CMS, or external design system is currently justified.
4. Optional GitHub Actions Pages deployment remains a deployment strategy decision, not a required dependency yet.
5. Image assets copied from the legacy blog are content dependencies and should be migrated only when referenced by public pages or explicitly approved.

## QUESTIONS

Current understanding: 96%.

Open questions: none.

Resolved decisions carried forward from the prior conversation:

1. Launch the new site at `jamesonstone.github.io` first, without copying the old `axiomatic.dev` `CNAME` yet.
2. Migrate only public old-blog pages and paintings by default; exclude dot-prefixed Markdown files unless explicitly approved later.
3. Preserve old public posts mostly verbatim as archive content; use the concise style for new posts.
4. Use URLs shaped like `/blog/YYYY/MM/DD/slug.html`.
5. Derive migrated post dates from old repo Git history when no front matter date exists, marking uncertainty when needed.
6. Keep the visual style whimsical but restrained, readable, high contrast, and blog-first.
7. Use default GitHub Pages Jekyll publishing on push for the first deploy pipeline.
8. Keep generated legacy artifacts removed from `/Users/jamesonstone/go/src/github.com/jamesonstone/jamesonstone.github.io`: `_site`, `params.json`, and `javascripts/scale.fix.js`.
9. Keep redirects or deprecation changes in `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io` out of first implementation scope.
10. Use top-level navigation `Blog`, `Paintings`, `Projects`, and `About`, with contact/profile links inside `About` and the footer.
11. Normalize public username/identity naming from `jstone28` to `jamesonstone`.

## OPTIONS

1. Minimal Jekyll rebuild with default GitHub Pages publishing.
   - Description: Replace the legacy generated theme with a source-first Jekyll site, custom layouts/CSS, migrated Markdown posts/assets, and default GitHub Pages deployment on push.
   - Pros: Fewest moving parts, native GitHub Pages support, easy Codex authoring, no Node or app framework, strong fit for short posts.
   - Cons: Less explicit deploy control than custom Actions; local Ruby/Jekyll setup should be refreshed and documented.
   - Current assessment: recommended.

2. Jekyll rebuild with custom GitHub Actions Pages workflow.
   - Description: Same Jekyll site, but add `.github/workflows/pages.yml` using Pages actions to build and deploy.
   - Pros: Explicit deploy logs, easier future custom build steps, clear CI-style pipeline.
   - Cons: More workflow config, more failure modes, unnecessary if default Pages build is enough.
   - Current assessment: fallback if default Pages publishing is insufficient or if explicit deploy workflows are required from day one.

3. Handwritten static HTML/CSS with Markdown converted manually by Codex.
   - Description: Avoid Jekyll post mechanics and have Codex edit HTML directly.
   - Pros: Very small runtime/build surface.
   - Cons: Weak fit for blog archives, dates, post layouts, feed possibilities, and repeatable Codex-created post workflow.
   - Current assessment: not recommended.

4. Preserve the old legacy blog structure/theme inside the target repo.
   - Description: Copy the old site with minor styling changes.
   - Pros: Fast migration and low content transformation risk.
   - Cons: Keeps stale `jekyll-theme-hacker` identity, does not create the requested modern whimsical site, and does not address the new short-post authoring model.
   - Current assessment: not recommended except as an emergency migration fallback.

5. Full modern static-site generator migration such as Astro, Eleventy, or Hugo.
   - Description: Replace Jekyll with a newer static-site generator and deploy via Actions.
   - Pros: Modern tooling and flexible templating.
   - Cons: Adds a new toolchain without evidence it is needed; higher maintenance for a personal GitHub Pages blog.
   - Current assessment: overbuilt for this feature unless explicitly requested.

## RECOMMENDED STRATEGY

1. Use the minimal Jekyll rebuild as the initial implementation path.
   - Keep GitHub Pages/Jekyll because the target repo already uses GitHub Pages and the future post workflow maps directly to `_posts/YYYY-MM-DD-slug.md`.
   - Avoid SPA/frontend build tooling because the desired site is a readable static blog.

2. Convert the target repo to a source-first structure.
   - Add `_config.yml`, `_layouts/default.html`, `_layouts/post.html`, a homepage, a blog archive, a paintings archive, and one CSS entrypoint.
   - Keep `_site`, `params.json`, and `javascripts/scale.fix.js` removed.

3. Preserve old public content as an archive.
   - Migrate public files from `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog/*.md`.
   - Copy only referenced image assets from `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/images`.
   - Migrate paintings from `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/paintings`.
   - Exclude dot-prefixed hidden Markdown files unless the user explicitly approves publication.

4. Normalize public identity during migration.
   - Replace copied public-facing `jstone28` username/profile/repository-owner references with `jamesonstone`.
   - Keep `jstone28.github.io` only where needed to identify the historical source repository path in implementation notes or migration scripts.

5. Make new posts intentionally short and easy for Codex to create.
   - Standardize front matter fields such as `layout`, `title`, `date`, `categories` or `tags`, and optional `excerpt`.
   - Document a README workflow where the user asks Codex for a post, Codex creates a Markdown file under `_posts`, and deployment happens on push.
   - Use the geohot reference as a shape constraint: title, date, short paragraphs, minimal chrome.

6. Defer custom GitHub Actions unless necessary.
   - Start with default GitHub Pages Jekyll publishing on push.
   - Add a custom Pages workflow only if the implementation needs explicit deployment control, unsupported plugins, asset processing, or reproducible CI-style build logs.

7. Keep the design simple but distinctive.
   - Use a readable max-width column for posts.
   - Add subtle whimsical accents through color, small decorative rules, link treatments, and section rhythm.
   - Avoid cards inside cards, large marketing hero sections, heavy JavaScript, low-contrast palettes, or decoration that competes with reading.

8. Treat domain and redirect changes as explicit decisions.
   - Do not copy `axiomatic.dev` `CNAME` until the user confirms the desired domain cutover.
   - Do not change the deprecated `jstone28.github.io` repo during the first implementation unless the user expands scope.

## NEXT STEP

No unresolved brainstorm questions remain. The next workflow step is:

```bash
kit spec v2-blog
```
