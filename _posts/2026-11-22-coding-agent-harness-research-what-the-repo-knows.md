---
layout: post
title: "Coding-Agent Harness Research I: What the Repo Knows"
date: 2026-11-22 07:30:00 -0500
---

The model eats everything. A harness should get smaller as the model gets better. The test is to ask what the model would still have to guess if the instruction disappeared. A model can figure out how to edit a file. It needs evidence to know which settings the repo overrides, where its issues belong, and which version of the diff someone reviewed.

Looking at OpenCode and the Harness Leaderboard gave me a way into that question. A leaderboard compares systems as they were run. To know whether a particular prompt, tool, or context policy helped, I'd have to vary it while holding the rest steady. This round changed two parts of Kit that I could inspect directly [1].

First, Kit gives global and repo settings the same shape. Global preferences use the standard XDG config location and can still be read from older paths. The repo's `.kit.yaml` wins over global defaults, and issue routing belongs to the repo. I also shortened `kit guide`, which now uses the CLI's own help to tell an agent when to use a command. Every second copy of a command description is another place for it to go stale [2].

Second, every PR still starts with a fresh independent review. The PR now records the commit or diff, the scope, and the outcome. When later edits change behavior, permissions, acceptance criteria, or what a test considers a pass, an independent reviewer reads the affected delta. A typo gets a lead diff check. The unit of review is the change that could invalidate a conclusion [3].

This round supplied its own example. A follow-up reviewer found that a valid YAML key with a binary tag could decode to `issues` after Kit had already filtered the global keys. In a repo with no issue settings, the wrong tracker could be selected. Kit now normalizes the keys before filtering and tests that loading and scaffold generation agree [4].

That is one caught bug. The cost of asking for a focused second opinion on every substantive delta is still an open question. I'd run the same coding tasks several times with the same model under current Kit, a trimmed Kit, and a bare agent. Score correctness and delivery first, then count time, tool calls, cost, and human interventions. If an instruction survives that comparison, keep it until the next model gives you a reason to try removing it again.

This is the first *Coding-Agent Harness Research* note. The series will pair changes to Kit with the question that prompted them and the evidence available when they shipped.

---

[1] [OpenCode source](https://github.com/anomalyco/opencode) and the [Harness Leaderboard](https://huggingface.co/spaces/joelniklaus/harness-leaderboard)<br>
[2] [Kit #304](https://github.com/jamesonstone/kit/pull/304), config provenance and agent guide<br>
[3] [Kit #306](https://github.com/jamesonstone/kit/pull/306), follow-up review coverage<br>
[4] [Tagged YAML key fix and regression](https://github.com/jamesonstone/kit/commit/4b542a404e6e4231ae67499c1ccf726fd1524410)
