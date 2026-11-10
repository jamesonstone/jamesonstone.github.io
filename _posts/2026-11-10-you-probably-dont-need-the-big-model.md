---
layout: post
title: "You probably don't need the big model"
date: 2026-11-10 08:00:00 -0500
---

Most software work isn't hard in the way frontier models are built for. It's CRUD and integration work: modeling data, building services around it, connecting systems that weren't designed to talk to each other, and handling the edge cases at those boundaries. That work is real, but it's well-trodden, and it makes up about 95% of the job.

New model releases are step functions. They're real leaps on problems you probably don't have, like long-horizon reasoning, novel math and huge codebases in one context. Opus 5.5 and GPT-6.1 and 6.2 already sit on the Pareto frontier for cost per task. Anything newer costs more, runs slower and has tighter limits, and you'll rarely use what it adds.

When a model falls short, the gap is usually in the context, not the model. Give it the right files, a clear spec and your conventions, and a mid-tier model does the job.

So start with the cheapest model that works, fix the context before you reach for more intelligence, and step up only when it still fails. Most weeks, it won't.

The question isn't "what's the smartest model?" It's "what's the least intelligence this task needs?"

I reach for the workhorse drill every day. The specialty bit only comes out a few times a year, and I'm grateful every time it does.
