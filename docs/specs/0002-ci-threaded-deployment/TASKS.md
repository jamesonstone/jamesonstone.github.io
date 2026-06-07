---
kit_metadata_version: 1
artifact: tasks
feature:
  id: 0002
  slug: ci-threaded-deployment
  dir: 0002-ci-threaded-deployment
parallelization_mode: "rlm"
confidence: 96
unresolved_assumptions: 0
---
# TASKS

## PROGRESS TABLE

| ID | TASK | STATUS | OWNER | DEPENDENCIES |
| -- | ---- | ------ | ----- | ------------ |
| T001 | Establish implementation lane and PR delivery state | done | agent | |
| T002 | Create repo-local threaded blog-post skill | done | agent | T001 |
| T003 | Add user-facing README workflow guidance | done | agent | T002 |
| T004 | Add concise agent routing pointers | done | agent | T002, T003 |
| T005 | Extend generic generated-post validation | done | agent | T001 |
| T006 | Run build and validator evidence checks | done | agent | T003, T004, T005 |
| T007 | Review scope, safety, and workflow conformance | done | agent | T006 |
| T008 | Deliver implementation through issue-number PR | done | agent | T007 |

## TASK LIST

- [x] T001: Establish implementation lane and PR delivery state [PLAN-APPROACH](./PLAN.md#approach)
- [x] T002: Create repo-local threaded blog-post skill [PLAN-COMPONENTS](./PLAN.md#components)
- [x] T003: Add user-facing README workflow guidance [PLAN-INTERFACES](./PLAN.md#interfaces)
- [x] T004: Add concise agent routing pointers [PLAN-APPROACH](./PLAN.md#approach)
- [x] T005: Extend generic generated-post validation [PLAN-COMPONENTS](./PLAN.md#components)
- [x] T006: Run build and validator evidence checks [PLAN-TESTING](./PLAN.md#testing)
- [x] T007: Review scope, safety, and workflow conformance [PLAN-RISKS](./PLAN.md#risks)
- [x] T008: Deliver implementation through issue-number PR [PLAN-INTERFACES](./PLAN.md#interfaces)

## TASK DETAILS

### T001
- **GOAL**: Start implementation from a clean, traceable GitHub issue-number lane without mixing this feature into the active `GH-1` v2-blog PR.
- **SCOPE**:
  - Run required safety recon in the existing project directory.
  - Classify the work as implementation and record the work-lane decision.
  - Discover the default branch without assuming `master`.
  - Search for an existing matching issue; create one only if no strong match exists.
  - Create or switch to the exact `GH-123` branch from freshly fetched `origin/<base>`.
  - Confirm no active PR or branch mismatch before source edits.
- **ACCEPTANCE**:
  - No implementation files are edited before this task completes.
  - Issue number and URL are known.
  - Active branch is exactly `GH-123` for the selected issue.
  - Branch HEAD matches the freshly fetched remote base immediately after branch creation.
  - Active PR state for the branch is inspected and reported.
- **VERIFY**:
  - `pwd`
  - `git status --short --branch`
  - `git remote -v`
  - `git rev-parse --abbrev-ref HEAD`
  - `gh pr list --head GH-3 --state all --json number,url,state,isDraft,headRefName,baseRefName,assignees`
  - `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
  - `gh issue view 3 --json number,title,url,state`
  - `git fetch origin GH-1`
  - `git branch --show-current`
  - `git merge-base --is-ancestor origin/GH-1 HEAD`
- **EXPECTED FILES**:
  - none
- **RISK**: High because starting from the wrong branch would mix this implementation with unrelated PR work.
- **ROLLBACK**: Stop before edits if branch, issue, PR, auth, or base-state checks disagree; do not reset, force-push, rebase, or delete branches.
- **NOTES**: This task is implementation setup, not part of the TASKS.md authoring phase.
  - Resolved lane decision: user explicitly approved stacking `0002-ci-threaded-deployment` on the existing `GH-1` v2-blog branch.
  - Issue #3 was created for this implementation and branch `GH-3` was created from freshly fetched `origin/GH-1`; no active PR existed for `GH-3` at setup time.

### T002
- **GOAL**: Add the canonical skill that future agents use to recognize and execute the `new_post` workflow.
- **SCOPE**:
  - Create `.agents/skills/threaded-blog-post/SKILL.md`.
  - Define exact trigger grammar: a line containing `new_post` and one triple-quoted draft block.
  - Define normal review and `no review` behavior.
  - Define title, slug, date, front matter, and collision handling.
  - Define image and asset pause behavior.
  - Point to existing safety, work-lane, and PR delivery rules instead of duplicating them.
  - Define post-merge GitHub Pages status and production URL verification.
- **ACCEPTANCE**:
  - The skill file exists at the canonical repo-local path.
  - The skill can be followed without consulting the brainstorm.
  - The skill preserves all SPEC requirements and PLAN boundaries.
  - The skill contains no custom deploy, bot, runtime service, broad keyword trigger, or agent-merge instruction.
- **VERIFY**:
  - `test -f .agents/skills/threaded-blog-post/SKILL.md`
  - `rg -n "new_post|no review|triple|# Heading|assets/images/blog|github-pr-delivery|GitHub Pages|manual merge" .agents/skills/threaded-blog-post/SKILL.md`
- **EXPECTED FILES**:
  - `.agents/skills/threaded-blog-post/SKILL.md`
- **RISK**: Medium because unclear skill wording could cause accidental post creation or skipped safety gates.
- **ROLLBACK**: Remove only `.agents/skills/threaded-blog-post/SKILL.md` if the skill direction is rejected before it is used.
- **NOTES**: Keep the skill procedural and concise; do not make it a second monolithic manual.

### T003
- **GOAL**: Give humans a concise way to invoke the threaded post workflow from the repository README.
- **SCOPE**:
  - Update the existing `README.md` new-post section.
  - Show the exact `new_post` plus triple-quoted draft syntax.
  - Explain normal review versus `no review`.
  - Summarize title fallback, image pause behavior, PR review, manual merge, and Pages verification.
  - Link behavior back to the repo-local skill without duplicating every procedural step.
- **ACCEPTANCE**:
  - README explains how to invoke the workflow from a thread.
  - README preserves the existing `_posts/YYYY-MM-DD-slug.md` and front matter guidance.
  - README states that `no review` does not bypass validation or PR safety.
  - README states that production publishing follows manual merge plus GitHub Pages verification.
- **VERIFY**:
  - `rg -n "new_post|no review|triple|manual merge|GitHub Pages|.agents/skills/threaded-blog-post/SKILL.md" README.md`
- **EXPECTED FILES**:
  - `README.md`
- **RISK**: Low because README changes are documentation-only, but overlong prose could duplicate the skill.
- **ROLLBACK**: Revert only the README section if the user-facing wording is rejected.
- **NOTES**: Keep examples small and source-safe; do not include an actual blog post draft.

### T004
- **GOAL**: Make the new repo-local skill discoverable without expanding always-loaded routing files into full manuals.
- **SCOPE**:
  - Inspect `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, and `docs/agents/TOOLING.md`.
  - Add a concise repo-local skills or `new_post` pointer only where needed.
  - Keep detailed workflow behavior in `.agents/skills/threaded-blog-post/SKILL.md`.
  - Keep `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` aligned if any routing pointer is added.
- **ACCEPTANCE**:
  - Future agents have a clear path to the threaded-post skill.
  - Top-level routing files remain short maps.
  - No routing file duplicates the full trigger, review, PR, or Pages verification procedure.
  - Any touched routing file still points back to repo-local docs or the skill.
- **VERIFY**:
  - `rg -n "threaded-blog-post|new_post|repo-local skills|.agents/skills" AGENTS.md CLAUDE.md .github/copilot-instructions.md docs/agents/TOOLING.md`
  - `wc -l AGENTS.md CLAUDE.md .github/copilot-instructions.md`
- **EXPECTED FILES**:
  - `AGENTS.md`
  - `CLAUDE.md`
  - `.github/copilot-instructions.md`
  - `docs/agents/TOOLING.md`
- **RISK**: Medium because unnecessary routing expansion would violate the repo's routing-table constraint.
- **ROLLBACK**: Revert only routing pointer edits if they duplicate the skill or make the files too broad.
- **NOTES**: If inspection proves a file already has sufficient skill discovery, leave it unchanged and record that in final verification.

### T005
- **GOAL**: Extend site validation so generated future posts are checked generically, not only through the legacy archive list.
- **SCOPE**:
  - Update `scripts/validate_site.rb`.
  - Iterate all `_posts/*.md`.
  - Validate required post front matter: `layout`, `title`, and `date`.
  - Validate rendered permalink exists under `_site/blog/YYYY/MM/DD/slug.html`.
  - Preserve legacy archive-specific checks for migrated posts.
  - Preserve existing route, hidden draft, forbidden output, custom workflow, local asset, and internal blog-link checks.
  - Add focused regression tests for generic post metadata and permalink validation.
- **ACCEPTANCE**:
  - Validator fails with specific messages for missing required post metadata.
  - Validator fails with a specific message when a post's rendered permalink is missing.
  - Existing legacy archive checks remain intact.
  - No custom workflow, schema package, external dependency, or CI configuration is introduced.
- **VERIFY**:
  - `ruby -c scripts/validate_site.rb`
  - `ruby -c scripts/validate_site_test.rb`
  - `ruby scripts/validate_site_test.rb`
  - `bundle exec jekyll build`
  - `ruby scripts/validate_site.rb`
- **EXPECTED FILES**:
  - `scripts/validate_site.rb`
  - `scripts/validate_site_test.rb`
- **RISK**: Medium because validator changes can break existing archive validation if the generic and legacy paths are not separated cleanly.
- **ROLLBACK**: Revert only `scripts/validate_site.rb` if validation behavior regresses.
- **NOTES**: Do not add provenance fields or require `excerpt` or `tags`.

### T006
- **GOAL**: Produce objective evidence that the skill/docs/validator implementation works against the current site.
- **SCOPE**:
  - Run syntax checks for the validator.
  - Run Jekyll build.
  - Run site validation.
  - Review the skill and README for required trigger, review, asset, PR, and Pages semantics.
  - Inspect for forbidden new deployment surface.
- **ACCEPTANCE**:
  - `bundle exec jekyll build` succeeds.
  - `ruby scripts/validate_site.rb` succeeds after the build.
  - `ruby scripts/validate_site_test.rb` succeeds.
  - Required skill and README strings are present.
  - No `.github/workflows/*` file is introduced.
  - `_site/` remains untracked.
- **VERIFY**:
  - `ruby -c scripts/validate_site.rb`
  - `ruby -c scripts/validate_site_test.rb`
  - `ruby scripts/validate_site_test.rb`
  - `bundle exec jekyll build`
  - `ruby scripts/validate_site.rb`
  - `rg -n "new_post|no review|manual merge|GitHub Pages" .agents/skills/threaded-blog-post/SKILL.md README.md`
  - `find .github -maxdepth 2 -path .github/workflows/* -type f -print`
  - `git status --short --branch`
- **EXPECTED FILES**:
  - none
- **RISK**: Low because this task should only run checks, but generated `_site/` must stay untracked.
- **ROLLBACK**: Remove generated `_site/` only if repo conventions allow local generated-output cleanup; never stage it.
- **NOTES**: If dependencies are missing, stop and report the exact missing command or dependency rather than changing runtime configuration outside scope.

### T007
- **GOAL**: Confirm the implementation stayed inside SPEC and PLAN scope before staging.
- **SCOPE**:
  - Review diffs for all changed files.
  - Confirm no custom deployment workflow, bot, runtime service, new dependency, generated post, generated asset, or repository setting change was added.
  - Confirm top-level routing files remain concise.
  - Confirm safety and PR delivery rules are referenced rather than duplicated.
  - Scan changed files for secrets, local config, private keys, and machine-local paths that should not be committed.
- **ACCEPTANCE**:
  - Diff review maps each changed file to a task and PLAN section.
  - No non-goal files or behavior are present.
  - No secrets or machine-local config are staged or ready to stage.
  - Any remaining implementation risk is documented in final handoff.
- **VERIFY**:
  - `git diff origin/GH-1..HEAD -- .agents/skills/threaded-blog-post/SKILL.md README.md AGENTS.md CLAUDE.md .github/copilot-instructions.md docs/agents/TOOLING.md scripts/validate_site.rb scripts/validate_site_test.rb`
  - `rg -n "CNAME|workflow_dispatch|deploy|force-push|merge the PR|Generated-by|Co-authored-by|source: threaded_discussion|reviewed: true" .agents README.md AGENTS.md CLAUDE.md .github scripts`
  - `find .github -maxdepth 2 -path .github/workflows/* -type f -print`
- **EXPECTED FILES**:
  - none
- **RISK**: Medium because this is the last point to catch scope creep before staging.
- **ROLLBACK**: Revert only offending scoped files before staging; do not use destructive git commands.
- **NOTES**: Treat any unrelated dirty file as user work and leave it alone.

### T008
- **GOAL**: Deliver the completed implementation through the repository's required issue-number PR workflow.
- **SCOPE**:
  - Stage only reviewed files explicitly.
  - Confirm human author and committer identity before commit.
  - Commit with the required `<type>(GH-123): <gitmoji> <message>` format.
  - Push the issue-number branch.
  - Create or update a ready PR using `.github/pull_request_template.md`.
  - Assign `jamesonstone`.
  - Report PR URL, checks, author/committer identity, and verification evidence.
- **ACCEPTANCE**:
  - Only intended files are staged.
  - Staged diff is reviewed before commit.
  - Commit author and committer are the human user.
  - PR is ready for review, not draft, unless explicitly requested otherwise.
  - PR body preserves `Description`, `How to Test`, and `Ticket` headings.
  - PR checks are observed and reported as passing, pending, failing, unavailable, or not run.
- **VERIFY**:
  - `git diff origin/GH-1..HEAD --stat`
  - `git diff --staged`
  - `git config user.name`
  - `git config user.email`
  - `git var GIT_AUTHOR_IDENT`
  - `git var GIT_COMMITTER_IDENT`
  - `git status --short --branch`
  - `gh pr list --head GH-3 --state all --json number,url,state,isDraft,headRefName,baseRefName,assignees`
  - `gh pr view 4 --json number,url,author,state,isDraft,assignees,baseRefName,headRefName,statusCheckRollup`
  - `gh issue view 3 --json number,title,state,url`
- **EXPECTED FILES**:
  - `.agents/skills/threaded-blog-post/SKILL.md`
  - `README.md`
  - `AGENTS.md`
  - `CLAUDE.md`
  - `.github/copilot-instructions.md`
  - `docs/agents/TOOLING.md`
  - `scripts/validate_site.rb`
  - `scripts/validate_site_test.rb`
  - `docs/PROJECT_PROGRESS_SUMMARY.md`
  - `docs/specs/0002-ci-threaded-deployment/BRAINSTORM.md`
  - `docs/specs/0002-ci-threaded-deployment/SPEC.md`
  - `docs/specs/0002-ci-threaded-deployment/PLAN.md`
  - `docs/specs/0002-ci-threaded-deployment/TASKS.md`
  - `docs/notes/0002-ci-threaded-deployment/.gitkeep`
- **RISK**: High because delivery mutates git and GitHub state.
- **ROLLBACK**: Follow `docs/references/rules/safety-guardrails.md`; stop on any failure and do not force-push, rebase, reset, amend pushed commits, delete branches, or recreate issues/PRs.
- **NOTES**: If some optional routing files were not changed in T004, do not stage them.

## DEPENDENCIES

1. T001 blocked implementation edits until the user explicitly approved stacking this feature on the active `GH-1` v2-blog baseline; implementation now proceeds on issue branch `GH-3`.
2. T002 must precede README and routing changes because the skill is the canonical detailed workflow.
3. T003 and T004 may be reviewed together after T002, but both must finish before full documentation verification.
4. T005 can proceed after T001 and does not depend on routing changes, but T006 must wait for T003, T004, and T005.
5. T008 must wait for all implementation and verification tasks.
6. Implementation-lane decision is resolved: issue #3 and branch `GH-3` were created for a stacked `0002` implementation based on `origin/GH-1`.

## NOTES

1. The TASKS authoring phase itself did not create an issue, branch, PR, skill file, README edit, routing edit, validator edit, generated post, generated asset, or build output; those implementation changes are tracked by the completed tasks above.
2. The implementation must rerun safety recon after any thread resume before editing source files.
3. Any explicit user request to create an issue, branch, or PR during implementation overrides the non-implementation exclusion only after the requested PR workflow consent is clear.
