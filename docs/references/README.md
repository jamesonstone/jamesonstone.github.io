# References

## Purpose

- This directory holds durable repo-local references that are broader than one feature
- Keep long-lived background context here instead of in injected top-level instruction files
- Link these files from feature front matter references when they materially shape work
- Store durable rulesets under `rules/<slug>.md` and link them with `kit rules link` instead of copying rules into agent instruction files
- Use `rules/kit-capabilities-usage.md` in downstream projects for Kit command discovery guidance
- Use `rules/feature-notes.md` when deciding how to load, reference, promote, or ignore source material under `docs/notes/<feature>`
- Use `kit rules add` to import or activate available registry rulesets from the Kit GitHub `main` branch
- Use `kit rules view <slug>` to preview a local or registry ruleset before importing it
- Use `kit init --refresh` to adopt existing registry rules into `.kit.yaml` registry state and pick up safe upstream ruleset updates
- Use `kit rules add --custom` for the interactive `$EDITOR` ruleset builder
- `kit rule` is the singular alias for `kit rules`

## Starter Files

- `testing.md` — repo-wide testing norms and evidence expectations
- `tooling.md` — local tooling and command references that are broader than one feature
- `external-systems.md` — durable notes about external systems, APIs, or integrations
- `rules/` — pointer-loaded durable rulesets such as frontend UI rules, testing rules, API conventions, security constraints, or domain rules
- `../notes/<feature>/` — optional feature source material; not canonical truth and private contents remain ignored

## Active Rulesets

- `rules/agent-team-orchestration.md` — accountable supervisor, subagent lane, concurrency, and verification topology.
- `rules/feature-notes.md` — optional feature source-material structure and promotion rules.
- `rules/github-pr-delivery.md` — issue-number branch, explicit staging, human commit identity, ready PR, and post-PR verification.
- `rules/kit-capabilities-usage.md` — read-only Kit command discovery guidance for downstream projects.
- `rules/llms-txt.md` — LLM-friendly `/llms.txt` requirements for web, website, API, and documentation surfaces.
- `rules/safety-guardrails.md` — always-on git and GitHub safety checks.
- `rules/work-lane-gating.md` — implementation-lane classification and PR workflow consent.
