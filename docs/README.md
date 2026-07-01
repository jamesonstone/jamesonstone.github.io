# Project Documentation

## Purpose

This directory holds the durable operating context for `jamesonstone.github.io`, a source-first Jekyll personal site.

Use this index to find the right canonical document before editing site code, content, workflow rules, or generated instruction files.

## Map

- `CONSTITUTION.md` — project-wide principles, constraints, non-goals, definitions, and workflow classification.
- `PROJECT_PROGRESS_SUMMARY.md` — feature inventory and current project state.
- `commands.md` — project command guidance for local site work, validation, and Kit maintenance commands.
- `agents/README.md` — entrypoint for repo-local agent routing.
- `references/README.md` — durable references and rulesets that are broader than one feature.
- `specs/<feature>/SPEC.md` — canonical V2 feature source of truth.
- `notes/<feature>/` — optional source material, not canonical truth.

## Current Documentation Model

- V2 feature work keeps requirements, plan, tasks, validation, reflection, delivery, and evidence in one `SPEC.md`.
- Legacy `BRAINSTORM.md`, `PLAN.md`, and `TASKS.md` files remain historical unless a legacy staged command is explicitly used.
- Generated instruction entrypoints should stay short and route to `docs/agents/*`.
- Registry rulesets under `docs/references/rules/*` should be loaded just in time for the decision they govern.

## Site-Specific Invariants

- Keep the site static, source-first, and Jekyll/GitHub Pages friendly.
- Keep `_site/` and local dependency output untracked.
- Keep `/llms.txt` current with public pages, RSS, latest posts, and public project links.
- Use repo-local Kit delivery rules before creating or mutating GitHub issues, branches, commits, pushes, or pull requests.
