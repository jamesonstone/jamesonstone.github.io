---
layout: post
title: "Context Above the Assistant"
date: 2026-11-20 12:00:00 -0500
---

I have four assistants, and none of them knows what the others know.

Every morning several of them ping me about the same tasks. This week Muse asked me to check on the Thanksgiving turkey. Earlier in the week, Grok Bot had already called and confirmed it was ready for pickup Monday. Neither assistant was wrong. The confirmation lived in one context and the reminder in another, and nothing connected them.

That's the real cost of the assistant boom. Every assistant is its own isolated context system, with its own memory, its own access and its own picture of my life. Adding another one doesn't add coverage. It adds another partial view that acts on what it can see.

The fix is layers of context, with each layer shared by everything that works at that level.

Layer 1 is context inside a repository. It's the specs, code and pull requests that come straight out of implementation work. A monorepo with a docs directory can carry an end-to-end feature for one product.

Layer 2 is context across agents, services and products. It's the task list that records what's being done, by whom, and whether it's finished. Layer 2 lives outside any one repo or assistant, and every one of them can read and write it.

Layer 3, if it's needed, holds initiatives and products.

The hierarchy isn't new. Linear separates [issues, projects and initiatives](https://linear.app/docs/conceptual-model). SAFe stacks [stories, features and epics](https://framework.scaledagile.com/story). Simon Brown's [C4 model](https://c4model.com/) zooms from code out to system context. What's new is who has to read it. People held the levels in their heads and reconciled them in standups. Assistants can't, because each one only sees the layer its own access exposes.

Smarter assistants won't fix that, because the problem isn't intelligence. It's that each one holds a different slice of the same work. One shared layer above all of them would have let Muse see the turkey was handled, and I'd have gotten one fewer ping.

Each assistant needs one rule: check the shared item before you ping, and update it when you act.

More assistants means more context systems. Without a shared layer, each one is another way to be wrong about the same task.
