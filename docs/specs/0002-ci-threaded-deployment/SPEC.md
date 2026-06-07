---
kit_metadata_version: 1
artifact: spec
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
    used_for: Bound this feature's discovery to the current artifact, explicit references, the v2-blog relationship, and source-attributed facts before planning implementation.
    status: active
relationships:
  - type: builds_on
    target: 0001-v2-blog
    relation: builds_on
    used_for: Reuses the source-first Jekyll blog contract, `_posts/YYYY-MM-DD-slug.md` post shape, validation baseline, and GitHub Pages publish-on-merge model established by v2-blog.
references:
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
    used_for: Spec-driven work classification, source-of-truth order, and clarification gate.
    status: active
  - id: guardrails-doc
    name: Guardrails doc
    type: repo_doc
    target: docs/agents/GUARDRAILS.md
    relation: guides
    read_policy: must
    used_for: Documentation completion bar and safety constraints.
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
    used_for: Project-directory workflow, repo-local skill discovery, dispatch policy, and secondary global input ordering.
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
    used_for: Confirmed current artifact state, phase, relationship shape, and reference resolution.
    status: active
  - id: v2-blog-spec
    name: v2-blog specification
    type: feature_doc
    target: docs/specs/0001-v2-blog/SPEC.md
    relation: constrains
    read_policy: must
    used_for: Existing source-first blog, Jekyll, short-post, low-friction Pages, and non-goal constraints.
    status: active
  - id: v2-blog-plan
    name: v2-blog plan
    type: feature_doc
    target: docs/specs/0001-v2-blog/PLAN.md
    relation: constrains
    read_policy: must
    used_for: Existing post-authoring, branch publishing, and validation strategy.
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
    read_policy: must
    used_for: Existing local route, migrated post, hidden draft, forbidden output, and link validation checks that should continue to gate generated posts.
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
    used_for: Distinguishes documentation-only phases from implementation and PR delivery lanes.
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
  - id: secondary-global-inputs
    name: Secondary global instruction inputs
    type: global_doc
    target: docs/agents/TOOLING.md
    selector_type: heading
    selector: Secondary Global Inputs
    relation: informs
    read_policy: conditional
    used_for: Confirmed no additional canonical skill beyond RLM was required for this spec phase after repo-local discovery.
    status: active
---
# SPEC

## SUMMARY

Adds a repo-local threaded blog-post workflow so a `new_post` marker plus a triple-quoted draft can become a reviewed Jekyll post, GitHub issue, `GH-123` branch, ready PR, and post-merge GitHub Pages verification. The feature must preserve the existing source-first blog contract, manual merge boundary, and centralized PR/safety rules without adding a custom deployment platform.

## PROBLEM

The site now has a clean source-first Jekyll blog, but creating a new post from a rough Codex thread still requires the agent to infer intent, draft structure, metadata, validation, issue creation, branch naming, PR delivery, and production verification from scattered context. That slows down short-post publishing and increases the chance that agents will skip review, choose inconsistent post metadata, duplicate PR rules, or treat GitHub Pages deployment as a custom automation problem.

## GOALS

1. Define an agent-recognizable `new_post` thread grammar that safely distinguishes real post-intake requests from ordinary discussion.
2. Preserve fast author flow by accepting rough draft prose in a triple-quoted block and turning it into one Jekyll post source file.
3. Provide one concise review pass by default, with up to 5 clarifying questions before file creation.
4. Support `no review` as a prose-review bypass while keeping mechanical validation, safety checks, and PR delivery intact.
5. Use the existing blog source contract: `_posts/YYYY-MM-DD-slug.md`, required front matter, optional blog images, local Jekyll build, and site validation.
6. Deliver generated posts through the repository's required GitHub issue, `GH-123` branch, commit, push, ready PR, assignment, and PR-check reporting workflow.
7. Leave production publishing to the current GitHub Pages publish-on-merge setup and verify Pages status plus the production URL after the user manually merges.
8. Keep detailed workflow behavior in a repo-local skill or similarly discoverable repo-local guidance instead of expanding always-loaded routing files.

