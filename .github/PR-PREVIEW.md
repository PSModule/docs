# PR docs preview setup

This repository publishes docs previews for pull requests under:

- `https://psmodule.io/docs/previews/pr-<number>/`

## What the workflow does

1. On PR open/reopen/synchronize:
   - builds docs with preview-specific `site_url`,
   - updates `previews/pr-<number>/` content via a PR into `gh-pages`,
   - enables auto-merge for that `gh-pages` PR,
   - comments on the source PR with the preview URL,
   - reports the preview URL through a named environment (`pr-preview-<number>`).
2. On PR close (merge or abandon):
   - removes `previews/pr-<number>/` via a PR into `gh-pages`,
   - enables auto-merge for that cleanup PR,
   - deletes all preview deployments and the preview environment.

## Required repository configuration

1. Ensure `gh-pages` branch exists.
2. Configure GitHub Pages to publish from `gh-pages`.
3. Protect `gh-pages` so direct commits are blocked and updates happen through PRs only.
4. Allow auto-merge for PRs in this repository.

## Scribbler GitHub App permissions

The app needs the following repository permissions:

| Permission | Access | Why |
| --- | --- | --- |
| Metadata | Read | Required baseline for API access |
| Contents | Read & write | Push preview/cleanup branches and update content |
| Pull requests | Read & write | Create/update/merge PRs into `gh-pages` |
| Issues | Read & write | Post and update preview comments on PR threads |
| Deployments | Read & write | Deactivate and delete preview deployments |
| Administration | Read & write | Delete per-PR environments during cleanup |
