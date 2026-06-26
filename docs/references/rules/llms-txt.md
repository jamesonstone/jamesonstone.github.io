---
kind: ruleset
slug: llms-txt
description: Keeps the root llms.txt machine index current with public site content.
status: active
applies_to:
  - website
  - content
  - posts
  - projects
  - llms
read_policy_default: conditional
---

# Ruleset: llms-txt

## Purpose

- Keep `/llms.txt` useful as the concise machine-readable entrypoint for the site.
- Prevent new public content from landing without the corresponding `llms.txt` update.
- Keep the file curated; it should guide readers and language models to source pages instead of duplicating full site content.

## Applies When

- Adding, removing, or renaming public pages.
- Adding a blog post that changes the latest-post set.
- Updating `projects.md` with a public GitHub project link.
- Changing the site feed, primary navigation, or public URL structure.

## Rules

- Update root `llms.txt` in the same change as the content or site-structure change.
- Keep the top-level shape compatible with the llms.txt convention:
  - one H1 site title
  - one blockquote summary
  - H2 sections containing Markdown links with short descriptions
- Use absolute `https://jamesonstone.github.io/...` URLs for site links.
- Include the primary public pages: Home, Blog, Paintings, Projects, About, and RSS.
- Include the latest five posts, matching the current post ordering used by the site.
- Include every current public GitHub project link listed in `projects.md`.
- Do not paste full post bodies into `llms.txt`; link to canonical pages instead.
- Keep descriptions short, factual, and specific to the linked page or project.

## Verification

Run these checks after any affected change:

```sh
bundle exec jekyll build
ruby scripts/validate_site.rb
```

The validator fails when `llms.txt` is missing, malformed, not copied to `_site/`, or missing required current links.
