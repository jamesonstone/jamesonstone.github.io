---
layout: post
title: "The Right Task"
date: 2026-11-24 09:30:00 -0500
---

A recent essay argues that superintelligence is arriving [1]. Its evidence is a proof: a machine-checked proof of the Riemann Hypothesis, built with an AI's help [2]. Grant the premise. What is left for the human?

Not checking the math. Software verified the proof, kernel by kernel. The question left for people was a different one: does the statement in the code actually say what the theorem says? Correctness was settled. Whether it was the right problem, stated rightly, was still open.

That distinction is worth holding onto. Correctness asks whether an answer is right given the task, whether the weights are aligned to the objective. Validity asks whether the task is the right task at all. A model can be flawlessly correct about the wrong question. As correctness gets cheap, the second question becomes most of the work.

There's a structural reason the second question stays with us, at least for now. A model learns by recording the structure in its data until it recognizes that structure as a language, as I argued in [The Structure Beneath Language](https://jamesonstone.io/blog/2026/11/06/the-structure-beneath-language.html). It recognizes best what appears most often. Post-training narrows things further: tuning on human preferences measurably reduces the variety of what models produce [3], partly because the people rating outputs favor the familiar [4]. My read is that the pipeline rewards the typical, on-task answer and quietly penalizes the non-linear one: the reframe, the jump across levels, the "this isn't the problem."

So the human role isn't to be a slower calculator, and it isn't taste. Taste is a preference about the output. This is a check on the task, and it's tactical. Does the task the model solved match the problem you actually have? What did the framing leave out? Which constraint, case, or consequence got dropped when the problem was written down? Should the objective change instead of the answer? Each of those questions has a concrete failure behind it. Asking them is non-linear by nature, as [The Shallow Expert](https://jamesonstone.io/blog/2026/10/12/the-shallow-expert.html) argued: you step outside the task to inspect the task.

The strongest objection is that checking the task is just another task, and it will be automated too. Models can already be prompted to reframe problems, sampled for divergence, and asked to critique their own objectives. That's true, and I don't think the line is permanent. But choosing the task means deciding what matters, and what matters is set by whoever lives with the consequences. A model can propose a better question. Someone still has to want the answer. That last step is my argument, not a finding.

If superintelligence is arriving, being right becomes abundant. Being right about the right thing doesn't. That scarcity is the job.

---

[1] Alexandr Wang, ["Superintelligence is Arriving"](https://x.com/alexandr_wang/status/2124636606959345776), X, Nov 22, 2026<br>
[2] Scientific American, ["The AI Riemann hypothesis proof is true, independent mathematicians confirm"](https://www.scientificamerican.com/article/the-ai-riemann-hypothesis-proof-is-almost-certainly-true-independent-mathematicians-attest/), Nov 2026<br>
[3] Kirk et al., ["Understanding the Effects of RLHF on LLM Generalisation and Diversity"](https://arxiv.org/abs/2310.06452), ICLR 2024<br>
[4] Zhang et al., ["Verbalized Sampling: How to Mitigate Mode Collapse and Unlock LLM Diversity"](https://arxiv.org/abs/2510.01171), 2025
