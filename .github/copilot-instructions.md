# GitHub Copilot Repository Instructions

## Native Planning

Use native planning for research and design. Before implementation, inspect code and repository documentation, then decide whether the work contains material rationale. When it does, create or adopt `docs/specs/<feature>/SPEC.md` before any implementation-file edits and record the accepted plan there before implementation begins. After validation, curate durable decisions into the correct repository document; code-and-test-sufficient work may report that no documentation update was required.

Start with `docs/agents/README.md`. Follow `docs/agents/GUARDRAILS.md` before git, GitHub, or AWS mutations, and load the applicable rules under `docs/references/rules/*` before GitHub delivery mutations.


Before implementation or validation, load `docs/references/rules/testing-and-environment-validation.md` and the project's `docs/references/testing.md`. Preserve language-native code-level tests and pull-request checks; end-to-end and live-integration suites supplement rather than replace them.
## Final Response

Every implementation final response must include:

- Repository Memory
- Decision: created | updated | refactored | deleted | not required
- Rationale: why this persistence decision is correct
- Artifacts: paths or none
