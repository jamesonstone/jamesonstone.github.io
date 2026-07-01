---
kit_metadata_version: 1
artifact: plan
feature:
  id: 0002
  slug: ci-threaded-deployment
  dir: 0002-ci-threaded-deployment
parallelization_mode: "rlm"
confidence: 96
unresolved_assumptions: 0
skills:
  - id: rlm
    name: RLM
    path: docs/agents/RLM.md
    trigger: Use for analyze codebase, scan all files, large repository analysis, scan repository, and recursive language model context-routing requests where full-context loading would be noisy.
    used_for: Keep plan discovery scoped to the fixed spec, explicit references, v2-blog source contract, and source-attributed implementation facts.
    status: active
relationships:
  - type: builds_on
    target: 0001-v2-blog
    relation: builds_on
    used_for: Reuses the existing Jekyll post, validation, authoring, and GitHub Pages publishing boundaries established by v2-blog.
references:
  - id: spec
    name: ci-threaded-deployment specification
    type: feature_doc
    target: docs/specs/0002-ci-threaded-deployment/SPEC.md
    relation: constrains
    read_policy: must
    used_for: Fixed feature contract, non-goals, acceptance criteria, and edge cases.
    status: active
  - id: brainstorm
    name: ci-threaded-deployment brainstorm
    type: feature_doc
    target: docs/specs/0002-ci-threaded-deployment/BRAINSTORM.md
    relation: informs
    read_policy: must
    used_for: Approved trigger grammar, review behavior, title/date/metadata defaults, asset handling, PR delivery path, deployment semantics, and implementation surface.
    status: active
  - id: constitution
    name: Constitution
    type: repo_doc
    target: docs/CONSTITUTION.md
    relation: constrains
    read_policy: must
    used_for: Project-level constraints and spec-driven workflow semantics.
    status: active
  - id: agents-entrypoint
    name: AGENTS entrypoint
    type: repo_doc
    target: AGENTS.md
    relation: guides
    read_policy: must
    used_for: Pasted-text behavior, routing-table shape, and top-level pointer boundary.
    status: active
  - id: claude-entrypoint
    name: CLAUDE entrypoint
    type: repo_doc
    target: CLAUDE.md
    relation: guides
    read_policy: must
    used_for: Routing-table alignment for Claude-compatible agents.
    status: active
  - id: copilot-entrypoint
    name: Copilot instruction entrypoint
    type: repo_doc
    target: .github/copilot-instructions.md
    relation: guides
    read_policy: must
    used_for: Routing-table alignment for GitHub Copilot.
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
    used_for: Source-of-truth order, readiness gate, and plan-phase behavior.
    status: active
  - id: guardrails-doc
    name: Guardrails doc
    type: repo_doc
    target: docs/agents/GUARDRAILS.md
    relation: guides
    read_policy: must
    used_for: Completion bar, documentation scope, and validation expectations.
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
    used_for: Repo-local skill location, dispatch boundaries, and project-directory workflow.
    status: active
  - id: kit-config
    name: Kit configuration
    type: repo_file
    target: .kit.yaml
    relation: informs
    read_policy: must
    used_for: Confirmed `.agents/skills` as the repo-local skills directory and 95 percent confidence gate.
    status: active
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
    used_for: Confirmed artifact state, phase, relationships, and reference resolution.
    status: active
  - id: v2-blog-spec
    name: v2-blog specification
    type: feature_doc
    target: docs/specs/0001-v2-blog/SPEC.md
    relation: constrains
    read_policy: must
    used_for: Existing source-first blog, Jekyll, short-post, low-friction Pages, and no-custom-workflow constraints.
    status: active
  - id: v2-blog-plan
    name: v2-blog plan
    type: feature_doc
    target: docs/specs/0001-v2-blog/PLAN.md
    relation: constrains
    read_policy: must
    used_for: Existing post authoring contract, README documentation boundary, local build, validation, and branch publishing strategy.
    status: active
  - id: readme-new-post-workflow
    name: README new-post workflow
    type: repo_file
    target: README.md
    relation: implements
    read_policy: must
    used_for: Current post filename, front matter, image placement, preview, validation, and publish-on-push documentation.
    status: active
  - id: jekyll-config
    name: Jekyll configuration
    type: repo_file
    target: _config.yml
    relation: implements
    read_policy: must
    used_for: Current permalink, post defaults, excludes, and theme behavior.
    status: active
  - id: site-validator
    name: Site invariant validator
    type: repo_file
    target: scripts/validate_site.rb
    relation: verifies
    read_policy: evidence
    used_for: Existing build-output, route, archive, hidden draft, forbidden output, workflow, asset, and internal link validation.
    status: active
  - id: safety-guardrails
    name: Safety guardrails ruleset
    type: repo_doc
    target: docs/references/rules/safety-guardrails.md
    relation: constrains
    read_policy: must
    used_for: Required git/GitHub recon, protected branch handling, identity checks, secret checks, and failure handling.
    status: active
  - id: work-lane-gating
    name: Work lane gating ruleset
    type: repo_doc
    target: docs/references/rules/work-lane-gating.md
    relation: constrains
    read_policy: must
    used_for: Keeps Kit PLAN work docs-only and gates future implementation before source-code edits.
    status: active
  - id: github-pr-delivery
    name: GitHub PR delivery ruleset
    type: repo_doc
    target: docs/references/rules/github-pr-delivery.md
    relation: constrains
    read_policy: must
    used_for: Issue, branch, commit, push, PR, assignee, PR checks, and post-PR reporting workflow.
    status: active
  - id: pr-template
    name: Pull request template
    type: repo_file
    target: .github/pull_request_template.md
    relation: constrains
    read_policy: must
    used_for: Required PR body headings for generated-post PRs.
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
# PLAN

