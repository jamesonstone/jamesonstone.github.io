---
layout: post
title: "Memory Systems XX: The Price of Compiling"
date: 2026-11-25 10:30:00 -0500
---

Compiling is a speed step. The loop of serving, proposing, reconciling and dreaming is where memory gets curated. Compiling takes what the loop has settled and writes it somewhere faster to answer from: model weights, a small adapter, a trained cache. As I said about [the process](/blog/2026/11/14/memory-systems-memory-is-a-process-not-a-taxonomy.html), the store is a cache. So what does it cost to fill one?

Two results from this week put numbers on it. Both are self-reported by the authors and a day old, so they show that a price exists, not what ours would be.

An adapter is a small add-on trained on a frozen model, and its rank is its size. Engram reports [1] that what an adapter can hold follows from its rank alone, and that they can predict the smallest adapter a dataset needs to within 5%. The finding that matters here: across the adapters they trained, a model that learned some number of bits lost about the same number, sometimes slightly more, of what it already knew. In their example, learning 10 KB might forget 12 KB. Their forgetting measure is how well the model still predicts text it used to produce itself, so it stands in for prior knowledge and is not a test of any skill.

The second result shows the damage in behavior. Fine-tuning an instruction-following model on new facts lowered its general scores by 35 points on average, and the drop tracked answers getting shorter: responses at least halved [2]. Their repair, InstructReplay, keeps the tuned model close to the original's answers on a fixed set of general instructions. The average decline fell from 28.1 points to 2.4, and the facts were learned just as well.

My read: every write into weights is a trade, and careful work makes it cheaper without making it free. That is [withholding](/blog/2026/11/08/memory-systems-withholding.html) one layer down. Serve admits only what the scene requires. Compile should write only what the loop has proven the scene keeps requiring.

The strongest objection is that InstructReplay nearly pays the bill, so this is engineering, not a reason to hold back. It shrinks the bill, and I'd use it. But replay protects what its reference set covers. The 2.4 is an average over five benchmarks someone chose, and what a memory loses is whatever nobody thought to list. The repair also adds machinery to every compile, for a cache. My claim is that cheaper is not free, and the cheapest write is the one not made.

Keep the text as the record. Compile only the small core the loop has proven, and expect to pay again each time that core changes.

---

[1] Engram, ["Predicting LoRA size for any dataset"](https://engram.com/blog/lora-size), Nov 24, 2026<br>
[2] Shi, Kou and Zhou, ["InstructReplay: Replaying Assistant Turns to Preserve General Behavior During Factual Fine-Tuning"](https://arxiv.org/abs/2611.32918), preprint, Nov 24, 2026

*[A philosophical exploration in memory systems](/blog/2026/11/08/memory-systems-introduction.html), part 20.* [Terms](/blog/2026/11/08/memory-systems-terms.html) · [Previous: Memory Is a Process, Not a Taxonomy](/blog/2026/11/14/memory-systems-memory-is-a-process-not-a-taxonomy.html) · [Next: No Surgical Fix](/blog/2026/11/27/memory-systems-no-surgical-fix.html)
