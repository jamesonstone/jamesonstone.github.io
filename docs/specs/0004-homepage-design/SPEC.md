---
kit_metadata_version: 1
artifact: spec
workflow_version: 3
phase: review
feature:
  id: "0004"
  slug: homepage-design
  dir: 0004-homepage-design
---

# Homepage design

## PURPOSE

Give the personal blog a more visual, modern, readable homepage while retaining its warm paper palette, green accents, writing-first identity, and static Jekyll architecture.

## CONTEXT

Tracking issue: GH-86. The initial review was local only. The user subsequently approved shipping the reviewed design through the normal PR and deployment workflow.

## REQUIREMENTS

Preserve the five newest posts, their chronological order, the rotating tagline and no-JavaScript fallback, archive and studio links, existing routes and published content. Show exactly “[reasoning machines]” as one unbroken primary navigation link. Modernize shared typography without widening article reading measures. Desktop and phone layouts must have visible keyboard focus and no horizontal overflow.

Do not add application infrastructure, marketing funnels, animation, theme controls, or unrelated content changes.

## ACCEPTED PLAN

Use a wider homepage shell with an editorial hero pairing the existing title and tagline with Jameson's own painting. Keep reading prominent through one featured latest essay and four quieter entries. Retain the dedicated studio directory and old home anchor through a clear linked closing panel. Pair modern sans-serif interface/headings with a readable serif text face; reserve monospace for code. Keep the existing light color scheme, readable fallbacks, and responsive layouts.

## DECISIONS

Use existing artwork rather than generic decoration: the painting connects the visual identity to the author's actual work and links to the existing gallery. A wider home shell supplies composition without increasing article line lengths. No dark theme currently exists; preserve the light palette in both system preferences. Serve a 1100px, 438KB derivative on the homepage rather than the 1.7MB full painting; preserve the original gallery asset. Use the post opening text when the automatic excerpt is shorter than 30 characters, avoiding a featured card containing only “tl;dr:”.

## DISCOVERIES

The local source checkout is older and contains unrelated edits; GH-86 starts at refreshed origin/main (bca812d), preserving merged PR85. No separate design skill is installed; use existing site principles and the Playwright skill for rendered inspection.

## VALIDATION

PASS: normal Jekyll build, site invariants, all 27 existing Ruby tests (181 assertions), JavaScript syntax, git diff whitespace checks, and Kit validation of all four feature specs.

Browser checks passed at 320, 390, 600, 768, 900, 1024, and 1440px: five posts, one-line bracketed navigation label, and no horizontal overflow. The six main destination pages and newest article were checked at phone/desktop widths, all local navigation/footer destinations returned 200, and article measure remains 680px on desktop. Keyboard checks confirm visible 2px focus outlines, working skip-to-content, and navigation to the studio directory. Light/dark system preferences preserve the existing light palette. No-JavaScript fallback and font-network failure remain readable. Screenshots were visually inspected at desktop, tablet, and phone sizes. All 28 rendered article bodies match freshly fetched main byte-for-byte.

Project-wide Kit validation remains blocked by five baseline findings: three outdated managed contract blocks plus missing DESIGN.md and SECURITY.md. An unmodified archive of bca812d reports the same five findings; no unrelated reconciliation is included. Existing RubyGems/Faraday notices are nonfatal. No separate CSS lint pipeline is configured.

Local review evidence is stored outside source at ../output/playwright/, including home-desktop.png, home-phone.png, article-desktop.png, article-phone.png, browser-qa.txt, and content-preservation.json. A single local review lane was used because the template, shared typography and visual verification are tightly coupled.

## OUTCOME

Implemented and validated on GH-86 from bca812d. The user reviewed the desktop and phone design and approved shipping it. Delivery proceeds through a ready PR, current-head checks, normal merge, automatic GitHub Pages deployment, and live verification. Existing dirty checkouts remain preserved. Tracking issue #86 is assigned to jamesonstone.

## REPOSITORY MEMORY

This spec preserves the design rationale and scope boundary; code owns layout details.