## NON-GOALS

1. Do not add a custom GitHub Actions deployment workflow, Pages settings change, bot, webhook service, database, queue, or server runtime as the baseline solution.
2. Do not let the agent merge PRs, bypass human review, force-push, delete branches, change repository settings, or alter protected branch rules.
3. Do not treat `no review` as permission to skip validation, issue/branch/PR rules, secret checks, author identity checks, or build checks.
4. Do not add provenance front matter such as `source: threaded_discussion` or `reviewed: true` by default.
5. Do not generate, search for, download, or add remote images without explicit user approval.
6. Do not loosen the post trigger into broad keyword matching that could accidentally turn normal thread text into a blog post.
7. Do not duplicate the full GitHub PR delivery rules inside the new workflow; reference the existing ruleset as the delivery authority.

## USERS

1. Jameson Stone, who wants to publish short blog posts from Codex discussion threads with minimal friction and clear review points.
2. Future coding agents operating in this repository, who need a precise trigger, workflow, and safety boundary for new post creation.
3. Public readers of `jamesonstone.github.io`, who should see only validated, intentionally published blog posts after manual merge and GitHub Pages build.

## SKILLS

Skills are tracked in canonical front matter.

The selected spec-stage skill is `rlm`, backed by `docs/agents/RLM.md`, because this feature spans agent workflow, prior feature contracts, GitHub delivery rules, and publishing behavior where full-repository loading would be noisy. The implementation itself must add a repo-local threaded-post skill or equivalent discoverable repo-local guidance so future agents can recognize `new_post` without bloating `AGENTS.md`, `CLAUDE.md`, or `.github/copilot-instructions.md`.

## RELATIONSHIPS

Relationships are tracked in canonical front matter.

This feature builds on `0001-v2-blog`. The prior feature established the Jekyll blog structure, post filename and permalink behavior, validation baseline, low-friction GitHub Pages deployment model, and non-goal of adding unnecessary app or deployment complexity.

## DEPENDENCIES

References are tracked in canonical front matter.

The feature depends on the existing Jekyll/GitHub Pages repository structure, the v2-blog post authoring contract, the repository safety and PR delivery rulesets, authenticated GitHub CLI or an approved GitHub connector for issue/PR/Page-status operations, and the user's manual review and merge step. No external design system, third-party content API, custom CI deployment platform, or runtime service is required for the baseline contract.

## REQUIREMENTS

1. The workflow must trigger only when a thread contains a line with exactly `new_post`, followed by one triple-quoted content block containing the draft post.
2. The workflow must allow the user to include `no review` with the request to skip editorial critique and clarification questions.
3. When review is enabled, the agent must run one concise review pass and ask no more than 5 clarifying questions before creating post files.
4. When `no review` is supplied, the agent must still derive metadata, validate the post, follow git/GitHub safety rules, and deliver through a PR.
5. The post title must come from the first Markdown `# Heading` when present.
6. If no `# Heading` is present and review is enabled, the agent must suggest a title during the review phase and use the accepted title for slug generation.
7. If no `# Heading` is present and `no review` is supplied, the agent must pick a reasonable title from the draft content and slugify it without an extra title-confirmation round.
8. The filename and front matter date must use the current date in `America/New_York` unless the thread provides an explicit date.
9. Required front matter must remain `layout`, `title`, and `date`.
10. Optional `excerpt` and `tags` may be added only when provided by the user or clearly useful for the post.
11. The generated post must use the existing `_posts/YYYY-MM-DD-slug.md` source shape and the existing `/blog/:year/:month/:day/:title.html` permalink contract.
12. If draft content references images or other assets, the agent must pause before PR creation and ask for asset source and alt text.
13. Approved image assets must use the existing `assets/images/blog/` convention and site-root references such as `/assets/images/blog/example.png`.
14. The implementation must provide discoverable repo-local guidance, preferably `.agents/skills/threaded-blog-post/SKILL.md`, covering trigger recognition, content extraction, review behavior, post generation, validation, PR delivery handoff, and post-merge verification.
15. The implementation may add short pointers in routing files or README documentation when needed, but always-loaded routing files must remain concise maps rather than full manuals.
16. The delivery workflow must use the existing `docs/references/rules/safety-guardrails.md`, `docs/references/rules/work-lane-gating.md`, and `docs/references/rules/github-pr-delivery.md` as authority for recon, issue creation, branch naming, identity, staging, commit, push, PR creation, assignment, and PR checks.
17. A generated-post PR must be ready for review unless the user explicitly asks for a draft PR.
18. The agent must prompt the user to review and manually merge the PR; the agent must not merge it.
19. After manual merge, the agent must verify GitHub Pages status and the production post URL instead of running a custom deploy command by default.
20. The existing site validator must continue to guard core site invariants and should cover new generated posts generically enough that future non-archive posts are not excluded from validation.

