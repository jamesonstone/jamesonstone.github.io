# Threaded Blog Post

Use this skill when a user thread asks for a new blog post with the exact `new_post` trigger. This skill turns an approved thread draft into one Jekyll post source file and a ready pull request while preserving the repository safety rules.

## Trigger

- Start this workflow only when the user request contains a line whose entire trimmed content is exactly `new_post`.
- The request must contain exactly one triple-quoted draft block. Treat `"""` and `'''` as valid block delimiters only when they form one complete block.
- The user may include `no review` outside the draft block to skip prose critique.
- Do not start from broad keyword matches, partial words, comments inside files, or ordinary discussion that merely mentions posting.

Stop before file creation when the request has no draft block, multiple draft blocks, or unclear `new_post` intent.

## Review Mode

- Default mode is review enabled.
- Run one concise review pass before creating files.
- Ask at most 5 clarifying questions, focused on title, date, factual ambiguity, publication intent, and assets.
- If the draft has no Markdown `# Heading`, suggest a title during review and use the accepted title for the slug.

When `no review` is supplied:

- Skip editorial critique and clarification questions about prose quality.
- Still derive metadata, check for assets, run validation, follow git and GitHub safety rules, and deliver through a pull request.
- If no `# Heading` is present, pick a reasonable title from the draft content and slugify it without an extra title-confirmation round.

## Post Source

- Create exactly one post at `_posts/YYYY-MM-DD-slug.md`.
- Use the current date in `America/New_York` for the filename and front matter unless the user supplied a valid explicit date.
- If the supplied date is ambiguous or appears accidental, stop and ask.
- Derive the title from the first Markdown `# Heading` when present.
- Remove the title heading from the body only when doing so matches the existing post style; otherwise keep the body readable and concise.
- Required front matter is:

```yaml
---
layout: post
title: "Post title"
date: YYYY-MM-DD 12:00:00 -0400
---
```

- Use the correct `America/New_York` UTC offset for the selected date.
- Add `excerpt` or `tags` only when the user supplied them or they are clearly useful for the post.
- Do not add provenance or review-status front matter.
- Preserve the existing permalink contract: `/blog/YYYY/MM/DD/slug.html`.

Before writing files, check for collisions:

- `_posts/YYYY-MM-DD-slug.md`
- `_site/blog/YYYY/MM/DD/slug.html` when `_site/` exists
- existing source links to the same expected post URL

Stop and ask for a title or slug adjustment when there is a collision.

## Assets

- If the draft references an image, attachment, screenshot, media file, diagram, or other asset, stop before PR creation.
- Ask for the asset source and alt text.
- Do not generate, search for, download, or add remote images without explicit user approval.
- Approved blog assets belong under `assets/images/blog/`.
- Reference approved assets with site-root paths, for example `/assets/images/blog/example.png`.

## Validation

Run the local checks that prove the generated post fits the current source-first Jekyll site:

```sh
ruby -c scripts/validate_site.rb
bundle exec jekyll build
ruby scripts/validate_site.rb
```

Keep `_site/` untracked. If any command fails, report the exact failure and stop instead of weakening validation.

## Delivery

- Before source edits for a generated post, follow `docs/references/rules/safety-guardrails.md` and `docs/references/rules/work-lane-gating.md`.
- When the user wants PR delivery, follow `docs/references/rules/github-pr-delivery.md`.
- Use an issue-number branch in exact `GH-123` form.
- Create a ready PR unless the user explicitly asks for draft.
- Assign the PR to `jamesonstone`.
- Preserve `.github/pull_request_template.md` headings.
- Ask the user to review the PR and handle the manual merge. Do not merge it.

## After Manual Merge

After the user confirms the PR was manually merged:

1. Check GitHub Pages status with `gh api repos/jamesonstone/jamesonstone.github.io/pages`.
2. Verify the production URL for the post, using `https://jamesonstone.github.io/blog/YYYY/MM/DD/slug.html`.
3. Report the observed Pages status and URL result.

Do not change repository settings or add a custom GitHub Actions workflow for this verification.
