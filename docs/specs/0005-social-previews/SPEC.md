---
kit_metadata_version: 1
artifact: spec
workflow_version: 3
phase: review
feature:
  id: "0005"
  slug: social-previews
  dir: 0005-social-previews
---

# Social previews

## PURPOSE

Give each post a distinct link preview in Discord, Slack, X, iMessage, and LinkedIn: its own description, a large title card, and correct Open Graph and Twitter card tags.

## CONTEXT

Tracking issue: GH-107. Shared posts currently unfurl with the site-wide description and no image. Generated preview images were explicitly approved for this task. Issue GH-106 owns post-body hover previews and is out of scope.

## REQUIREMENTS

Use an explicit excerpt when a post already has one. Otherwise use the opening of the rendered post, drop a leading "tl;dr:" label, and keep the text short enough for a link preview. Do not edit post prose or add excerpt front matter to existing posts.

Give every post a 1200×630 PNG title card in the site's Manrope, paper, ink, and teal. Non-post pages share one default card. A post with no card yet still renders valid tags that point at the default image.

Emit og:title, og:description, an absolute og:image with width and height, og:type=article and article:published_time on posts, og:url, and a canonical link. Use twitter:card=summary_large_image. Do not emit twitter:site or twitter:creator. The site has no configured X handle.

## ACCEPTED PLAN

Commit the PNGs. GitHub Pages builds with the github-pages gem in safe mode and will not run a custom generator or an unlisted plugin. `scripts/generate_social_cards.py` renders the cards with Pillow and the vendored Manrope font. The head include selects a post card only when that static file exists, and otherwise uses the default card. `scripts/validate_site.rb` rejects a missing, mistitled, or wrongly sized card and rejects rendered pages whose unfurl tags are incomplete.

## DECISIONS

Committed images, not a Pages plugin and not a new deploy workflow. Card filenames use the post source filename, so two posts that share a slug on different dates do not overwrite one card. Descriptions are computed while rendering, so a new post does not need new front matter to stay valid. The default image keeps a missing card from producing a broken image URL. Validation still requires the card before the post is accepted. No X handle is invented. Cards stay limited to the site name and the post title.

## VALIDATION

PASS: `ruby -c scripts/validate_site.rb`, `ruby -c scripts/update_projects_from_github.rb`, validator tests (17 runs, 51 assertions), updater tests (10 runs, 42 assertions), workflow tests (5 runs, 33 assertions), machine-content test (1 run, 127 assertions), `bundle exec jekyll build`, and `ruby scripts/validate_site.rb`. `git diff --check` reported no whitespace errors. `actionlint` was unavailable in this environment. `kit check` was unavailable because the Kit CLI is not installed.

The Micromanaging the Model page renders an article card, an absolute 1200×630 post image, a canonical URL, and a description taken from the opening text. A fixture post with no card still points at the default image. A fixture post with an explicit excerpt uses that excerpt. The home page uses the site title, the site description, and the default image. No `twitter:site` or `twitter:creator` tag is emitted.

## OUTCOME

Implemented on GH-107. Cards are committed PNGs. Delivery is a ready pull request. Merge and deployment stay with Jameson.

## REPOSITORY MEMORY

This spec records why cards are committed and how a missing card stays valid. The include and validator own the tag contract.
