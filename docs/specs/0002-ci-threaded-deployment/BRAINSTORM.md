---
kit_metadata_version: 1
artifact: brainstorm
feature:
  id: 0002
  slug: ci-threaded-deployment
  dir: 0002-ci-threaded-deployment
confidence: 96
unresolved_assumptions: 0
relationships:
  - type: builds_on
    target: 0001-v2-blog
    relation: builds_on
    used_for: Reuses the source-first Jekyll blog, post filename contract, GitHub Pages deploy baseline, and PR delivery expectations established by v2-blog.
references:
  - id: constitution
    name: Constitution
    type: repo_doc
    target: docs/CONSTITUTION.md
    relation: constrains
    read_policy: must
    used_for: Spec-driven workflow classification and project-level constraints.
    status: active
  - id: agents-entrypoint
    name: AGENTS entrypoint
    type: repo_doc
    target: AGENTS.md
    relation: guides
    read_policy: must
    used_for: Repository instruction routing and pasted-text attachment behavior.
    status: active
  - id: claude-entrypoint
    name: CLAUDE entrypoint
    type: repo_doc
    target: CLAUDE.md
    relation: guides
    read_policy: must
    used_for: Repository instruction routing for Claude-compatible agents.
    status: active
  - id: copilot-entrypoint
    name: Copilot instruction entrypoint
    type: repo_doc
    target: .github/copilot-instructions.md
    relation: guides
    read_policy: must
    used_for: Repository instruction routing for GitHub Copilot.
    status: active
  - id: agents-readme
    name: Agent docs README
    type: repo_doc
    target: docs/agents/README.md
    relation: guides
    read_policy: must
    used_for: Repo-local instruction navigation and loading policy.
    status: active
  - id: workflows-doc
    name: Workflows doc
    type: repo_doc
    target: docs/agents/WORKFLOWS.md
    relation: guides
    read_policy: must
    used_for: Spec-driven research-only phase rules and source-of-truth order.
    status: active
  - id: guardrails-doc
    name: Guardrails doc
    type: repo_doc
    target: docs/agents/GUARDRAILS.md
    relation: guides
    read_policy: must
    used_for: Brainstorm completion bar and documentation-only safety constraints.
    status: active
  - id: rlm-doc
    name: RLM doc
    type: repo_doc
    target: docs/agents/RLM.md
    relation: guides
    read_policy: must
    used_for: Just-in-time prior-work pass and bounded repository discovery.
    status: active
  - id: tooling-doc
    name: Tooling doc
    type: repo_doc
    target: docs/agents/TOOLING.md
    relation: guides
    read_policy: must
    used_for: Project-directory workflow and repo-local skill directory discovery.
    status: active
  - id: feature-notes
    name: Feature notes
    type: notes
    target: docs/notes/0002-ci-threaded-deployment
    relation: informs
    read_policy: conditional
    used_for: Optional pre-brainstorm research input; only .gitkeep existed during this pass.
    status: optional
  - id: project-progress-summary
    name: Project progress summary
    type: repo_doc
    target: docs/PROJECT_PROGRESS_SUMMARY.md
    relation: informs
    read_policy: must
    used_for: RLM feature shortlist and current feature phase.
    status: active
  - id: kit-map-current
    name: Kit map for ci-threaded-deployment
    type: command
    target: kit map 0002-ci-threaded-deployment
    relation: informs
    read_policy: evidence
    used_for: Confirmed current artifact state, phase, and lack of preexisting relationships.
    status: active
  - id: v2-blog-spec
    name: v2-blog specification
    type: feature_doc
    target: docs/specs/0001-v2-blog/SPEC.md
    relation: constrains
    read_policy: must
    used_for: Post URL shape, source-first Jekyll requirements, and non-goals around custom workflows.
    status: active
  - id: v2-blog-plan
    name: v2-blog plan
    type: feature_doc
    target: docs/specs/0001-v2-blog/PLAN.md
    relation: constrains
    read_policy: must
    used_for: New-post authoring contract, branch publishing contract, and validation strategy.
    status: active
  - id: readme-new-post-workflow
    name: README new-post workflow
    type: repo_file
    target: README.md
    relation: implements
    read_policy: must
    used_for: Current documented post filename, front matter, preview, validation, and publish-on-push workflow.
    status: active
  - id: jekyll-config
    name: Jekyll configuration
    type: repo_file
    target: _config.yml
    relation: implements
    read_policy: must
    used_for: Current permalink, post defaults, source excludes, and theme behavior.
    status: active
  - id: site-validator
    name: Site invariant validator
    type: repo_file
    target: scripts/validate_site.rb
    relation: verifies
    read_policy: evidence
    used_for: Existing local route, migrated post, hidden draft, forbidden output, and link validation.
    status: active
  - id: safety-guardrails
    name: Safety guardrails ruleset
    type: repo_doc
    target: docs/references/rules/safety-guardrails.md
    relation: constrains
    read_policy: must
    used_for: Required git/GitHub recon, protected branch handling, identity checks, and failure handling.
    status: active
  - id: work-lane-gating
    name: Work lane gating ruleset
    type: repo_doc
    target: docs/references/rules/work-lane-gating.md
    relation: constrains
    read_policy: must
    used_for: Distinguishes documentation-only phases from implementation lanes and PR workflow consent.
    status: active
  - id: github-pr-delivery
    name: GitHub PR delivery ruleset
    type: repo_doc
    target: docs/references/rules/github-pr-delivery.md
    relation: constrains
    read_policy: must
    used_for: Issue, branch, commit, push, PR, assignee, and post-PR verification workflow.
    status: active
  - id: pr-template
    name: Pull request template
    type: repo_file
    target: .github/pull_request_template.md
    relation: constrains
    read_policy: must
    used_for: Required PR body headings for threaded post PRs.
    status: active
  - id: pages-settings
    name: GitHub Pages settings
    type: command
    target: gh api repos/jamesonstone/jamesonstone.github.io/pages
    relation: informs
    read_policy: evidence
    used_for: Confirmed current production publishing mode is legacy GitHub Pages from master at /.
    status: active