## SUMMARY

Implement `ci-threaded-deployment` as an agent-workflow layer around the existing Jekyll blog rather than as CI or runtime automation: add a repo-local threaded-post skill, make the trigger discoverable through concise routing and README pointers, extend validation so future posts are checked generically, and preserve the existing issue-number branch plus manual-merge GitHub Pages publishing model. The plan keeps recognition and editorial flow in agent guidance, source output in `_posts/` and `assets/images/blog/`, and delivery authority in the existing safety and PR rulesets.

## APPROACH

1. Use the fixed `SPEC.md` as the scope boundary.
   - The implementation should not add new deployment mechanisms, metadata requirements, bot behavior, or post formats beyond the spec.
   - `BRAINSTORM.md` informs why a skill is preferred, but `SPEC.md` controls what must be implemented.

2. Put the detailed workflow in a repo-local skill.
   - Add `.agents/skills/threaded-blog-post/SKILL.md` as the primary `new_post` recognition and execution guide.
   - The skill should be procedural and short enough to use during a thread, with sections for detection, parsing, review mode, `no review`, title/date/front matter derivation, asset blocking, validation, PR handoff, and post-merge verification.
   - Tradeoff: a skill is less automatic than a bot, but it matches the user's thread-driven workflow and avoids giving CI responsibility for text it cannot observe.

3. Add only small discoverability pointers outside the skill.
   - Keep `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` as routing tables.
   - If implementation shows that future agents need a direct trigger pointer, add a concise `new_post` or repo-local skills pointer in those files and route detailed behavior back to `.agents/skills/threaded-blog-post/SKILL.md`.
   - Update `README.md` with user-facing syntax and lifecycle expectations so humans can invoke the workflow without reading the skill.
   - Tradeoff: small pointers improve recognition while preserving the repository rule against always-loaded monolithic instruction files.

