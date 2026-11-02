---
kit_metadata_version: 1
artifact: spec
workflow_version: 3
phase: review
feature:
  id: "0003"
  slug: reasoning-machines-machine-content
  dir: 0003-reasoning-machines-machine-content
---
# Reasoning Machines and machine-readable content

## PURPOSE
Give the studio directory a dedicated home and expose the site's public writing as clean Markdown.

## CONTEXT
The site uses standard GitHub Pages Jekyll, without custom plugins. The existing homepage directory, project updater, public post sources, and llms.txt are maintained surfaces. The supplied About screenshot confirms the existing restrained typography and shared footer.

## REQUIREMENTS
Move the directory to /reasoning-machines/ with primary navigation. Preserve suite descriptions, project links, typography, and the #site-family entrypoint. Add footer links to /llms.txt and /full-llms.txt. Serve matching /llms-full.txt as the conventional full-content name. Exclude drafts, future posts, repository docs, notes, and secrets. Preserve existing posts. Deliver a ready PR; merge and deployment are outside this request.

## ACCEPTED PLAN
Use static Jekyll Liquid templates to generate both full-content endpoints from one shared include on every normal build. Select informational pages by explicit source allowlist and posts from Jekyll's public site.posts collection, with additional published/date guards. Keep llms.txt curated. Add regression coverage, normal build checks, responsive browser checks, and hosted PR validation.

## DECISIONS
The current https://llmstxt.org/ proposal (v2, modified August 10, 2026) defines a Markdown index and recommends Markdown page alternatives. /llms-full.txt is a companion convention, not a second formal standard. Serve the requested /full-llms.txt alias from the same include. Link the full Markdown file from the curated index; individual Markdown page alternatives are unnecessary for this small site. Native GitHub Pages serves .txt as text/plain; no custom hosting changes are required. Use https://jamesonstone.io as canonical origin, matching CNAME. Use Jekyll-rendered post body content, produced in each post’s own page context, and convert body links, images, headings, and code blocks to Markdown without navigation/layout chrome. Do not re-render post source from the endpoint context. Allowlisted informational pages use their maintained static source bodies.

## DISCOVERIES
Kit reports pre-existing managed guidance drift; do not fold unrelated reconciliation into this feature.

## VALIDATION
PASS: normal Jekyll build, site invariants, updater and workflow regressions, validator regressions, endpoint integration (27 tests / 181 assertions total), Ruby syntax, actionlint, git diff --check, and feature Kit validation. The endpoint integration also builds in safe mode with preview flags to verify that private docs, unlisted pages, drafts, unpublished posts, and future posts cannot enter the full content. Both aliases match exactly. Local endpoint returns 200 and text/plain; existing production llms.txt confirms GitHub Pages text/plain; new production endpoints await merge/deployment.

Browser review at 320, 390, 768, and 1440 pixels confirmed visible navigation/footer links and no page overflow. Keyboard focus has a visible 2px outline. Visual QA caught and corrected Markdown indentation before delivery; the regression now checks rendered directory links and absence of an accidental code block. The supplied screenshot and final desktop/mobile previews were inspected.

Project-wide Kit validation remains BLOCKED by five unchanged baseline findings: three outdated managed contract blocks and missing DESIGN.md/SECURITY.md. An archive of the freshly fetched origin/main reports the same five findings. No unrelated reconciliation is included. Locked dependencies installed in ignored vendor/bundle using a process-only Ruby SDK path override for this host; no host configuration or tracked dependencies changed.

## OUTCOME
Implemented the dedicated directory and build-generated Markdown endpoints. Ready-PR delivery is in progress; no merge or deployment is authorized.

## REPOSITORY MEMORY
This spec records endpoint/publication boundaries. Update the existing site-family spec and testing reference to reflect the new directory and endpoint checks.

## PR review follow-up
CodeRabbit completed its initial review on 2026-11-02. Verified and fixed its two inline findings: posts now use their already-rendered body so page metadata and relative includes resolve in the original post context; painting images retain their artwork URLs and alt text as Markdown. Also addressed the test nit by checking generated markup outside fenced code, with regression fixtures containing HTML tags, layout/permalink strings, and Liquid syntax inside preserved code. The endpoint integration now has 73 assertions, including original post context, nested relative includes, artwork links, normal/preview publication boundaries, and alias equality. No navigation or visual changes were made in this follow-up.

The incremental review confirmed both inline findings addressed and identified one additional test nit: inline triple backticks could end the cleanup regex early. Reproduced that false failure with a `printf` example, anchored closing fences to their own line, and retained the example as a regression. This follow-up changes only test robustness and feature memory.
