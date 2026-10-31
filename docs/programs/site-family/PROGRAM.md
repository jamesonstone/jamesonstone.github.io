# Site family program

Coordinator: jamesonstone/jamesonstone.github.io. Publication of the five prepared content changes is approved. DNS and OpenVital source are separate workstreams. Merge only after the coordinator confirms Reasoning Machines and OpenVital endpoint readiness and the current PR checks/reviews satisfy repository policy.

| Workstream | Repository | Issue / branch | Canonical destination | State |
| --- | --- | --- | --- | --- |
| Personal hub | jamesonstone/jamesonstone.github.io | #75 / GH-75 | https://jamesonstone.io/ | PR open |
| Reasoning Machines | reasoningmachines/website | #2 / GH-2 | https://reasoningmachines.co/ | PR open; endpoint readiness pending |
| Ambient OS | appliedsymbolics/ambientos.dev | #5 / GH-5 | https://ambientos.dev/ | PR open |
| OpenCarrier | appliedsymbolics/opencarrier.dev | #5 / GH-5 | https://opencarrier.dev/ | PR open |
| Limina Dev | limina-dev/limina-dev.github.io | #1 / GH-1 | https://limina-dev.github.io/ | PR open |
| OpenVital | reasoningmachines/openvital-site | Separate workstream | https://openvital.co/ | Registration confirmed; live endpoint pending |
| Applied Symbolics | Public organization profile | No new marketing repository | https://github.com/appliedsymbolics | Verified public identity |
| Spectral7 | Public organization profile | No new marketing repository | https://github.com/spectral7-ltd | Verified profile; no public marketing site found |
| Scout | Existing personal project | Unchanged | https://scout.jamesonstone.io/ | Homepage directory link |
| Narrowband | Existing personal project | Unchanged | https://narrowband.jamesonstone.io/ | Homepage directory link |

The source-first homepage retains its writing and project content. Medproof is a product in development, not a launched service. The suite pages need no unpublished implementation, customer, or clinical details.

## Activation and publication behavior

Ready frontier: scoped PR creation and current-head checks. Activation frontier: coordinator-supplied endpoint readiness for Reasoning Machines and OpenVital, then permitted merges and deployed-content verification. The publication grant covers these five repositories only and preserves existing workflows, permissions, and infrastructure. No approval is submitted on the human’s behalf.

Personal, Ambient OS, OpenCarrier, and Limina use legacy GitHub Pages main/root builds. Personal also runs the existing project-updater workflow on main and validates Ruby/Jekyll on PRs. Reasoning Machines uses pages.yml to build and publish four public dist assets on main; its separate mint-release.yaml may publish version tags and GitHub Releases. The other four public trees contain no Mint workflow. No workflow changes are part of this program.

## Validation

Fresh remote main bases matched the prepared source bases before branch creation. Existing user checkouts were preserved. Local Jekyll/site checks and all three Ruby suites passed; Reasoning Machines build/source/Kit checks passed. Personal Kit contract validation has five baseline failures reproduced in the untouched base clone, unrelated to the content edits. Revalidate the final link heads and record hosted/production evidence separately from local results.

## Review frontier

- [jamesonstone/jamesonstone.github.io PR #76](https://github.com/jamesonstone/jamesonstone.github.io/pull/76) — branch GH-75; merge held for endpoint readiness.
- [reasoningmachines/website PR #3](https://github.com/reasoningmachines/website/pull/3) — branch GH-2; merge held for endpoint readiness.
- [appliedsymbolics/ambientos.dev PR #6](https://github.com/appliedsymbolics/ambientos.dev/pull/6) — branch GH-5; merge held for endpoint readiness.
- [appliedsymbolics/opencarrier.dev PR #6](https://github.com/appliedsymbolics/opencarrier.dev/pull/6) — branch GH-5; merge held for endpoint readiness.
- [limina-dev/limina-dev.github.io PR #2](https://github.com/limina-dev/limina-dev.github.io/pull/2) — branch GH-1; merge held for endpoint readiness.

The personal validation workflow and Reasoning Machines static-site checks passed on the initial PR heads. Automated review was still running on the personal and three other static-site PRs at this checkpoint. Passing local results do not substitute for pending hosted review or endpoint readiness. No merge or deployment of these five changes has occurred.