---
# BRAINSTORM

## SUMMARY

`ci-threaded-deployment` should turn a recognizable `new_post` marker in a discussion thread into a disciplined blog-post intake workflow: extract draft content, optionally review and clarify it, create a source Markdown post, open the required GitHub issue/branch/PR, and leave production deployment to the existing GitHub Pages publish-on-merge path. The most likely implementation direction is a repo-local agent skill plus supporting repo guidance, not a runtime service or custom deployment system.

Current understanding is 96%. The codebase and workflow constraints are clear, and the user has approved the trigger grammar, review behavior, title/date/metadata defaults, asset handling, PR delivery path, deployment semantics, and implementation surface needed to draft SPEC.md.

## USER THESIS

The user wants a fast threaded-discussion workflow for publishing short blog posts:

1. The user writes `new_post` in a thread along with content delimited by triple quotes.
2. The coding agent notices the marker, reviews the content, asks follow-up questions, and suggests edits unless the user says `no review`.
3. The agent creates a GitHub issue, branch, and pull request, then prompts the user to review.
4. After the user manually merges the pull request, the agent deploys the new post to production.

The product goal is not merely a new Markdown template. The goal is an agent-recognizable path from rough threaded thought to clarified post, reviewable PR, and production as fast as possible while preserving the repository's safety, authorship, and manual-merge rules.

## RELATIONSHIPS

Relationships are tracked in front matter.

1. This feature `builds_on` `0001-v2-blog` because `0001-v2-blog` created the Jekyll source structure, `_posts/YYYY-MM-DD-slug.md` contract, `/blog/YYYY/MM/DD/slug.html` permalink contract, validation script, and default GitHub Pages deployment baseline.
2. `kit map 0002-ci-threaded-deployment` reported no existing incoming or outgoing relationships before this brainstorm pass; the relationship to `0001-v2-blog` is added by this research because the new workflow depends directly on that shipped post and deploy model.

## CODEBASE FINDINGS

