---
kit_metadata_version: 1
artifact: "spec"
workflow_version: 3
phase: "review"
feature:
  id: "0005"
  slug: "link-previews"
  dir: "0005-link-previews"
---
# Link previews

## PURPOSE

Show a quiet preview when a reader hovers or keyboard-focuses a post-body link to another post on this site or to an X post. Internal cards show the title, date, and a short excerpt. X cards show the author, the post text, and the date when it was captured. A link with no preview data stays a normal link.

## CONTEXT

Tracking issue: GH-106. The site is a source-first Jekyll site published by GitHub Pages (`github-pages` 231, Jekyll 3.9.5) with no custom plugins. Post bodies already link to other posts with root-relative `/blog/YYYY/MM/DD/slug.html` paths and with `https://jamesonstone.io/blog/...` URLs. The only X links in the repository are two `https://x.com/_lopopolo/status/<id>` URLs in `_posts/2026-11-15-micromanaging-the-model.md`.

GitHub Pages will not run a project plugin or a repository script during the page build. Jekyll 3.9 has no `normalize_whitespace` filter, and the pinned Liquid 4 has no `continue` tag. Issue GH-107 is changing Open Graph metadata in parallel, so this feature does not edit `<head>` meta tags.

## REQUIREMENTS

On `.post-content` links only:

- A same-origin or `jamesonstone.io` URL whose path is a published post shows that post's title, date, and a short excerpt.
- An `x.com` or `twitter.com` status URL shows the captured author, full post text, and date when that status is present in committed data.
- Hover uses a real mouse pointer. Keyboard focus (`:focus-visible`) shows the same card immediately. Escape dismisses it until the pointer or focus leaves and returns. Touch and other non-mouse pointers do not open the card.
- The card is visual only (`aria-hidden="true"`), is not focused, and is not an `aria-describedby` target, so assistive technology announces the link once.
- `prefers-reduced-motion: reduce` removes the fade and the hover delay.
- Missing, unparsable, or unmatched data leaves the link unchanged. No runtime request to X. No third-party script.

Do not change post prose, add a public page, or edit social meta tags.

## ACCEPTED PLAN

Generate one JSON index in the post layout from `site.posts` plus `_data/x_posts.yml`, using only stock Jekyll. A small script in `assets/js/link-previews.js` reads that JSON and positions one shared card. Styles live in `assets/css/site.css` so `default.html` stays untouched. `scripts/validate_site.rb` checks the built index when the script is present.

X text, author, handle, and `created_at` are committed only after a successful read of the live post. The browser formats `created_at` in `America/New_York`.

## DECISIONS

Use a layout include instead of a custom plugin or a checked-in generated index. GitHub Pages regenerates the include on every build, so new posts get previews without a manual index, and Pages safe mode never has to run project code.

Commit X previews instead of calling X, oEmbed, or a syndication endpoint from the browser. The site stays static, and a missing status degrades to the plain link. The card drops a leading `@mention` reply prefix when it shows the text. The committed string stays the full post, and the author line already names the writer.

Keep the card out of the accessibility tree. A tooltip role plus `aria-describedby` would speak the preview after the link name. `aria-hidden` keeps a single announcement for the link while sighted keyboard users still see the card.

The open card accepts the pointer, including a small bridge across the gap, so a reader can move onto it. It stays up while the pointer is on the link or the card, or while the link has keyboard focus. Escape still dismisses it. Excerpt text decodes the common HTML character references left by `strip_html` before the card is built. The committed X text is already plain text and is not decoded.

Skip paragraphs that are series navigation ("Previous:" / "Next:" under 220 characters) when choosing an excerpt, then keep the first substantial paragraph, joined with the next one when the first is under 80 characters, and truncate to 32 words so the cut lands on a word. The title remains the primary label when the excerpt is thin.

Rejected: Twitter widgets, client fetches, and a Jekyll plugin. They either add a third-party runtime, call X from the reader, or fail on GitHub Pages.

## DISCOVERIES

`kit status` reports a managed-file refresh that rewrites contracts, workflows, and the README. That refresh is unrelated to GH-106 and is not applied.

The authenticated `gh` user lookup returned HTTP 403, so the integration token's login could not be confirmed from the API. Commit identity follows the human author already used on this repository's commits.

## VALIDATION

PASS: `ruby -c scripts/validate_site.rb`, `bundle exec jekyll build`, and `ruby scripts/validate_site.rb`. The built index has 54 posts and both captured X statuses. The X text matches `_data/x_posts.yml`.

PASS: `ruby -c scripts/update_projects_from_github.rb`, `ruby scripts/update_projects_from_github_test.rb` (10 runs, 42 assertions), `ruby scripts/update_projects_workflow_test.rb` (5 runs, 33 assertions), `ruby scripts/validate_site_test.rb` (16 runs, 48 assertions), `ruby scripts/machine_content_test.rb` (1 run, 73 assertions), `node --check assets/js/link-previews.js`, and `git diff --check`.

UNAVAILABLE: `actionlint` is not installed, so `.github/workflows/update-projects.yml` was not linted. That workflow was not edited.

Browser, on the built site: mouse hover opens the internal card and the X card; the pointer can move onto the card and it stays open; leaving both closes it; a GitHub link and an unknown status stay plain; keyboard focus opens the card and keeps it open after the pointer leaves; Escape closes it while focus remains; focus again reopens it; a touch pointer does not open it; a `twitter.com` status URL uses the same captured post; a root-relative post link opens that post's card; `prefers-reduced-motion: reduce` sets the card transition to `none`. The card stays `aria-hidden="true"` and the link has no `aria-describedby`.

The built excerpt for the archive post that opens with a Markdown image and links is plain prose. `strip_html` already received HTML for every post in that build, so the index was not switched to another excerpt source.

## OUTCOME

Post pages embed a Jekyll-built preview index and load `assets/js/link-previews.js`. Hover or keyboard focus on a post-body link shows one quiet card. Internal cards use the post title, date, and a short excerpt. The two `_lopopolo` posts linked from "Micromanaging the Model" have committed text, author, handle, and `created_at`. No other X links exist in the repository, so none were omitted for lack of text. `default.html` and its meta tags were not edited. The unrelated Kit managed-file refresh was not applied.

## REPOSITORY MEMORY

This spec is the feature record. `docs/references/testing.md` stays unchanged because the validation commands are unchanged. `llms.txt` stays unchanged because no public page was added.