4. Treat post creation as source generation, not as product runtime code.
   - The workflow should produce one `_posts/YYYY-MM-DD-slug.md` file and optional approved assets under `assets/images/blog/`.
   - Existing Jekyll defaults and permalinks should remain sufficient; `_config.yml` should stay unchanged unless implementation finds a concrete mismatch with the spec.
   - The skill should describe the Markdown/front matter contract, not create a separate parser, service, or CLI in the first implementation.

5. Extend validation where it improves generated-post confidence.
   - Update `scripts/validate_site.rb` so validation covers future non-archive posts generically instead of only the legacy archive set.
   - Keep the validator focused on repository invariants: build output exists, post front matter is valid, rendered permalink exists, local assets exist, internal blog links resolve, hidden drafts stay unpublished, and custom workflow files remain absent.
   - Tradeoff: a targeted validator extension is enough for confidence; a full authoring linter or separate post schema package would be premature.

6. Keep delivery and deployment centralized.
   - The skill should call out to `docs/references/rules/safety-guardrails.md`, `docs/references/rules/work-lane-gating.md`, and `docs/references/rules/github-pr-delivery.md` instead of restating their full mechanics.
   - Future generated-post implementation work must pass the work-lane gate before source edits, then use issue-first `GH-123` branch delivery when PR workflow is selected.
   - Production deployment remains GitHub Pages publish-on-merge; after the user manually merges, the agent verifies Pages status and the post URL.

7. Keep the implementation sequence conservative.
   - Build the skill first, then the user-facing README pointer, then any minimal routing pointers, then validator coverage.
   - Validate after the docs/skill layer and again after the validator layer.
   - Do not parallelize edits that touch the same routing files; if subagents are used later, split only low-overlap work such as skill drafting, README/routing review, and validator analysis.

## COMPONENTS

1. Threaded blog-post skill
   - Path: `.agents/skills/threaded-blog-post/SKILL.md`.
   - Responsibilities: recognize exact `new_post` syntax, require one triple-quoted body, enforce review versus `no review`, derive title/slug/date/front matter, block on asset questions, define validation steps, hand off to PR rules, and define post-merge Pages verification.
   - Boundary: does not duplicate full git, issue, commit, PR, or Pages rules; it points to the existing rulesets.

