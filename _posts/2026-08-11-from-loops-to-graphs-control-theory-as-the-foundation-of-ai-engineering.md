---
layout: post
title: "From Loops to Graphs: Control Theory as the Foundation of AI Engineering"
date: 2026-08-11 10:00:00 -0400
---

There is a question floating around AI engineering that I think is more important than it sounds:

**Are we still writing loops, or have we switched to graphs yet?**

My thesis is that this transition is not really new.

It is the latest expression of an idea that control theory has been formalizing for more than a century.

A classical control system has a simple shape:

**observe → compare → act → measure → repeat**

You have a desired state. You observe the current state. You calculate some notion of error. You apply a bounded action intended to reduce that error. Then you observe the system again.

PID controllers are perhaps the canonical implementation of this idea. They continuously adjust behavior based on the difference between where the system is and where it should be.

Modern AI agents are increasingly doing the same thing.

The difference is that their state spaces are much stranger.

The error might not be:

`temperature = 71°F, target = 72°F`

It might be:

`17 pull requests remain, 4 are blocked by other PRs, 3 have failing CI, 2 require infrastructure changes, 1 has unresolved review feedback, and 7 can proceed independently.`

There is no useful scalar error term for that.

The state is a **graph**.

That changes the implementation, but not the fundamental control problem.

## The Loop Never Disappeared

The first generation of agents was usually implemented as an explicit loop:

```text
while goal_not_complete:
    observe()
    reason()
    act()
```

That works surprisingly well until the environment becomes complicated.

Real engineering work contains dependencies, branches, concurrency, failures, prerequisites, external systems, and partially satisfied goals.

At that point, the agent cannot simply ask:

> What should I do next?

It needs to understand:

> What is the current structure of the problem?

That structure is often a graph.

A pull request depends on another pull request.

A deployment depends on infrastructure.

A test depends on a service.

A remediation becomes unnecessary because another branch changed.

Several independent branches can proceed simultaneously.

The controller still runs a loop, but **each iteration updates and acts upon a graph-shaped estimate of reality**.

The loop becomes the runtime.

The graph becomes the state.

## PID Without the Scalar Error

This is where I think control theory becomes especially useful for thinking about AI systems.

The interesting lesson from PID is not that every AI agent needs proportional, integral, and derivative coefficients.

It is the architecture underneath them:

```text
reference state
      ↓
current state → error
      ↓
control policy
      ↓
bounded action
      ↓
environment
      ↓
observation
      ↺
```

Replace the numerical sensor with tools and language models.

Replace scalar error with typed discrepancies.

Replace the plant with GitHub, a codebase, CI, cloud infrastructure, browsers, APIs, or an operating system.

Replace the actuator with a coding agent.

The architecture remains recognizable.

For an AI engineering system, an error might be typed as:

```text
dependency_blocked
ci_failed
review_required
runtime_regression
deployment_pending
information_missing
human_authority_required
```

The control law no longer computes a voltage.

It computes the next **admissible action**.

## Why Graphs Matter

Graphs solve something that simple agent loops hide: **causality and concurrency**.

If ten tasks exist, a naive loop sees ten things to do.

A graph may reveal:

```text
A ─→ B ─→ D
     │
     └─→ E

C ─────────→ F

G
H
```

Now the controller knows that `A`, `C`, `G`, and `H` form an actionable frontier.

Four agents can work simultaneously.

`B` should not begin until `A` reaches the required state.

`D` and `E` become available later.

The graph therefore becomes more than a planning artifact. It becomes the **state estimator and scheduling substrate of the controller**.

And importantly, the graph cannot simply be generated once.

The world changes.

CI fails.

Humans push commits.

Deployments finish.

Agents discover hidden dependencies.

Production behaves differently than expected.

So the real system becomes:

```text
observe
   ↓
reconcile
   ↓
update graph
   ↓
classify error
   ↓
compute admissible frontier
   ↓
act in parallel
   ↓
measure
   ↺
```

We are still writing a loop.

We have just realized that the state inside the loop is a graph.

## The LLM Should Not Be the Controller

This framing also suggests something important about AI reliability.

An LLM does not need to *be* the control system.

It can be a sensor and an actuator inside one.

Language models are unusually good at interpreting ambiguous state:

- Does this PR semantically depend on another one?
- Why is this test failing?
- Does this review comment represent a real blocker?
- What change would likely resolve this runtime failure?

But deterministic software can still own:

- graph invariants;
- lifecycle transitions;
- dependency enforcement;
- scheduling;
- authorization;
- concurrency limits;
- validation;
- rollback policies;
- termination conditions.

That distinction matters.

Reliability does not have to come from making an agent perfectly intelligent.

It can come from placing an imperfect intelligent component inside a well-designed feedback controller.

## AI Engineering Is Control Engineering

I increasingly think this is one of the useful mental models for the next generation of AI systems.

Prompt engineering asks:

> What should the model say?

Agent engineering asks:

> What actions should the model take?

Control engineering asks the more important question:

> How does the system continuously drive an uncertain environment toward a desired state without losing stability?

Once agents operate for hours, modify real systems, spawn other agents, respond to failures, and pursue goals whose intermediate states cannot be known in advance, that becomes the problem.

The progression therefore looks something like:

```text
prompt
  ↓
agent
  ↓
loop
  ↓
feedback controller
  ↓
continuously updated graph
  ↓
parallel bounded actuation
```

Graphs do not replace loops.

They complete them.

And PID did not predict coding agents.

But the foundational idea behind PID and control theory, **observe the world, represent error, apply bounded corrective action, measure the result, and repeat**, may turn out to be one of the most useful foundations we have for engineering reliable AI systems.
