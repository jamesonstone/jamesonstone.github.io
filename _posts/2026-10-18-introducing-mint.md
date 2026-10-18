---
layout: post
title: "Introducing Mint"
date: 2026-10-18 07:40:00 -0400
---

[Mint v1.0.0](https://github.com/jamesonstone/mint/releases/tag/v1.0.0) is out. It turns Git history into versioned releases: resolve the next semantic version from conventional commits, generate release notes, create an annotated tag, and publish a GitHub Release.

Those steps belong together. The version describes a set of changes. The notes explain them. The tag identifies the source. Keeping them in one release workflow makes it easier to trace a published version back to the code that produced it.

GitHub Actions is the normal way to use Mint. The action builds Mint on the runner, so contributors don't need to install a local binary. A minimal, manually triggered release workflow looks like this:

{% raw %}
```yaml
name: Release
on: workflow_dispatch

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: jamesonstone/mint@v1.0.0
        with:
          command: release-publish
          owner: ${{ github.repository_owner }}
          repo: ${{ github.event.repository.name }}
          github-token: ${{ github.token }}
```
{% endraw %}

Run this from the trusted release branch. The full checkout supplies the history and tags Mint needs to resolve the version. The job needs write access to publish its tag and GitHub Release.

Mint refuses to move a conflicting tag. Monorepos can scope versioning to component paths and use prefixes such as `backend/v1.2.3`. Application workflows still own their builds, container publishing, and deployments; Mint handles release state.

The optional CLI exposes the same tooling for manual work. Start with [Mint Release Tooling on GitHub Marketplace](https://github.com/marketplace/actions/mint-release-tooling), or read the [integration guide](https://jamesonstone.io/mint/). Mint is open source under Apache-2.0.
