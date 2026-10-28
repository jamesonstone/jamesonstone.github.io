---
workflow_version: 3
phase: complete
---
# Projects updater reconciliation

## Purpose and context

The updater fails when projects.md already lists a project omitted from llms.txt. Its persistent automation branch also predates current main. The user authorized a separate repair PR after this caused a red pipeline during Team Joiners publication.

## Requirements and accepted plan

- Backfill missing index entries from maintained project content even without newly discovered repositories; preserve existing descriptions and unrelated index sections.
- Preserve pending automation branch changes and merge the triggering main commit before generation. Fail safely on conflicts; never reset or force-push.
- Detect and commit both generated files; retain normal site validation.
- Run deterministic regression and site checks on pull requests without generating or publishing new public content.
- Preserve approved article text and existing published content. Deliver a ready PR; the user also authorized merge when its final checks pass and verification of the resulting updater run.

## Decisions

The maintained project list supplies missing index descriptions. GitHub eligibility filters still govern only newly discovered repositories. Existing links are never removed by reconciliation. The workflow uses a normal merge to retain pending automation work and consumes current main fixes.

## Validation and outcome

Implemented reconciliation from maintained project entries, normal branch merging, two-file detection/staging, and a read-only PR validation job. Local validation passed: 25 tests, 92 assertions; Ruby syntax; normal Jekyll build; site invariants; actionlint; diff whitespace checks.

An isolated clone rehearsal incorporated the real pending automation branch without conflicts, repaired the missing loopc and kura index entries, discovered current public projects, passed site validation, remained idempotent, and preserved the approved Team Joiners source byte-for-byte. Rehearsal output was not pushed or published.

Hosted final-head validation, merge, updater execution, and Pages deployment evidence are reported in the delivery record. No public content changes are included in this repair PR; generated content remains subject to its separate review PR.

## Repository memory

Created this spec to retain the non-destructive branch and reconciliation decisions. Updated docs/references/testing.md with the stable validation and rehearsal commands.
