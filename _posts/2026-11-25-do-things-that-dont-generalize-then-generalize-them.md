---
layout: post
title: "Do Things That Don't Generalize, and Then Generalize Them"
date: 2026-11-25 10:00:00 -0500
---

In [Specificity Is the Solution](https://jamesonstone.io/blog/2026/11/24/specificity-is-the-solution.html) I argued that the human job is finding the load-bearing thing that doesn't generalize. That's the first move. The second is extracting what transfers, turning the exception into a new general pattern [1].

Order matters. Generalize too early and you erase the exception, which is how you end up solving [the adjacent problem](https://jamesonstone.io/blog/2026/11/20/jamesons-law-of-adjacent-problems.html). Never generalize and the insight stays a one-off. The next person, or the next model, meets the same case and treats it as new.

A hypothetical: a service times itself against events from another service. The median fix is to note "timing dependency" and move on. Stay with the specific and you may find the events were standing in for an acknowledgment that was never built. The pattern that transfers isn't "watch for timing dependencies." It's "an implicit contract is often a missing one."

My claim is that this is also how new structure enters the data models learn from. A model records structure and recognizes it as a [language](https://jamesonstone.io/blog/2026/11/06/the-structure-beneath-language.html). A one-off in someone's head isn't in that data. A pattern written down as a rule, a test, or a described exception can be.

The strongest objection is that a model can do the second move too: hand it the exception and ask what generalizes. Often that's useful. My read is that it carries the same risk as generalizing early. The model proposes a pattern at the grain of the median answer and helps you write a rule that erases the exception. The work is staying with the specific until you know which pattern is really there.

And the loop doesn't close. Today's good abstraction becomes tomorrow's median, and it will miss the next exception.

Do the thing that doesn't generalize. Then, and only then, generalize it.

---

[1] The title riffs on Paul Graham, ["Do Things that Don't Scale"](https://www.paulgraham.com/ds.html), 2013