1. Current feature state:
   - `docs/specs/0002-ci-threaded-deployment/BRAINSTORM.md` existed as a mostly empty Kit brainstorm template before this research pass.
   - `docs/notes/0002-ci-threaded-deployment` contained only `.gitkeep`; there were no usable note files to copy into this artifact.
   - `kit map 0002-ci-threaded-deployment` shows this feature in brainstorm phase with only `BRAINSTORM.md` present.

2. The current site already has a post authoring contract:
   - `README.md` documents `_posts/YYYY-MM-DD-slug.md` as the post filename shape.
   - `README.md` requires front matter containing `layout: post`, `title`, and `date`.
   - `README.md` says optional images go under `assets/images/blog/` and should be referenced with site-root paths like `/assets/images/blog/example.png`.
   - `README.md` says approved source changes publish through GitHub Pages from the configured branch and that this repo does not currently use a custom Actions workflow or `CNAME`.

3. The Jekyll config supports the intended output shape:
   - `_config.yml` sets `permalink: /blog/:year/:month/:day/:title.html`.
   - `_config.yml` applies `layout: post` defaults to posts.
   - `_config.yml` excludes repo/docs/tooling files including `.github/`, `docs/`, `scripts/`, `Gemfile`, `Gemfile.lock`, `README.md`, and `vendor/` from generated output.
   - `_config.yml` sets `theme: null`, so this site is using local layouts and `assets/css/site.css` rather than a GitHub Pages theme.

4. The current validation helper is archive-focused but reusable:
   - `scripts/validate_site.rb` requires `_site` to exist, so `bundle exec jekyll build` must run before it.
   - `scripts/validate_site.rb` validates core routes, legacy archive posts, hidden draft exclusions, forbidden legacy source files, forbidden generated outputs, absence of custom workflow files, and local asset/internal blog links.
   - `scripts/validate_site.rb` does not yet validate future non-archive posts beyond generic local asset/internal blog links. A later implementation may need to extend it so a newly inserted post is checked for filename/front matter/permalink without making the legacy archive list the only source of truth.

5. The repository already has strict PR delivery rules:
   - `docs/references/rules/safety-guardrails.md` requires git/GitHub recon before mutation, protected branch handling, human author/committer identity, no force-push, no branch deletion, and secret scanning before staging.
   - `docs/references/rules/work-lane-gating.md` says BRAINSTORM/SPEC/PLAN/TASKS and standalone docs should not automatically trigger issue/branch/PR workflow unless the user explicitly asks.
   - `docs/references/rules/github-pr-delivery.md` requires issue first, branch name exactly `GH-123`, explicit path staging, human author/committer, a structured commit message, a ready-for-review PR, PR template headings, `jamesonstone` assignment, and post-PR check reporting.
   - `.github/pull_request_template.md` currently has headings `Description`, `How to Test`, and `Ticket`, which threaded-post PRs must preserve.

6. Production deployment is currently branch-based GitHub Pages:
   - `gh api repos/jamesonstone/jamesonstone.github.io/pages` returned `build_type: legacy`, `status: built`, `html_url: http://jamesonstone.github.io/`, and `source: { branch: master, path: / }`.
   - `.github/` currently contains only `.github/copilot-instructions.md` and `.github/pull_request_template.md`; no `.github/workflows/*` file exists.
   - Given this state, "deploy after merge" should likely mean: user manually merges the post PR into `master`; GitHub Pages builds from `master`; the agent can verify Pages status and production URL afterward. It should not mean the agent merges, force-pushes, changes Pages settings, or adds a deploy workflow by default.

7. No threaded post recognition convention exists yet:
   - A repository search for `new_post` found only this feature's brainstorm template text.
   - There is no `.agents/skills` directory yet, even though `.kit.yaml` declares `skills_dir: .agents/skills`.
   - `docs/agents/TOOLING.md` says repo-local canonical skills live under `.agents/skills/*/SKILL.md`.
   - `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` are intentionally short routing tables that should not grow into monolithic instructions.

8. The safest recognition mechanism is likely agent guidance, not CI parsing:
   - The user wants the LLM to recognize `new_post` inside a threaded discussion. CI cannot observe arbitrary Codex thread text unless the content has already been committed or sent through GitHub.
   - A repo-local skill can define how agents recognize and process `new_post` prompts in conversation before source files are changed.
   - A durable ruleset or docs entry can define issue/PR/deployment behavior, but PR creation should still use the existing GitHub PR delivery rules rather than duplicating them.

