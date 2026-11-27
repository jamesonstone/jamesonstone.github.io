---
layout: post
title: "Memory Systems XXI: No Surgical Fix"
date: 2026-11-27 16:15:00 -0500
---

In [The Price of Compiling](/blog/2026/11/25/memory-systems-the-price-of-compiling.html) I looked at what a write into weights costs the model. Here is the other half: what it costs to change a memory once it has been baked in.

A recent approach, MeMo, turns a document set into memory by generating question-and-answer pairs and fine-tuning a smaller model on the answers [1]. The main model stays frozen. The memory lives in the smaller model's weights. A fact is a pattern spread across those weights, not an item you can point at.

That is the problem. There is no surgical fix: no single set of weights that is a fact update. You cannot add one document, correct one fact, or delete one. You either retrain on everything, about 150 to 240 GPU-hours to generate the pairs and 90 to 180 more to train a 14-billion-parameter memory model [1], or train on the new documents and merge, which cost them 11 to 19 points of accuracy [1]. A full retrain keeps the score. The choice is a full rebuild or an accuracy swing. My claim is that, at that scale, it cannot be done on consumer hardware under a realistic time constraint.

Querying has a cost of its own when the fact is not obvious or not clearly held. Their protocol allows up to 16 calls between the two models [1]. The paper never measures that cost, so it is an open risk, not a proven expense. And the training is lossy by constraint: the memory only covers questions somebody thought to ask.

A hypothetical: a date in a contract changes. The natural move is to patch that fact. In a weight-baked memory there is no such patch. The whole store has to be rebuilt, or merged at a jagged cost.

The strongest objection is that knowledge editing already offers a surgical fact update. Methods such as ROME and MEMIT change a stated association by writing into a few weights, without a full retrain [2][3]. If that worked cleanly, the rebuild would be unnecessary.

Those methods can change a stated fact, but not as a cheap, clean update you can keep making. ROME's authors present it as a tool for understanding how facts are stored, not as a practical method for large-scale training, and note that after a successful edit the model will guess plausible new facts with no basis in evidence [2]. Applied in sequence, the model becomes less editable, forgets earlier edits, and loses other skills, first gradually and then all at once [3]. That is not a surgical fix. Merging, MeMo's measured alternative to a full rebuild, already shows the accuracy swing.

My claim is that a memory you have to live with has to change as text. Weights can cache what the loop has already settled. They are not a place to correct a fact.

---

[1] Quek et al., ["MeMo: Memory as a Model"](https://arxiv.org/abs/2605.15156), preprint, May 14, 2026<br>
[2] Meng, Bau, Andonian and Belinkov, ["Locating and Editing Factual Associations in GPT"](https://arxiv.org/abs/2202.05262), 2022<br>
[3] Gupta, Rao and Anumanchipalli, ["Model Editing at Scale leads to Gradual and Catastrophic Forgetting"](https://arxiv.org/abs/2401.07453), Findings of ACL 2024

*[A philosophical exploration in memory systems](/blog/2026/11/08/memory-systems-introduction.html), part 21.* [Terms](/blog/2026/11/08/memory-systems-terms.html) · [Previous: The Price of Compiling](/blog/2026/11/25/memory-systems-the-price-of-compiling.html)