2. Agent routing pointers
   - Paths: `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, and possibly `docs/agents/TOOLING.md`.
   - Responsibilities: make repo-local skills and the `new_post` trigger discoverable while preserving short routing-table shape.
   - Boundary: no detailed threaded-post procedure should live in these files.

3. User-facing documentation
   - Path: `README.md`.
   - Responsibilities: show the exact `new_post` syntax, explain normal review versus `no review`, summarize image handling, state that PRs are manually merged, and state that GitHub Pages is verified after merge.
   - Boundary: README should describe how to invoke and expect the workflow, not replace the skill.

4. Post source and assets
   - Paths: `_posts/YYYY-MM-DD-slug.md` and `assets/images/blog/*`.
   - Responsibilities: hold generated post content and explicitly approved post assets.
   - Boundary: no generated post or asset should be created during PLAN/TASKS phases; these files are touched only during actual post intake or test fixtures if later tasks require them.

5. Site validator
   - Path: `scripts/validate_site.rb`.
   - Responsibilities: validate generated site invariants after `bundle exec jekyll build`, including generic future-post front matter and rendered permalink checks.
   - Boundary: validator remains a simple repository script, not a framework, CI workflow, or schema package.

6. GitHub delivery rules
   - Paths: `docs/references/rules/safety-guardrails.md`, `docs/references/rules/work-lane-gating.md`, and `docs/references/rules/github-pr-delivery.md`.
   - Responsibilities: stay the authority for recon, lane gating, issue creation, branch naming, human author/committer identity, staging, commit, push, PR body, assignment, and PR checks.
   - Boundary: this feature should not fork, restate, or weaken those rules.

7. Production verification
   - Interfaces: `gh api repos/jamesonstone/jamesonstone.github.io/pages` and the expected production post URL under `https://jamesonstone.github.io/blog/YYYY/MM/DD/slug.html`.
   - Responsibilities: verify GitHub Pages status and URL availability after manual merge.
   - Boundary: no deploy command, branch mutation, repository setting change, or merge action is part of verification.

## DATA

1. Thread trigger shape
   - Source: user discussion text.
   - Shape: a line containing exactly `new_post`, optionally accompanied by `no review`, followed by one triple-quoted draft block.
   - Handling: missing or multiple draft blocks produce a clarification stop before file creation.

2. Review state
   - Values: normal review or `no review`.
   - Normal review: one concise review pass with no more than 5 clarifying questions before file creation.
   - `no review`: skip prose critique only; keep metadata generation, validation, git safety, and PR delivery.

3. Title and slug source
   - Preferred source: first Markdown `# Heading`.
   - Review fallback: suggest a title during review and use the accepted title.
   - `no review` fallback: pick a reasonable title from the draft and slugify it without an extra title-confirmation round.
   - Collision handling: stop for title or slug adjustment if the derived filename or permalink already exists.

4. Post front matter
   - Required keys: `layout`, `title`, and `date`.
   - Optional keys: `excerpt` and `tags` only when supplied or clearly useful.
   - Excluded by default: provenance and review flags such as `source: threaded_discussion` or `reviewed: true`.

5. Date and timezone
   - Default: current date in `America/New_York` at PR workflow time.
   - Explicit input: use only valid intentional dates; ambiguous dates produce a clarification stop.

6. Generated source files
   - Post path: `_posts/YYYY-MM-DD-slug.md`.
   - Asset path: `assets/images/blog/*`.
   - Asset references: site-root paths such as `/assets/images/blog/example.png`.

7. Delivery records
   - Issue: searched or created before branch creation.
   - Branch: exact `GH-123`.
   - PR: ready for review unless user asks for draft, assigned to `jamesonstone`, preserving `.github/pull_request_template.md` headings.
   - Production URL: `/blog/YYYY/MM/DD/slug.html` under the configured Pages URL.

## INTERFACES

1. Thread invocation interface
   - Input: a user thread containing `new_post` and a triple-quoted draft.
   - Output: either clarification questions, a proposed normalized draft, or a generated source post ready for validation and PR delivery.
   - Side effects: none until the user has passed review or chosen `no review` and the agent reaches source-file creation.

2. Repo-local skill interface
   - Input: active thread text plus repository context.
   - Output: deterministic agent procedure for intake, review, source creation, validation, delivery, and post-merge verification.
   - Side effects: the skill itself is documentation; future use may create post files, issues, branches, commits, PRs, and verification output.

3. README invocation interface
   - Input: human reader looking for how to create a post from a thread.
   - Output: concise syntax and lifecycle instructions.
   - Side effects: none.

4. Jekyll build interface
   - Command: `bundle exec jekyll build`.
   - Input: repository source files.
   - Output: generated `_site/` tree.
   - Side effects: `_site/` is generated locally and remains untracked.

5. Site validation interface
   - Command: `ruby scripts/validate_site.rb`.
   - Input: repository source files plus generated `_site/`.
   - Output: `validate_site: ok` or a specific invariant failure.
   - Side effects: none beyond reading source and generated output.

6. GitHub delivery interface
   - Commands and tooling: `gh` commands or an approved GitHub connector when `gh` is unavailable.
   - Input: accepted post source changes and issue/PR metadata.
   - Output: issue number, `GH-123` branch, commit, pushed branch, ready PR, assignee, and observed PR/check state.
   - Side effects: GitHub issue, branch, commit, push, and PR state after the user has opted into the implementation lane.

7. Pages verification interface
   - Command: `gh api repos/jamesonstone/jamesonstone.github.io/pages`.
   - URL: `https://jamesonstone.github.io/blog/YYYY/MM/DD/slug.html`.
   - Input: manually merged PR and expected post permalink.
   - Output: observed Pages status and reachable production post URL.
   - Side effects: none; verification must not mutate repository settings or run deployment.

## DEPENDENCIES

References are tracked in front matter.

Implementation depends on existing repo-local agent routing, Kit's `.agents/skills` directory convention, Jekyll and Bundler build commands, the current `_config.yml` permalink/defaults, the existing README authoring contract, `scripts/validate_site.rb`, authenticated GitHub CLI or an approved GitHub connector, and GitHub Pages branch publishing from `master`. No Figma asset, external API, dataset, custom deployment workflow, bot framework, or runtime service shapes the baseline strategy.

## RISKS

1. Repo-local skill discoverability may vary by agent surface.
   - Mitigation: create the skill at the canonical `.agents/skills/*/SKILL.md` path, add concise routing pointers only where needed, and include README invocation guidance for humans.

2. Trigger recognition could be too loose and create posts accidentally.
   - Mitigation: keep the skill grammar exact and require one triple-quoted draft block before file creation.

3. The validator may overfit legacy archive posts and miss future posts.
   - Mitigation: add generic post iteration checks that validate required front matter and rendered permalinks for all `_posts/*.md`, while retaining archive-specific checks separately.

4. Delivery instructions could drift from centralized PR rules.
   - Mitigation: the skill should summarize only sequence boundaries and point to the rulesets for detailed issue, branch, commit, push, PR, identity, and check behavior.

5. `no review` could be misread as bypassing safety gates.
   - Mitigation: define `no review` in skill and README as prose-review bypass only, and explicitly preserve validation plus git/GitHub safety gates.

6. GitHub Pages verification may lag after manual merge.
   - Mitigation: report observed Pages status and URL reachability separately; do not claim deployment success until the expected post URL is reachable.

7. Implementing on the active `GH-1` branch could mix this feature with the v2-blog PR.
   - Mitigation: future implementation must rerun safety recon, pass work-lane gating, and create or use an appropriate issue-number branch before source-code edits.

## TESTING

1. Front matter and reference validation
   - Evidence: `PLAN.md` front matter parses as YAML, confidence is at least 95, unresolved assumptions are 0, and `kit map 0002-ci-threaded-deployment` resolves PLAN references.
   - Maps to: plan sign-off and source-attributed implementation strategy.

2. Scaffold cleanup validation
   - Evidence: `PLAN.md` contains no unresolved marker comments, empty required sections, or scaffold-only prose.
   - Maps to: Kit completion bar.

3. Skill content review
   - Evidence: `.agents/skills/threaded-blog-post/SKILL.md` includes exact trigger grammar, review and `no review` behavior, title/date/front matter derivation, asset blocking, validation sequence, PR handoff, and Pages verification.
   - Maps to: threaded-post recognition and execution determinism.

4. Routing/documentation review
   - Evidence: README and any touched routing files point to the skill without duplicating the full workflow or becoming monolithic instruction files.
   - Maps to: discoverability with minimal always-loaded context.

5. Generated-post build validation
   - Evidence: after a representative generated post exists, `bundle exec jekyll build` succeeds and creates the expected `_site/blog/YYYY/MM/DD/slug.html` file.
   - Maps to: Jekyll source and permalink contract.

6. Site invariant validation
   - Evidence: `ruby scripts/validate_site.rb` succeeds after a build and fails with specific messages for missing required post front matter, missing rendered permalinks, missing local assets, hidden draft leakage, forbidden workflow files, or broken internal blog links.
   - Maps to: generic future-post validation and retained v2-blog invariants.

7. Delivery dry review
   - Evidence: the skill and README direct implementation agents to use `safety-guardrails`, `work-lane-gating`, and `github-pr-delivery` instead of custom branch, commit, PR, or merge rules.
   - Maps to: centralized issue/branch/PR workflow.

8. Post-merge verification review
   - Evidence: workflow text separates manual merge from Pages verification and names both Pages API status and the expected production post URL as evidence.
   - Maps to: production deployment semantics without custom deploy commands.