9. The feature likely needs two related but distinct workflows:
   - Intake workflow: detect `new_post`, parse content, ask clarifying questions, suggest edits, and produce a proposed Markdown post.
   - Delivery workflow: create issue/branch/PR for the new post, validate it locally, prompt the user to review/merge, then verify GitHub Pages after manual merge.

10. The current branch state is not a feature requirement, but it affects implementation caution:
    - Research occurred while the checkout was on `GH-1`, which has an open PR for `0001-v2-blog`.
    - Because this phase is documentation-only, no issue/branch/PR was created for `0002` during this brainstorm pass.
    - Later implementation should run the repo's safety recon and likely start a separate issue-number branch for `0002` before editing `.agents/skills`, agent docs, validators, or workflow files.

## AFFECTED FILES

1. `docs/specs/0002-ci-threaded-deployment/BRAINSTORM.md`
   - Current research artifact and source of truth for this phase.

2. `docs/notes/0002-ci-threaded-deployment/.gitkeep`
   - Placeholder only; no durable conclusions were available from notes.

3. `.agents/skills/threaded-blog-post/SKILL.md`
   - Likely new repo-local skill location if the chosen implementation uses a skill. It should define `new_post` trigger recognition, content extraction, review questions, Markdown generation, delivery handoff, and post-merge verification.

4. `AGENTS.md`
   - May need a small pointer only if repo-local skills are not automatically discovered by the active agent. It should remain a routing table and should not absorb the full threaded-post workflow.

5. `CLAUDE.md`
   - Same as `AGENTS.md`; any update should stay aligned and brief.

6. `.github/copilot-instructions.md`
   - May need a short pointer so GitHub Copilot also recognizes the repo-local threaded-post workflow, but the detailed workflow should live outside this file.

7. `docs/agents/TOOLING.md`
   - May need a small routing note for project-local skills if the implementation discovers that `.agents/skills/*/SKILL.md` is not sufficiently discoverable.

8. `docs/references/rules/github-pr-delivery.md`
   - Should remain the delivery source of truth. This feature should reference it rather than duplicating branch/commit/PR rules.

9. `docs/references/rules/safety-guardrails.md`
   - Should remain the safety source of truth for branch/identity/secret/merge restrictions.

10. `docs/references/rules/work-lane-gating.md`
    - May be referenced to clarify that `new_post` is implementation work once it starts producing post files and PRs.

11. `README.md`
    - May need a "Threaded New Post Workflow" section explaining the user-facing `new_post` syntax after the feature is specified and implemented.

12. `_posts/YYYY-MM-DD-slug.md`
    - Destination pattern for generated blog posts. The workflow should create one file per accepted post.

13. `assets/images/blog/*`
    - Optional destination for post-specific images if the thread content references images or asks for visual assets.

14. `_config.yml`
    - Usually unchanged, because permalink and post layout defaults already support new posts. It should only change if SPEC.md requires new metadata defaults or collections.

15. `scripts/validate_site.rb`
    - Likely needs an implementation update so new non-archive posts are validated, especially if the workflow adds required front matter fields such as `excerpt`, `tags`, `source_thread`, or `review_status`.

16. `.github/pull_request_template.md`
    - Usually unchanged. Threaded post PR bodies should use its current headings unless the user later wants a richer PR template.

17. `.github/workflows/*`
    - Not currently present and not recommended by default. Add only if the user explicitly wants a custom deploy/check workflow beyond GitHub Pages legacy branch publishing.

## DEPENDENCIES

1. Existing Jekyll/GitHub Pages stack:
   - `Gemfile` and `Gemfile.lock` provide the local `bundle exec jekyll build` and `bundle exec jekyll doctor` commands.
   - `_config.yml` provides post permalink behavior and source exclusions.

2. Existing post validation:
   - `scripts/validate_site.rb` already guards key site invariants after a build.
   - It probably needs extension for generated new posts rather than replacement.

