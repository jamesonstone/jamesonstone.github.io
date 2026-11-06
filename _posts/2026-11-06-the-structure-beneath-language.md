---
layout: post
title: "The Structure Beneath Language"
date: 2026-11-06 08:00:00 -0500
---

The success of language models invites a broader question: what is a model learning when it learns a language?

Words are the observable surface. Beneath them are relationships, constraints, and hierarchies. Syntax governs combination. Context shapes interpretation. Larger structures emerge from smaller units.

Language is a compressed record of how we organize experience.

For a long time, I treated language as something closer to English, Spanish, or C++: systems of symbols people use to communicate. But that definition obscures the more general idea. The world is full of structure that can be represented, learned, and interpreted, whether or not it was originally expressed in words.

A transaction table contains dependencies. A time series contains temporal relationships. A network contains patterns of interaction. Each may possess a statistical structure that can be learned and used for prediction.

Calling this the **language of the data** is a metaphor, but a useful one. It directs attention toward the relationships that make observations intelligible, rather than their particular format.

Some structures are deliberately designed. Programming languages have explicit grammars; databases have defined schemas. Other structures emerge from the processes generating observations: physical dynamics, biological mechanisms, and collective behavior. A dataset can contain both.

A model does not need those relationships to be articulated in advance. Given enough relevant examples and an appropriate training objective, it can learn predictive regularities from the data itself.

This is what makes the broader family of foundation models so interesting. TabPFN learns across many synthetic tabular tasks and applies what it learned to new datasets. Timestral learns patterns in time series and uses them to forecast unfamiliar sequences. Their utility does not depend on translating a table or a series into a Reddit post. It depends on learning structure that transfers.

We can also supply structure deliberately. A prompt defines a task, introduces context, and establishes rules for a particular interpretation. It generally guides an already-trained model rather than rewriting its parameters. The learned representation and the human-defined instruction are different mechanisms, but they can work together.

Pattern recognition is not new. The consequential development is our increasing ability to learn representations across many examples and apply them to problems the model was not individually built to solve.

There are limits. Some data contains little useful signal. Correlations can disappear when conditions change. Predictive accuracy does not establish causation, and a model may learn an artifact rather than a durable relationship.

Still, the implication is substantial: information does not need to pass through human language to become learnable.

Language is one expression of structured information. The broader opportunity is to learn that structure wherever it exists, and to define new structures that make it useful.
