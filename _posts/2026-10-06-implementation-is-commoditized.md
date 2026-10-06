---
layout: post
title: "Implementation is Commoditized"
date: 2026-10-06 08:00:00 -0400
---

Implementation is commoditized.

Coding agents are now good enough to take a well-described problem and turn it into working software on their own. Not always elegantly. Not always efficiently. But reliably enough that writing code is no longer the scarce part of building software.

That changes more than it seems.

## The layer between

For most of the history of software, code sat between the product manager and the engineer as a layer of abstraction. The PM described what the business needed. The engineer translated it into code. Because that translation was hard, slow, and expensive, it became a moat.

But code was always a subset of something larger: the domain. Every line encoded a decision about how some messy, real-world system actually behaves. The billing edge case. The regulatory carve-out. The instrument that fails in a way nobody documented. The code was just the most legible artifact of that understanding.

Because the translation was so expensive, it was easy to mistake the layer for the value. Engineers became "the people who write code," and the domain complexity they absorbed along the way was treated as a side effect.

## The layer is gone

Now a PM can describe a feature to an agent and get working code back. The translation layer has collapsed, and with it the moat built on the scarcity of people who could turn intent into software.

What remains is everything the code was abstracting.

An agent will implement what you ask for. It is much worse at knowing what you should have asked for. It doesn't know that the "simple" status field is load-bearing for three downstream teams, or that the obvious refactor breaks a contract nobody wrote down. Those aren't implementation problems. They're domain problems, and they don't disappear because the typing got cheaper.

## What engineers are paid for

Engineers are, as they have always been, paid to own domain complexity.

Not typing. Not syntax. The judgment about what the system should do, where it will break, and which tradeoffs are worth making.

Subtlety, nuance, and non-linear thinking still live outside the explicit goals of how language models are trained and reinforced. In most cases they're actively discouraged by the training set, which rewards the confident, the common, and the directly on-task answer. The model converges on the median. The domain lives in the exceptions.

The code was never the moat. The understanding was. It still is.