3. GitHub CLI and authenticated GitHub access:
   - `docs/references/rules/github-pr-delivery.md` prefers `gh` for issue search/create, base branch discovery, PR lookup, PR create, PR view, and PR checks.
   - Post-merge production verification likely depends on `gh api repos/jamesonstone/jamesonstone.github.io/pages` or equivalent GitHub Pages status inspection.

4. Manual human review and merge:
   - The user explicitly wants to manually hit merge.
   - Safety rules prohibit the agent from merging, bypassing review, force-pushing, or changing protected branch rules.

5. Repo-local skill discovery:
   - `.kit.yaml` sets `skills_dir: .agents/skills`.
   - `docs/agents/TOOLING.md` says repo-local canonical skills live under `.agents/skills/*/SKILL.md`.
   - The implementation should verify whether active Codex/Copilot/Claude surfaces discover these skills automatically or need short pointer updates in agent entrypoints.

6. No custom deployment workflow dependency by default:
   - GitHub Pages currently publishes from `master` at `/` with `build_type: legacy`.
   - A `.github/workflows/pages.yml` style workflow is an option only if the user decides "deploy" must be an explicit workflow-controlled action rather than Pages publish-on-merge.

## QUESTIONS

No unresolved questions remain from the first clarification batch. The user approved these decisions:

1. Trigger syntax:
   - Require a line containing only `new_post`, followed by one triple-quoted content block, for example `new_post` then `"""draft content"""`.
   - Strict syntax is preferred over loose keyword matching because it avoids accidentally turning normal discussion into a post.

2. Review behavior:
   - Unless the user writes `no review`, the agent should do one concise review pass and ask up to 5 clarifying questions before creating files.
   - The review phase should emphasize fast clarification rather than heavy editorial process.

3. `no review` behavior:
   - `no review` skips editorial questions but does not skip mechanical validation, front matter generation, filename selection, local build, or PR delivery checks.
   - `no review` means "do not critique my prose," not "bypass safety gates."

4. Title and slug derivation:
   - Use the first Markdown `# Heading` as the title when present.
   - If no `# Heading` is present and review is enabled, suggest a title during the review phase and use the accepted title for slug generation.
   - If no `# Heading` is present and `no review` is supplied, pick a reasonable title from the draft content and slugify it without an extra title-confirmation round.

5. Date and time:
   - Use the current date in `America/New_York` for filename and front matter unless the thread provides an explicit date.
   - Blog posts publish under the PR creation workflow date by default, not merge date.

6. Metadata:
   - Required front matter remains `layout`, `title`, and `date`.
   - Optional `excerpt` and `tags` should be added only when provided or clearly useful.
   - Do not add provenance metadata such as `source: threaded_discussion` or `reviewed: true` by default.

7. Assets:
   - If the thread content references images, the agent should pause and ask for asset source and alt text before creating the PR.
   - No generated, searched, or remote images are added without explicit approval.

8. Issue/branch/PR workflow:
   - Use `docs/references/rules/github-pr-delivery.md` exactly: search/create issue, branch `GH-123`, commit as the human user, push, create a ready PR, assign `jamesonstone`, and report PR checks.
   - Threaded posts follow the same reviewable delivery path as other implementation work.

9. Deployment semantics after merge:
   - After the user manually merges the PR, the agent does not run a deploy command by default.
   - The agent verifies GitHub Pages status and the production URL because the repo currently deploys from `master` via legacy GitHub Pages.

10. Implementation surface:
    - Implement primarily as a repo-local skill at `.agents/skills/threaded-blog-post/SKILL.md`.
    - Add only short pointers where needed, update `README.md`, and extend `scripts/validate_site.rb` for new-post checks.
    - A skill is the preferred recognition mechanism because it lets agents detect `new_post` quickly without bloating always-loaded instruction files.

## OPTIONS

1. Repo-local skill plus README/rules pointers.
   - Description: Add `.agents/skills/threaded-blog-post/SKILL.md` for trigger recognition, review loop, post creation, PR delivery handoff, and post-merge Pages verification. Add concise pointers in README and possibly agent routing docs.
   - Pros: Directly targets LLM recognition in discussions, keeps always-loaded files short, aligns with `.kit.yaml` and `docs/agents/TOOLING.md`, and avoids runtime infrastructure.
   - Cons: Requires confidence that active agent surfaces discover repo-local skills; may need small entrypoint updates.
   - Current assessment: recommended default.

