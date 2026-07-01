# CONSTITUTION

## PRINCIPLES

- This repository is the source-first personal site for Jameson Stone: writing, archive posts, paintings, projects, and lightweight public context.
- Reading quality, durable content, and simple maintenance outrank app-like behavior, broad automation, or visual novelty.
- Public site content must be intentional, reviewable, and represented in source files before it appears in generated output.
- Repository guidance should stay small at always-loaded entrypoints and route agents to canonical docs under `docs/`.
- Kit-managed workflow rules are project policy in this repository; global agent defaults are fallback tools, not the delivery contract.

## CONSTRAINTS

- Keep the site static and GitHub Pages friendly unless a future feature proves a concrete need for additional infrastructure.
- Keep generated output such as `_site/` untracked and treat source files, docs, and validation scripts as the maintained surface.
- Preserve the source-first Jekyll post contract: posts live under `_posts/`, use YAML front matter, and render under `/blog/YYYY/MM/DD/slug.html`.
- Keep `/llms.txt` current with public pages, feeds, latest posts, and public project links whenever those surfaces change.
- Deliver implementation work through the repo-local GitHub issue, `GH-123` branch, explicit staging, human-authored commit, and ready-PR workflow when PR delivery is requested.

### Kit-Managed Baseline Rules

<!-- BEGIN KIT-MANAGED BASELINE RULES -->
- Treat `docs/CONSTITUTION.md` as the canonical project contract.
- Keep `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` aligned with the repo-local docs tree.
- Treat `docs/notes/<feature>` as optional source material, not canonical truth; promote durable decisions into `SPEC.md`, `docs/CONSTITUTION.md`, or durable references.
- Prefer implementation/source code files around 300 lines or less when splitting improves clarity and ownership.
- Do not apply the code-file size guideline to documentation files, all `docs/**`, all `.kit/**`, or `.kit.yaml`.
- Do not split or rewrite docs, generated state, or Kit config artifacts solely because they exceed 300 lines.
<!-- END KIT-MANAGED BASELINE RULES -->
## CHANGE CLASSIFICATION

All work falls into one of two tracks; classify before acting.

### Spec-Driven (Formal)

Use this for new features, substantial architectural or behavioral changes, or work already covered by feature docs. V2 feature work uses `docs/specs/<feature>/SPEC.md` as the durable feature artifact.

### Ad Hoc (Lightweight)

Use this for contained bug fixes, reviews, dependency updates, config changes, small refinements, and documentation maintenance. Update only practical docs unless a feature spec or durable rule is directly affected.

### Ad Hoc with Existing Specs

If a change touches behavior covered by existing specs, update the relevant spec unless the change is purely mechanical.

## NON-GOALS

- Do not turn the site into a SaaS landing page, portfolio funnel, CMS, SPA, server-rendered application, analytics platform, or newsletter system by default.
- Do not publish private notes, hidden drafts, local machine configuration, credentials, or private operational context.
- Do not add custom deployment infrastructure, GitHub Actions publishing, or repository settings changes without a concrete feature need and explicit approval.
- Do not use generic GitHub delivery defaults when repo-local Kit delivery rules define a different issue, branch, commit, PR, or staging contract.
- Do not duplicate full feature context in always-loaded instruction files; route through `docs/agents/*`, `docs/references/*`, and feature docs instead.

## DEFINITIONS

- **Source-first site**: The canonical site state is maintained in Markdown, layouts, assets, config, scripts, and docs; generated `_site/` output is disposable.
- **Feature docs**: V2 feature work lives in `docs/specs/<feature>/SPEC.md`; legacy staged artifacts may remain as historical context.
- **Feature notes**: Optional source material under `docs/notes/<feature>` that may inform work but is not canonical truth.
- **Durable references**: Project-wide guidance under `docs/references/`, including rulesets that should be loaded only when relevant.
- **Generated output**: Build products, copied site output, and local dependency artifacts that should not be treated as source of truth.
- **`/llms.txt`**: A root Markdown index for LLM-friendly site context that must stay current with public content and project links.
