---
kit_metadata_version: 1
artifact: tasks
feature:
  id: 0001
  slug: v2-blog
  dir: 0001-v2-blog
confidence: 96
unresolved_assumptions: 0
---
# TASKS

## PROGRESS TABLE

| ID | TASK | STATUS | OWNER | DEPENDENCIES |
| -- | ---- | ------ | ----- | ------------ |
| T001 | Prepare source hygiene and Jekyll dependency baseline ([PLAN-APPROACH](./PLAN.md#approach), [PLAN-RISKS](./PLAN.md#risks)) | done | agent |  |
| T002 | Establish Jekyll configuration, layouts, and stylesheet entrypoint ([PLAN-COMPONENTS](./PLAN.md#components), [PLAN-DATA](./PLAN.md#data)) | done | agent | T001 |
| T003 | Replace legacy shell with top-level pages and navigation ([PLAN-COMPONENTS](./PLAN.md#components), [PLAN-INTERFACES](./PLAN.md#interfaces)) | done | agent | T002 |
| T004 | Derive legacy post migration date map ([PLAN-DATA](./PLAN.md#data), [PLAN-RISKS](./PLAN.md#risks)) | done | agent | T001 |
| T005 | Migrate public legacy blog posts and referenced blog images ([PLAN-DATA](./PLAN.md#data), [PLAN-INTERFACES](./PLAN.md#interfaces)) | done | agent | T002, T004 |
| T006 | Migrate linked painting archive and painting assets ([PLAN-DATA](./PLAN.md#data), [PLAN-COMPONENTS](./PLAN.md#components)) | done | agent | T002, T003 |
| T007 | Normalize public identity and classify remaining historical `jstone28` references ([PLAN-APPROACH](./PLAN.md#approach), [PLAN-TESTING](./PLAN.md#testing)) | done | agent | T003, T005, T006 |
| T008 | Implement restrained responsive visual design ([PLAN-COMPONENTS](./PLAN.md#components), [PLAN-RISKS](./PLAN.md#risks)) | done | agent | T003, T005, T006, T007 |
| T009 | Document local preview and Codex-assisted post workflow ([PLAN-INTERFACES](./PLAN.md#interfaces), [PLAN-TESTING](./PLAN.md#testing)) | done | agent | T001, T005 |
| T010 | Run Jekyll build and route/permalink validation ([PLAN-TESTING](./PLAN.md#testing)) | done | agent | T008, T009 |
| T011 | Run migration, identity, and scope validation scans ([PLAN-TESTING](./PLAN.md#testing)) | done | agent | T010 |
| T012 | Run rendered visual validation and final readiness check ([PLAN-TESTING](./PLAN.md#testing)) | done | agent | T010, T011 |

## TASK LIST

- [x] T001: Prepare source hygiene and Jekyll dependency baseline.
- [x] T002: Establish Jekyll configuration, layouts, and stylesheet entrypoint.
- [x] T003: Replace legacy shell with top-level pages and navigation.
- [x] T004: Derive legacy post migration date map.
- [x] T005: Migrate public legacy blog posts and referenced blog images.
- [x] T006: Migrate linked painting archive and painting assets.
- [x] T007: Normalize public identity and classify remaining historical `jstone28` references.
- [x] T008: Implement restrained responsive visual design.
- [x] T009: Document local preview and Codex-assisted post workflow.
- [x] T010: Run Jekyll build and route/permalink validation.
- [x] T011: Run migration, identity, and scope validation scans.
- [x] T012: Run rendered visual validation and final readiness check.

## TASK DETAILS

### T001
- GOAL: Establish a clean source baseline that can build with a current GitHub Pages-compatible Jekyll stack.
- SCOPE:
  - Refresh `Gemfile` and `Gemfile.lock` only as needed for local GitHub Pages/Jekyll builds.
  - Ensure generated output such as `_site` is ignored and remains untracked.
  - Keep removed legacy generated artifacts out of the source tree: `_site`, `params.json`, and `javascripts/scale.fix.js`.
  - Do not add custom GitHub Actions publishing or `CNAME`.
- ACCEPTANCE:
  - `bundle install` or equivalent Bundler setup completes.
  - `Gemfile` and `Gemfile.lock` reflect the chosen Jekyll/GitHub Pages baseline.
  - `git status --short` shows no tracked generated `_site` output.
  - Evidence artifacts: `Gemfile`, `Gemfile.lock`, optional `.gitignore`, and terminal output for dependency setup.
- NOTES: If the old lock cannot be refreshed cleanly, stop and document the exact Ruby/Bundler failure before changing deployment strategy.

### T002
- GOAL: Create the reusable Jekyll structure that all pages and posts render through.
- SCOPE:
  - Add `_config.yml` with site metadata, Markdown settings, permalink pattern `/blog/:year/:month/:day/:title.html`, and excludes.
  - Add `_layouts/default.html` for global document structure, navigation, main content, metadata, and footer.
  - Add `_layouts/post.html` for dated post rendering.
  - Add one stylesheet entrypoint at `assets/css/site.css`.
  - Avoid plugins that would require custom Actions deployment unless explicitly justified by a build failure.
- ACCEPTANCE:
  - A minimal page and post can render through the new layouts.
  - Navigation targets match the fixed sections: `Blog`, `Paintings`, `Projects`, `About`.
  - Evidence artifacts: `_config.yml`, `_layouts/default.html`, `_layouts/post.html`, `assets/css/site.css`.
- NOTES: Keep layout logic explicit and small; do not introduce includes unless they remove real duplication.

### T003
- GOAL: Replace the old generated homepage shell with source-first Markdown pages and stable navigation.
- SCOPE:
  - Replace or remove `index.html` in favor of a homepage source that uses the new layout.
  - Create or update `blog/index.md`, `paintings/index.md`, `projects.md`, and `about.md`.
  - Put contact/profile links in `about.md` and footer content, not as scattered homepage sections.
  - Present the site as a blog-first experience, not a marketing landing page.
- ACCEPTANCE:
  - The old orderedlist starter shell, stale `Click here!` content, and stale `https://github.com/jstone28` homepage link no longer render.
  - Each top-level navigation target has a source file and a stable permalink.
  - Evidence artifacts: `index.md` or replacement homepage source, `blog/index.md`, `paintings/index.md`, `projects.md`, `about.md`.
- NOTES: If `index.html` remains, it must be intentional source, not the old generated shell.

### T004
- GOAL: Produce reliable migration dates for public legacy posts without inventing certainty.
- SCOPE:
  - Use `/Users/jamesonstone/go/src/github.com/jamesonstone/jstone28.github.io/blog/index.md` as the public post list.
  - Exclude `.zen-team.md`, `.walled-garden.md`, `.right-problem.md`, and `.prog-dev-eng.md`.
  - Use old-repo Git history to derive dates for public posts that lack front matter dates.
  - Identify uncertain dates before writing migrated post front matter.
- ACCEPTANCE:
  - Every migrated public post has a chosen date and `date_source` metadata plan.
  - Any uncertain date has a planned `date_uncertain: true` marker.
  - Hidden dot-prefixed posts are not included in the migration set.
  - Evidence artifacts: command output or implementation notes showing source post list, hidden exclusions, and date derivation method.
- NOTES: Do not block on perfect historical precision; preserve uncertainty explicitly.

### T005
- GOAL: Convert public legacy blog content into Jekyll archive posts with working local assets.
- SCOPE:
  - Migrate the 13 public posts listed by the old `blog/index.md` into `_posts/YYYY-MM-DD-slug.md`.
  - Preserve old post bodies mostly verbatim.
  - Add front matter fields required by the plan, including `layout`, `title`, `date`, and `archive: true`.
  - Copy only referenced blog images into `assets/images/blog/`.
  - Rewrite internal post links and image paths to stable target-site paths.
  - Do not copy or publish hidden dot-prefixed Markdown files.
- ACCEPTANCE:
  - `_posts` contains migrated Markdown posts for all public old-blog entries.
  - Referenced blog images exist under `assets/images/blog/`.
  - Migrated post links do not point at old relative `.md` paths when a Jekyll permalink target exists.
  - Evidence artifacts: `_posts/*.md`, `assets/images/blog/*`, migration command output or reviewed file list.
- NOTES: Preserve historical code snippets and prose when normalization would change technical meaning.

### T006
- GOAL: Build the paintings archive from linked legacy painting pages and assets.
- SCOPE:
  - Migrate linked painting pages: `amoteofdust.md`, `continuity.md`, and `thelightthat.md`.
  - Copy linked painting images into `assets/images/paintings/`.
  - Keep unlinked painting JPEG files out of scope unless implementation records a concrete reason to include them.
  - Render painting entries with readable captions and responsive image behavior.
- ACCEPTANCE:
  - `paintings/index.md` lists migrated linked paintings with working image paths.
  - `assets/images/paintings/` contains the linked artwork required by the archive.
  - Unlinked painting assets are either absent or explicitly justified in implementation evidence.
  - Evidence artifacts: `paintings/index.md`, optional painting detail pages, `assets/images/paintings/*`.
- NOTES: Preserve source artwork files; use layout constraints for display behavior.

### T007
- GOAL: Normalize current-facing identity while preserving historical archive accuracy.
- SCOPE:
  - Rewrite current-facing GitHub/GitLab/profile labels and links from `jstone28` to `jamesonstone`.
  - Check old project links before presenting them as current.
  - Preserve `jstone28` in code examples, registry strings, package names, or archive prose where rewriting would alter historical or technical meaning.
  - Ensure `jstone28.github.io` appears only as historical source evidence in docs or implementation notes.
- ACCEPTANCE:
  - `rg -n "jstone28" .` output is reviewed.
  - Remaining `jstone28` occurrences are either absent from public current-facing pages or justified as historical/code archive content.
  - Current-facing navigation, about/profile, and project links use `jamesonstone` where a current equivalent exists.
  - Evidence artifacts: reviewed `rg` output and changed page/post files.
- NOTES: Avoid broad find-and-replace; classify occurrences before editing.

### T008
- GOAL: Apply a restrained, readable, responsive visual system through the single CSS entrypoint.
- SCOPE:
  - Define typography, line length, spacing, navigation, footer, code blocks, links, and image behavior.
  - Keep visual style whimsical but restrained through small accents, color, and rhythm.
  - Avoid heavy decoration, cards inside cards, one-note low-contrast palettes, app-like JavaScript, and marketing hero structure.
  - Disconnect or remove unused old theme CSS such as `stylesheets/styles.css` and `stylesheets/pygment_trac.css`.
- ACCEPTANCE:
  - The rendered site uses `assets/css/site.css` as the primary style source.
  - Pages and posts remain readable at mobile and desktop widths.
  - No text overlaps navigation, images, or adjacent content in key pages.
  - Evidence artifacts: `assets/css/site.css`, rendered screenshots or browser observations, removed or disconnected old CSS files.
- NOTES: Keep the design blog-first; do not add decorative assets that do not support reading.

### T009
- GOAL: Document the local preview and future Codex post workflow.
- SCOPE:
  - Update `README.md` with local setup, `bundle exec jekyll serve`, and `bundle exec jekyll build`.
  - Document the `_posts/YYYY-MM-DD-slug.md` filename contract and required front matter.
  - Document optional image placement under `assets/images/blog/`.
  - Document that approved pushes publish through GitHub Pages and that `CNAME` is out of scope for this feature.
- ACCEPTANCE:
  - README lets a future Codex thread add a short post without rediscovering file naming, front matter, image location, preview, or publishing behavior.
  - README does not claim custom Actions deployment unless implementation adds and justifies it.
  - Evidence artifacts: `README.md`.
- NOTES: Keep README concise and operational.

### T010
- GOAL: Prove the generated Jekyll output satisfies the build and permalink contract.
- SCOPE:
  - Run `bundle exec jekyll build`.
  - Verify generated post paths follow `_site/blog/YYYY/MM/DD/slug.html`.
  - Verify homepage, blog archive, migrated post, paintings archive, projects page, and about page generate.
  - Keep `_site` untracked after validation.
- ACCEPTANCE:
  - Build exits successfully.
  - Generated files include the required route shapes.
  - `_site` remains ignored or untracked.
  - Evidence artifacts: terminal output from build and route checks.
- NOTES: If build fails because of dependency/runtime incompatibility, return to T001 rather than adding custom deployment machinery.

### T011
- GOAL: Prove migration, identity, and non-goal boundaries hold after implementation.
- SCOPE:
  - Scan generated output and source for hidden draft slugs.
  - Scan for `jstone28` and classify any remaining occurrence.
  - Verify no `CNAME` file was added.
  - Verify no custom Pages workflow, SPA framework, CMS, database, analytics, comments, newsletter, or search feature was introduced.
  - Verify migrated internal links and copied image paths resolve.
- ACCEPTANCE:
  - Hidden drafts are absent from source navigation and generated output.
  - Remaining `jstone28` references are reviewed and justified or removed.
  - Scope scans show non-goals remain excluded.
  - Evidence artifacts: terminal output from `rg`/file checks and link/asset checks.
- NOTES: Treat a broken local asset reference as a blocker unless explicitly accepted.

### T012
- GOAL: Confirm the implemented site is visually ready for implementation handoff.
- SCOPE:
  - Run a local Jekyll preview server.
  - Inspect representative desktop and mobile widths.
  - Check homepage, blog archive, migrated long-form post, concise-post workflow documentation, paintings archive, projects page, and about page.
  - Confirm readability, high contrast, responsive navigation, stable image scaling, and no incoherent overlap.
- ACCEPTANCE:
  - Desktop and mobile rendered checks pass.
  - Any visual issue found is fixed or documented as a blocker.
  - Final implementation summary can cite build, scan, and visual evidence.
  - Evidence artifacts: browser screenshots or explicit visual-check notes, plus local server command output.
- NOTES: Prefer the Browser plugin or equivalent local browser automation for screenshots when available.

## DEPENDENCIES

No external blockers or missing decisions are known.

Ordering notes:

1. T001 must run first because dependency and generated-output hygiene affect every later validation task.
2. T002 and T003 establish the render surface before content migration is verified.
3. T004 must precede T005 so migrated post filenames and dates are intentional.
4. T010, T011, and T012 are validation tasks and must remain last.

## NOTES

The task plan is intentionally linear. Parallel execution is not recommended until implementation begins and the agent can split clearly independent lanes such as styling, content migration, and documentation without overlapping file edits.

<!-- REFLECTION_COMPLETE -->