## ACCEPTANCE

1. Given a thread containing exact `new_post` syntax and one triple-quoted draft, a future agent can identify the request and enter the threaded-post workflow without broad repository scanning.
2. Given a `new_post` draft with a `# Heading`, the workflow creates one post source file whose title and slug come from that heading.
3. Given a `new_post` draft without a `# Heading` and normal review mode, the workflow asks for or suggests a title before creating the post file.
4. Given a `new_post no review` draft without a `# Heading`, the workflow picks a reasonable title, creates the post file, and still runs validation and PR delivery checks.
5. Given draft content that references an image, the workflow stops before creating or committing assets until the user provides asset source and alt text.
6. The implementation includes repo-local discoverable guidance for the threaded-post workflow and does not expand top-level routing files into monolithic instructions.
7. A generated post follows the existing `_posts/YYYY-MM-DD-slug.md` and YAML front matter contract and builds under the existing Jekyll site configuration.
8. Verification for generated posts includes the relevant local Jekyll build and `scripts/validate_site.rb` checks.
9. Issue, branch, commit, push, PR, assignee, and PR-check behavior conform to `docs/references/rules/github-pr-delivery.md`.
10. After the user manually merges a generated-post PR, the workflow verifies GitHub Pages status and confirms the production URL for the new post.
11. No baseline implementation adds custom deployment infrastructure, bot services, repository setting changes, force-push behavior, branch deletion, or agent-performed merges.

## EDGE-CASES

1. If the thread contains `new_post` but no triple-quoted content block, the agent must ask for the missing draft content before creating files.
2. If the thread contains multiple triple-quoted blocks, the agent must ask which block is the post body unless the user's intent is unambiguous.
3. If the derived slug collides with an existing post filename or production permalink, the agent must ask for a title or slug adjustment before committing.
4. If the draft provides an explicit date, the agent must use it only when it is valid and intentional; otherwise it must ask for clarification.
5. If optional metadata is ambiguous, the agent must prefer the minimal required front matter instead of inventing tags or excerpts.
6. If GitHub authentication, issue lookup, branch creation, push, PR creation, Pages status lookup, build, or validation fails, the agent must stop and report the exact failure instead of retrying with unsafe mutation.
7. If the active branch, PR state, or dirty working tree does not match the intended generated-post work lane, the agent must stop and ask how to proceed.
8. If generated content appears to include secrets, private data, or machine-local configuration, the agent must stop before staging and ask for confirmation or redaction.
9. If the user asks for production deployment before the PR is merged, the agent must explain that production publishing occurs after manual merge through GitHub Pages.
10. If GitHub Pages status is built but the production URL is not yet live, the agent must report the observed state and avoid claiming deployment success until the URL is reachable.

## OPEN-QUESTIONS

none
