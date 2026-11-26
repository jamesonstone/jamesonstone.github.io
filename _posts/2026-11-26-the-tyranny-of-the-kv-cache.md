---
layout: post
title: "The Tyranny of the KV Cache"
date: 2026-11-26 18:30:00 -0500
---

"The tyranny of the KV cache" is Diogo Almeida's phrase. He is the CEO of TypeSafe, and his claim is that agents are inflexible in their design because of it [1][2]. I think he's right, and I think it's a memory problem.

The KV cache holds keys and values computed for earlier tokens, reusable only while everything before them stays the same. Change an early token and the work after it has to be redone, so the cheap move is to append. A cache doesn't carry from one model to another [1]. In Diogo's coding-agent simulation, output tokens were 9 to 18 percent of the bill; the rest was re-reading its history [1].

Append-only is a transcript, which is what agents have for memory. In his talk Diogo asks why that memory has to grow with everything that came before it [2]. My claim is that the price is why: it rewards keeping everything, the opposite of [withholding](/blog/2026/11/08/memory-systems-withholding.html). Serving only what the scene requires means editing and dropping, which the cache charges for.

The fix has to be the conduit: what goes into context, when, and how fresh it is. A tool the model must remember to call is too late: the context is already set before it reasons. Whether that takes a new kind of model, or can be done outside the model, is still open for me. Writing memory into the model has its own price ([The Price of Compiling](/blog/2026/11/25/memory-systems-the-price-of-compiling.html)). Short of training a model of my own, the conduit is the lever.

The strongest objection is that this is a price problem, and prices are falling. Context windows keep growing and prefix caching makes repeated tokens cheaper, so append-only transcripts are fine.

Cheaper changes the bill, not the shape. A cheaper prefix cache rewards leaving it unchanged, so the pull to append gets stronger. A window that can hold everything doesn't say what matters. My claim, not a finding: a cheaper cache makes the tyranny more comfortable, not smaller.

Appending is cheap. Remembering takes editing. Agents will keep building transcripts until memory is managed at the conduit, not inside the pile.

---

[1] Diogo Almeida, ["(KV) Cache Rules Everything Around Me"](https://www.completeskeptic.com/p/kv-cache-rules-everything-around), Sep 9, 2026<br>
[2] Diogo Almeida, ["I Love You So Jev Much"](https://ai.engineer/talks/Cyt3LU8TyNc-i-love-you-so-jevving-much), AI Engineer CODE 2026, Nov 11, 2026, the phrase about 16 minutes into the talk
