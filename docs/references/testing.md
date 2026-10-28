# Testing Reference

## Local checks

Use the installed bundle and run:

```sh
ruby -c scripts/update_projects_from_github.rb
ruby -c scripts/validate_site.rb
ruby scripts/update_projects_from_github_test.rb
ruby scripts/update_projects_workflow_test.rb
ruby scripts/validate_site_test.rb
bundle exec jekyll build
ruby scripts/validate_site.rb
actionlint .github/workflows/update-projects.yml
git diff --check
```

If dependencies are installed in the primary checkout, set `BUNDLE_PATH` to its `vendor/bundle` directory. Generated `_site/` stays ignored.

## Pull-request checks

`Update projects page / Validate site and updater` runs the Ruby regressions, normal Jekyll build, and site invariants on every pull request. Its permissions are read-only. The publishing job is excluded from pull-request events.

The workflow regression suite uses temporary local Git repositories, the actual workflow shell steps, and a stub GitHub CLI. It verifies preservation of pending branch changes, inclusion of current source, safe conflict failure, index-only change detection, delivery of both generated files, open-only PR selection, and retrying already-committed output without empty commits. It performs no network calls or public writes.

## Updater rehearsal

For an isolated content rehearsal, use a temporary clone with the current repair source and the existing automation branch. Run its normal merge preparation, then invoke:

```sh
ruby scripts/update_projects_from_github.rb --repos-json /path/to/public-repositories.json
bundle exec jekyll build
ruby scripts/validate_site.rb
```

Repository metadata can also be a deterministic JSON fixture; no credentials are needed in fixture mode. `--dry-run` leaves both generated files untouched. Never stage or publish rehearsal output.

## Production verification

After an authorized merge, observe `Update projects page` for the exact merge commit. Confirm its validation passes and any generated PR includes both files. Do not automatically merge the generated content PR. Separately verify `pages-build-deployment` and the live article; an updater run is not deployment evidence.