2. Durable ruleset under `docs/references/rules/threaded-blog-post.md`.
   - Description: Add a ruleset for the `new_post` trigger and threaded post lifecycle.
   - Pros: Fits existing ruleset pattern and can be linked from feature docs.
   - Cons: Rulesets are usually loaded through feature references or relevant routing, while the user's trigger-recognition need happens before an agent knows it is in a feature. A ruleset alone may be less discoverable than a skill.
   - Current assessment: useful supporting artifact if paired with a skill, not sufficient by itself.

3. README-only workflow.
   - Description: Document `new_post` syntax and ask future agents to follow README.
   - Pros: Simple and visible to humans.
   - Cons: Weak trigger recognition for agents, easy to miss in threaded discussions, and not enough procedural detail for safe issue/PR/deploy handling.
   - Current assessment: insufficient as the primary mechanism.

4. Custom GitHub Actions deployment workflow.
   - Description: Add a Pages workflow or CI workflow for explicit build/deploy/checks when a post PR merges.
   - Pros: Clear deploy logs and possible automated validation.
   - Cons: Adds deployment surface and failure modes; current Pages settings already publish from `master`; v2-blog deliberately avoided custom workflows unless needed.
   - Current assessment: defer unless the user explicitly wants workflow-controlled deployment or CI checks.

5. GitHub issue/comment bot.
   - Description: Parse `new_post` markers from GitHub issues, comments, or discussions and automate PR creation.
   - Pros: Could work outside Codex threads and support async intake.
   - Cons: Requires a bot/app/action, permissions, event parsing, and security hardening. It is much heavier than the stated goal of agent recognition in a threaded discussion.
   - Current assessment: future option, not the first implementation.

## RECOMMENDED STRATEGY

1. Treat this feature as building on `0001-v2-blog`, not as a new deployment platform.
   - Reuse `_posts/YYYY-MM-DD-slug.md`, `assets/images/blog/`, `bundle exec jekyll build`, `ruby scripts/validate_site.rb`, and branch-based GitHub Pages publishing from `master`.

2. Define a strict `new_post` thread grammar.
   - Start with one exact trigger and one content block so agents can identify intent safely.
   - Keep optional metadata explicit rather than inferring too much from prose.
   - Require `new_post` on its own line followed by one triple-quoted content block.

3. Add a repo-local skill as the primary recognition mechanism.
   - The skill should be small, procedural, and optimized for fast agent action.
   - It should cover detection, parsing, review questions, draft normalization, file generation, validation, issue/PR handoff, and post-merge verification.
   - It should implement the approved title behavior: use `# Heading` when present; otherwise suggest during review or pick automatically under `no review`.

4. Keep delivery rules centralized.
   - The threaded-post workflow should call into `docs/references/rules/safety-guardrails.md`, `docs/references/rules/work-lane-gating.md`, and `docs/references/rules/github-pr-delivery.md`.
   - Do not duplicate branch/commit/PR rules inside the new skill beyond a pointer and required sequencing.

5. Preserve manual review and merge.
   - The agent should create a PR and prompt the user to review.
   - The user manually merges.
   - The agent verifies GitHub Pages status and production URL after merge when asked or when the thread resumes.

6. Extend validation only where it improves confidence.
   - `scripts/validate_site.rb` should likely learn how to validate future generated posts generically.
   - The workflow should still run `bundle exec jekyll build`, `ruby scripts/validate_site.rb`, and possibly `bundle exec jekyll doctor`.

7. Avoid custom CI/deploy automation in the first implementation.
   - Current GitHub Pages settings already deploy from `master`.
   - Custom workflows should be a later explicit decision if the user wants CI checks, deploy logs, or non-legacy Pages deployment.

## NEXT STEP

1. No brainstorm clarifications remain open; current confidence is 96%.
2. Run `kit spec ci-threaded-deployment`.
