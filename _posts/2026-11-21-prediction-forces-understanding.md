---
layout: post
title: "Prediction Forces Understanding"
date: 2026-11-21 15:00:00 -0500
---

A language model learns by being graded on every next word. Across enough text, the structure of the data gets recorded, and the model comes to recognize it as a language: grammar, facts, and patterns of reasoning, learned because predicting well depends on them [1].

Engineers rarely grade themselves that way. We ship a change, watch whether it works, and call that understanding. But "it worked" and "I knew it would work, and why" are different claims. Only the second is understanding.

So here's a working definition: you understand a system when you can predict what a change will do before you make it. Not just the intended effect, but what else moves: latency, the retry path, the consumer downstream, the dashboard someone else watches.

By that definition, a bug is a prediction failure. You believed the code would do one thing and it did another. An outage is a prediction failure at scale: a change whose consequences nobody anticipated, often in a part of the system nobody thought was involved. A hypothetical: a team raises a timeout to stop a burst of errors. The errors stop. Requests now hold connections six times longer, the pool drains, and the service upstream falls over. The fix was correct for the model the team had. The model was missing a queue.

The X/Y problem is the same failure one level up. You asked about Y because you predicted that solving Y would solve X. The prediction underneath the question was wrong.

It's also where adjacent problems come from [2]. My inference is that the adjacent problem is the one where your predictions already work, so progress feels real. The real problem is where your model fails, which is exactly where the understanding is missing.

Nobody predicts everything, and complex systems will surprise you. Understanding isn't omniscience. It's knowing which changes you can predict and which you can't, and shipping the second kind carefully.

If you can't say what a change will do, you don't understand the system yet. You're running the experiment that will teach you.

---

[1] [Expertise Is Learned Structure](https://jamesonstone.io/blog/2026/11/04/expertise-is-learned-structure.html)<br>
[2] [Jameson's Law of Adjacent Problems](https://jamesonstone.io/blog/2026/11/20/jamesons-law-of-adjacent-problems.html)
