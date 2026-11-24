---
layout: post
title: "Specificity Is the Solution"
date: 2026-11-24 09:40:00 -0500
---

Is generalization what a language model is, or what it was trained to do?

Mostly the second. Pretraining minimizes prediction error averaged across an enormous corpus, so every pattern earns weight in proportion to how often it appears. That's why a model's grasp of a fact tracks how many training documents mention it [1]. Generalization is what that objective rewards: whatever holds across the most examples. Preference tuning pushes the same way, improving how answers hold up on new inputs while narrowing their variety [2].

But the model isn't incapable of the specific. Learning theory suggests that on long-tailed data, memorizing rare cases is necessary to generalize well at all [3]. Models do store specifics. They weight them by frequency, and the specific that matters to you was probably seen rarely or never. Fine-tuning, retrieval, and a well-chosen example in the prompt can all make a model specific. So generalizing isn't an inherent role. It's the default the objective sets.

Here's the turn: most real problems are solved by the thing that doesn't generalize. Some hypotheticals: the one customer whose contract renews differently, the service that times itself against another service's events, the rule added after an incident nobody remembers. A general answer is right on average and wrong here. Specificity is the solution, and the general answer is often [the adjacent problem](https://jamesonstone.io/blog/2026/11/20/jamesons-law-of-adjacent-problems.html). Even the essay announcing that superintelligence is arriving names the remaining gaps as domain-specific know-how, plumbing, and experimentation, not intelligence [4].

So the human's task is to find the thinking that specifically does not generalize: to notice which detail is load-bearing, and which exception the median answer erases. That is non-linear because averaging can't reach it. You get there by knowing this system, this constraint, this consequence.

The strongest objection is that specificity can be supplied. Fine-tune the model, retrieve the document, put the case in context, and the model handles it. Yes, once someone knows which specific matters. My claim is that selecting it is the work. Retrieval returns what is similar. It doesn't know what is decisive.

Let the model generalize. The job is knowing where generalizing is wrong.

---

[1] Kandpal et al., ["Large Language Models Struggle to Learn Long-Tail Knowledge"](https://arxiv.org/abs/2211.08411), ICML 2023<br>
[2] Kirk et al., ["Understanding the Effects of RLHF on LLM Generalisation and Diversity"](https://arxiv.org/abs/2310.06452), ICLR 2024<br>
[3] Feldman, ["Does Learning Require Memorization? A Short Tale about a Long Tail"](https://arxiv.org/abs/1906.05271), STOC 2020<br>
[4] Alexandr Wang, ["Superintelligence is Arriving"](https://x.com/alexandr_wang/status/2124636606959345776), X, Nov 22, 2026
