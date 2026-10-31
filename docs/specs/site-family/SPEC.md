---
workflow_version: 3
phase: complete
---
# Site family

## Purpose and context

Connect the public suite through restrained navigation and a directory on the personal homepage. Preserve the writing-first homepage and existing project content. Publication of the five prepared website content changes is approved. DNS and OpenVital source remain separate workstreams.

## Requirements and accepted plan

Add a compact homepage directory after latest posts, keep the machine index current, and link the existing marketing sites back to the personal directory and verified family destinations. Use public GitHub profiles when no useful marketing page exists. Identify OpenVital as the healthcare AI arm of Reasoning Machines, with its website at https://openvital.co/. Do not invent a domain or imply Medproof is launched. Preserve every existing dirty checkout. The initial local preview used fresh detached linked worktrees; publication adopts the issue branches in those same isolated worktrees.

## Decisions

Canonical destinations and activation dependencies live in docs/programs/site-family/PROGRAM.md. OpenVital registration is verified; activate its links only after the coordinator confirms the live endpoint. Limina’s former “hello, world” page is preserved in a minimal branded shell with family navigation, and the directory links to that page. Spectral7 has a verified public organization but no public repositories or verified website. Applied Symbolics links to its organization, with Ambient OS and OpenCarrier as distinct product sites. No new Applied Symbolics or Spectral7 marketing repository is created. The later publication grant permits one issue, GH branch, human-authored commit, ready PR, and merge/deployment per prepared repository. Preserve normal Pages, Mint, and project-updater effects.

## Validation and outcome

Local source changes are complete. Jekyll build and site invariant validation passed. All three existing Ruby test suites passed (26 tests, 108 assertions), and both source syntax checks passed. Document checks passed for all five sites. Browser review found no overflow at 320, 390, 768, or 1440 pixels, retained five latest posts and the original homepage title, and confirmed visible keyboard focus. Desktop/mobile section screenshots are saved in the task output. A visual refinement changed product-site family links to inherit the host ink color and added a Limina favicon. Reasoning Machines make check passed, including Kit. Personal kit check --project remains blocked by five pre-existing contract findings: the three managed contract blocks differ, and DESIGN.md / SECURITY.md are missing; the untouched fresh base clone reports the same failures. No unrelated Kit reconciliation was performed. Publication is pending endpoint readiness and current-head PR checks.

The local system Ruby points at missing Xcode SDK headers. A process-only RbConfig override selected the installed matching SDK headers for dependency compilation; dependencies stay in ignored vendor/bundle. No host configuration or tracked runtime dependency changed.

## Repository memory

This spec retains the navigation and publication boundaries; the program ledger retains cross-repository identities and dependencies.

## Organization descriptions

A later explicit request replaces the Limina Dev and Spectral7 placeholders with evidence-backed high-level summaries. Limina Dev covers warehouse and logistics software, including the owner-named mapr/sortr projects. Spectral7 spans applied AI, logistics, communications, and knowledge systems. Authorized repository inventory/README review supports these categories; no private implementation, customer, operational details, or other private project names are published. The personal homepage and machine index use the same positioning as Reasoning Machines.
