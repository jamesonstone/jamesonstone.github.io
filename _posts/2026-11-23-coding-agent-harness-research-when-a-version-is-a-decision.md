---
layout: post
title: "Coding-Agent Harness Research II: When a Version Is a Decision"
date: 2026-11-23 13:00:00 -0500
---

Which version should a release workflow use when the tool changes faster than the harness that installs it? Kit's own release jobs still used Mint v0.5.0 when Mint reached v1.1.2. The opt-in deployment controller came from Mint v0.9.0, embedded in Kit. Finding those versions explained what Kit would run. Finding the reason for either choice took more work [1].

A pin can express a compatibility decision. It can also persist after the reason for it disappears. Those two cases look identical in a workflow file. Mint's v2 refactor makes the difference observable. The refactor keeps the release commands and removes the deployment controller. A job that computes a tag can follow the new release. A job that calls the controller still needs the implementation that provides it [2].

Kit's new release workflows ask GitHub for the latest stable Mint release at runtime and record the commit they use. Kit's own release workflow carries that commit from tagging through publication. A release arriving between those jobs leaves the run on the same implementation. For existing workflows, reconcile preserves the reference format when it refreshes a compatible release action. A job that still relies on the controller or passes an input the latest action lacks keeps its legacy Mint references together. The action steps in that job share a runtime binary. The v2 candidate, for example, keeps the `release-version-main` command and removes its `version-config` input. Explicit controller scaffolding uses the released renderer while Mint still provides it [1][2].

The objection is that automatic updates move risk forward. A published release can change behavior before a maintainer has reviewed it, and a later run can select a different commit. Recording the selection makes the result inspectable. It gives maintainers evidence for an investigation, while compatibility checks can only guard the interfaces they cover.

GitHub returned Mint v1.1.2 at the start of validation [3]. In scratch repositories, Kit generated a release starter and a two-environment controller that passed workflow lint. The actual Mint CLI resolved the next release and generated a changelog from synthetic GitHub and Linear ticket history. Mint published v1.1.3 during review [4]. The same Kit build selected it on the next run. The controller rendering and history checks passed again, and the history checks also passed with a local build of the v2 candidate [2]. Verification against a published v2 and a hosted publication run remains open.

---

[1] [Kit #310](https://github.com/jamesonstone/kit/pull/310), latest-release integration<br>
[2] [Mint #48](https://github.com/jamesonstone/mint/pull/48), v2 controller-removal candidate<br>
[3] [Mint v1.1.2](https://github.com/jamesonstone/mint/releases/tag/v1.1.2)<br>
[4] [Mint v1.1.3](https://github.com/jamesonstone/mint/releases/tag/v1.1.3)
