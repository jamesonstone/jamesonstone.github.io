```text
     ██╗███████╗
     ██║██╔════╝
     ██║███████╗
██   ██║╚════██║
╚█████╔╝███████║
 ╚════╝ ╚══════╝
```

**Personal site of Jameson Stone**

✍️ Short posts, archive writing, paintings, and project notes.

## Local Preview

Install dependencies into the ignored local bundle path:

```sh
bundle config --local path vendor/bundle
bundle config --local force_ruby_platform true
bundle install
```

Run the site locally:

```sh
bundle exec jekyll serve
```

Build once for validation:

```sh
bundle exec jekyll build
```

Run the site invariant checks after a build:

```sh
ruby scripts/validate_site.rb
```

Generated output is written to `_site/` and should stay untracked.

## New Post Workflow

To start a post from a Codex thread, send `new_post` as its own line with one triple-quoted draft block:

````text
new_post
"""
Draft text goes here.
"""
````

Add `no review` to skip prose review and clarification questions. It does not skip metadata derivation, local validation, git safety checks, or PR delivery.

The full agent procedure lives in `.agents/skills/threaded-blog-post/SKILL.md`. By default, the agent runs one concise review pass before file creation. If the draft has no `# Heading`, the agent suggests a title during review; with `no review`, it picks a reasonable title from the draft.

Generated posts use this filename shape:

```text
YYYY-MM-DD-slug.md
```

Use this front matter:

```yaml
---
layout: post
title: "Post title"
date: YYYY-MM-DD HH:MM:SS -0400
---
```

Use the correct `America/New_York` UTC offset for the selected date. For same-day publication, use a time that has already occurred; GitHub Pages skips future-dated posts during normal builds.

Keep new posts short and direct. Add optional images under `assets/images/blog/` and reference them with site-root paths:

```md
![Alt text](/assets/images/blog/example.png)
```

If the draft references images or other assets, the agent pauses before PR creation to ask for asset source and alt text.

Update `/llms.txt` when a post changes the latest-post list, when public pages change, or when public GitHub projects are added. The maintenance rule lives in `docs/references/rules/llms-txt.md`.

Approved source changes are delivered through a ready pull request for review. Publishing happens only after manual merge through GitHub Pages, followed by Pages status and production URL verification. This feature does not add a custom Actions workflow or `CNAME`.

## Maintainer

❤️ Lovingly overthought by [Jameson Stone](https://github.com/jamesonstone)
🪖 Field notes at [jamesonstone.io](https://jamesonstone.io)
