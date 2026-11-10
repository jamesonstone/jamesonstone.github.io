---
layout: post
title: "Autonomy Needs Procedures"
date: 2026-11-10 12:00:00 -0500
---

The more work we delegate to coding agents, the more of our operating knowledge has to become explicit. An agent that writes a function needs conventions. An agent that carries a task from investigation to review also needs to understand how the work moves forward, what proves completion, and when to stop.

This exposes a distinction that gets lost when every instruction is called a rule.

A **rule** states a constraint: preserve public interfaces, keep secrets out of source control, verify changes before declaring them complete. A **ruleset** groups related rules into a coherent policy. Both describe conditions that should hold whenever they apply.

A **standard operating procedure**, or **SOP**, describes how to carry out a recurring task under those constraints. It has an activation condition, prerequisites, ordered steps, decision points, and an observable end state. Rules remain applicable throughout; the procedure advances as the state of the work changes.

Consider an agent maintaining an open-source image converter. Its ruleset requires compatible dependency licenses, passing regression tests, and human approval before release. Those requirements apply across many kinds of work.

Within an authorized maintenance task, a dependency-update SOP answers a narrower question: what should happen when a dependency advisory arrives?

1. Confirm that the affected dependency and version are actually used.
2. Read the advisory and identify the smallest fix compatible with the interface and licensing requirements.
3. Update the dependency in an isolated branch and run the relevant regression checks.
4. If checks fail, compatibility breaks, or the fix requires a larger migration, stop and report the blocker or decision needed.
5. Open a reviewable pull request with the change, test results, and remaining uncertainty. Release remains a separate approval.

The ruleset supplies the constraints. The SOP connects a particular event to a verifiable result. A failed check changes the next action; a list of requirements alone leaves that sequence to be reconstructed each time.

This distinction is informing [Kit](https://github.com/jamesonstone/kit), a tool that keeps coding-agent instructions, contextual rules, and project knowledge in the repository. SOPs deserve a distinct place in that context because they answer a different question from policy. The agent still executes the work. The document supplies neither an execution engine nor additional permission, and a checked box is not evidence that a test ran.

There is a reasonable objection: capable agents can derive procedures, and rigid recipes can preserve obsolete assumptions. The useful SOP therefore records the parts that matter: prerequisites, consequential ordering, decision boundaries, and evidence of completion. Incidental tool choices should remain adaptable. The procedure should keep earning its place as capabilities change.

More autonomy increases the cost of leaving this knowledge implicit. A reliable agent needs enough procedure to carry work forward, and enough judgment to recognize when that procedure no longer applies.
