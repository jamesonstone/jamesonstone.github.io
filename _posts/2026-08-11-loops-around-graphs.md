---
layout: post
title: "Loops Around Graphs: A Control-Theory Lens for AI Agents"
date: 2026-08-11 10:00:00 -0400
---

There is a question floating around AI engineering that I think is more important than it sounds:

**Are we still writing loops, or have we switched to graphs yet?**

That is the wrong choice. Reliable agents need both.

The loop is the runtime. A graph describes one important part of the system's changing state. Control theory offers a useful lens for connecting them, but it is not a complete foundation for AI engineering.

## Feedback Beyond a Scalar

A classical feedback system has a simple shape:

**observe → compare → act → measure → repeat**

PID is a familiar example, but the broader idea matters here: observe the environment, apply a bounded action, and measure what changed.

For an engineering agent, the discrepancy might look like this:

`17 pull requests remain, 4 are dependency-blocked, 3 have failing CI, 2 require infrastructure changes, 1 has unresolved review feedback, and 7 may proceed independently.`

That is not a useful scalar error. But it does not mean the entire state is a graph.

Runtime state also includes evidence, timestamps, permissions, resources, observations, and uncertainty. The graph captures relationships within it: dependencies, conflicts, and superseded work.

## What the Graph Contributes

Consider this dependency graph:

```text
A ─→ B ─→ D
     │
     └─→ E

C ─────────→ F

G
H
```

`A`, `C`, `G`, and `H` form a candidate frontier. `B` waits for `A`; `D` and `E` become available later.

Candidate matters. Missing dependency edges do not prove that tasks are safe to run together. They may still contend over files, infrastructure, or human attention. Safe parallelism also needs conflict information, isolation, idempotency, and bounded concurrency.

The graph therefore supports precedence and scheduling. It does not establish causality, and it is not the whole state estimator.

It also cannot be generated once and trusted forever. CI fails, humans push commits, deployments finish, and agents discover missing dependencies.

The runtime must keep reconciling:

```text
observe
   ↓
reconcile state and graph
   ↓
classify discrepancies and constraints
   ↓
compute an admissible frontier
   ↓
act within bounds
   ↓
validate
   ↺
```

## Where the Model Belongs

The language model does not need to be the control system.

- Tools and APIs expose observations and perform actions.
- The environment—GitHub, a codebase, CI, cloud infrastructure, or an operating system—is the plant.
- The model estimates ambiguous state, diagnoses failures, and proposes actions.
- A deterministic orchestrator enforces declared invariants around those proposals.

The model may infer a semantic dependency or diagnose a failure. It may also be wrong. Deterministic software can still own transitions, dependency enforcement, authorization, concurrency, budgets, retries, validation, and termination.

Not every observation is an error. `ci_failed` is a discrepancy, `deployment_pending` is lifecycle state, `human_authority_required` is a constraint, and `information_missing` is uncertainty. Each requires different transitions.

## What Stability Means

If control theory is going to be more than decoration, stability needs an operational meaning.

For an agent runtime, that might mean:

- safety invariants remain true;
- actions stay bounded by authority, cost, and blast radius;
- retries and state transitions do not oscillate forever;
- admissible work eventually makes progress; and
- delayed or stale observations force reconciliation before further action.

Control theory does not hand us that implementation. It gives us better questions about observability, delay, constraints, robustness, and convergence.

## Loops Around Graphs

Once agents operate for hours, modify real systems, spawn other agents, and respond to failures, prompt quality is no longer the whole engineering problem.

The reliable system is still a loop. Each pass observes the world, reconciles graph and non-graph state, computes what may safely proceed, acts, and validates the result.

Graphs do not replace loops. They make relational structure explicit inside them.

And control theory is not the whole foundation of AI engineering. It is a useful lens for building agent runtimes that remain observable, bounded, and recoverable as the world changes.
