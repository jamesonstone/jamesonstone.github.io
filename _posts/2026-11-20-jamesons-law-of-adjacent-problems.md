---
layout: post
title: "Jameson's Law of Adjacent Problems"
date: 2026-11-20 13:00:00 -0500
---

When a problem is hard, we rarely refuse it outright. We solve the problem next to it, the one we already know how to solve, and call that progress.

Sometimes the detour is honest. Solving the familiar version can lay track toward the real one: you learn the domain, find the edges, and build a tool you'll need anyway.

More often it's a refusal to see the scope of the real problem. Worse, the adjacent solution can work against the true one. It hardens assumptions, absorbs the budget and the attention, and gives everyone a reason to stop asking. You defeat your own goal in the name of being productive.

The first half isn't new. In 1974 Mitroff and Featheringham named the "error of the third kind": solving the wrong problem when you should have solved the right one [1]. Kahneman and Frederick found that people facing a hard question often answer an easier one without noticing the swap [2]. Kaplan's drunkard looks for his key under the street lamp because the light is better there, and his law of the instrument lets the tool pick the problem [3]. The XY problem is the same move inside a help request [4]. My addition is the motive, and it's an inference: the adjacent problem isn't chosen because the right one is invisible. It's chosen because it feels like work you can finish.

The second half matters more now. Implementation is commoditized [5], so the adjacent solution is cheap to build, and its most dangerous form is a replacement. Someone looks at an existing system, doesn't take in its complexity, and builds a new one that handles what they understood.

Here's a hypothetical. A team replaces an aging order service with a clean new one in a week. The old service retried in a particular order, and it emitted events that a downstream consumer timed itself against. It kept an unwritten contract with a partner integration through every version of that API. It also carried a dozen edge-case rules added after incidents nobody remembers. The new service handles the happy path beautifully, and its author believes it handles everything.

Chesterton's fence says don't take a fence down until you know why it was put up [6]. Hyrum's Law explains why that's hard: with enough users, every observable behavior is depended on by somebody [7]. An old system that's still running has survived things its replacement hasn't met yet.

The new part is the confidence. Cheap artifacts make an incomplete replacement look finished.

in summary:

> **Jameson's Law of Adjacent Problems, Expanded Formula:** Faced with a complex problem, people tend to solve an adjacent problem they already understand and count it as progress. When implementation is cheap, the adjacent solution often becomes a replacement for an existing system, built without understanding what that system handled and believed by its author to be complete.

> **Jameson's Law of Adjacent Problems:** The harder the real problem, the more likely we are to solve the one next to it and call it done.

> **Corollary:** Before you replace a system, list what it handles that you didn't build.

---

[1] Ian Mitroff and Tom Featheringham, "On Systemic Problem Solving and the Error of the Third Kind," *Behavioral Science*, 1974.<br>
[2] Daniel Kahneman and Shane Frederick, "Representativeness Revisited: Attribute Substitution in Intuitive Judgment," 2002.<br>
[3] Abraham Kaplan, *The Conduct of Inquiry*, 1964.<br>
[4] [The XY Problem](https://xyproblem.info/)<br>
[5] [Implementation Is Commoditized](https://jamesonstone.io/blog/2026/10/06/implementation-is-commoditized.html)<br>
[6] [Chesterton's fence](https://www.chesterton.org/taking-a-fence-down/)<br>
[7] [Hyrum's Law](https://www.hyrumslaw.com/)
