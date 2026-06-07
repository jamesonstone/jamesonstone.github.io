# PROJECT PROGRESS SUMMARY

## FEATURE PROGRESS TABLE

| ID | FEATURE | PATH | PHASE | PAUSED | CREATED | SUMMARY |
| -- | ------- | ---- | ----- | ------ | ------- | ------- |
| 0001 | v2-blog | `docs/specs/0001-v2-blog` | complete | no | 2026-06-07 | Rebuild `jamesonstone.github.io` as a source-first, readable Jekyll blog for concise Markdown posts, with public legacy `jstone28.github.io` content migrated into archives. The feature must keep deployment low-friction through GitHub Pages, exclude unpublished hidden drafts, normalize public identity to `jamesonstone`, and avoid unnecessary app or frontend build complexity. |
| 0002 | ci-threaded-deployment | `docs/specs/0002-ci-threaded-deployment` | review | no | 2026-06-07 | Adds a repo-local threaded blog-post workflow so a `new_post` marker plus a triple-quoted draft can become a reviewed Jekyll post, GitHub issue, `GH-123` branch, ready PR, and post-merge GitHub Pages verification. The feature must preserve the existing source-first blog contract, manual merge boundary, and centralized PR/safety rules without adding a custom deployment platform. |

## PROJECT INTENT

Kit is a document-first workflow harness for disciplined thought work. It keeps durable project context in canonical markdown artifacts so humans and coding agents can move from research to specification, planning, tasks, implementation, reflection, and completion with explicit traceability.

## GLOBAL CONSTRAINTS

See `docs/CONSTITUTION.md` for project-wide constraints and principles.

## FEATURE SUMMARIES

### v2-blog

- **STATUS**: complete
- **PAUSED**: no
- **INTENT**: The current site is an old generated GitHub Pages shell rather than a useful personal blog. It still carries starter-template content, stale `jstone28` identity links, legacy theme assets, a single Textile post, and no clear Codex-friendly path for creating and publishing short Markdown posts.
- **APPROACH**: Execute 12 ordered tasks: establish Jekyll dependency/source hygiene, create layouts/pages, derive migration dates, migrate posts/assets/paintings, normalize identity, style responsively, document authoring, then validate build, scope, and rendered output.
- **OPEN ITEMS**: none.
- **POINTERS**: `docs/specs/0001-v2-blog/BRAINSTORM.md`, `docs/specs/0001-v2-blog/SPEC.md`, `docs/specs/0001-v2-blog/PLAN.md`, `docs/specs/0001-v2-blog/TASKS.md`

### ci-threaded-deployment

- **STATUS**: review
- **PAUSED**: no
- **INTENT**: The site now has a clean source-first Jekyll blog, but creating a new post from a rough Codex thread still requires the agent to infer intent, draft structure, metadata, validation, issue creation, branch naming, PR delivery, and production verification from scattered context. That slows down short-post publishing and increases the chance that agents will skip review, choose inconsistent post metadata, duplicate PR rules, or treat GitHub Pages deployment as a custom automation problem.
- **APPROACH**: Completed 8 ordered tasks: safe issue-number implementation lane on `GH-3`, threaded-post skill, README guidance, concise routing pointer, generic post validation, build/validator evidence checks, scope/safety review, and ready PR delivery.
- **OPEN ITEMS**: PR #4 is open for manual review and merge; after merge, future generated-post workflows should verify GitHub Pages status and the expected production URL.
- **POINTERS**: `docs/specs/0002-ci-threaded-deployment/BRAINSTORM.md`, `docs/specs/0002-ci-threaded-deployment/SPEC.md`, `docs/specs/0002-ci-threaded-deployment/PLAN.md`, `docs/specs/0002-ci-threaded-deployment/TASKS.md`

## LAST UPDATED

2026-06-07 17:28:40 EDT
