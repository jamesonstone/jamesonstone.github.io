# jamesonstone.github.io

Source-first Jekyll blog for short posts, archive writing, paintings, and project notes.

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

Create posts under `_posts/` using this filename shape:

```text
YYYY-MM-DD-slug.md
```

Use this front matter:

```yaml
---
layout: post
title: "Post title"
date: YYYY-MM-DD 12:00:00 -0500
---
```

Keep new posts short and direct. Add optional images under `assets/images/blog/` and reference them with site-root paths:

```md
![Alt text](/assets/images/blog/example.png)
```

Approved source changes publish through GitHub Pages from the configured branch. This feature does not add a custom Actions workflow or `CNAME`.
