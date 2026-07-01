# Commands

## Local Site

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

Build once:

```sh
bundle exec jekyll build
```

When the system Bundler cannot activate the lockfile version, use the vendored Jekyll path:

```sh
JEKYLL_NO_BUNDLER_REQUIRE=true \
GEM_HOME="$PWD/vendor/bundle/ruby/2.6.0" \
GEM_PATH="$PWD/vendor/bundle/ruby/2.6.0" \
ruby vendor/bundle/ruby/2.6.0/bin/jekyll build
```

Use `--future` only when validating a same-day post whose approved front matter time has not occurred yet.

## Validation

Run source and generated-site checks:

```sh
ruby -c scripts/validate_site.rb
ruby scripts/validate_site_test.rb
bundle exec jekyll build
ruby scripts/validate_site.rb
```

Run whitespace checks before completing documentation or code changes:

```sh
git diff --check
```

## Kit Project Checks

Validate repo-level Kit documentation:

```sh
kit check --project
```

Validate all feature docs when feature specs or repo instruction files are touched:

```sh
kit check --all
```

## Kit Discovery And Refresh

List active local rulesets:

```sh
kit rules list
```

Inspect command behavior before relying on flags or mutation semantics:

```sh
kit capabilities init --json
kit capabilities --search "pr review" --json
kit capabilities pr fix --json
```

Refresh Kit-managed files only when intentionally adopting upstream generated guidance:

```sh
kit init --refresh
kit init --refresh --dry-run --diff
kit init --refresh --force
```

After `kit init --refresh --force`, review semantic project documentation and promote durable changes into `docs/CONSTITUTION.md`, `docs/README.md`, `docs/commands.md`, `docs/agents/*`, or `docs/references/*` as appropriate.
