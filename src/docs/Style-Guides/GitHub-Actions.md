---
title: GitHub Actions
description: GitHub Actions style guidelines for consistency and security across workflows and composite actions.
---

## GitHub Actions style guidelines

This document defines the GitHub Actions style guidelines for all workflow files (`.github/workflows/*.yml`), composite actions (`action.yml`), and reusable workflows in PSModule repositories. These rules follow GitHub Actions best practices and the security guidance enforced by [zizmor](https://github.com/woodruffw/zizmor).

## Scope

- Applies to `.github/workflows/*.{yml,yaml}`, `action.yml`, `.github/dependabot.yml`, and `CODEOWNERS` entries for workflows.
- Application source code stays out of scope. If a fix requires changes outside `.github/`, surface it as a recommendation instead.

## Naming

- Give every job and every step a `name:` field
- Use short, human-readable names that describe what the job or step does, not how
- Keep naming consistent with existing workflows in the repository

**Good:**

```yaml
jobs:
  build:
    name: Build module
    steps:
      - name: Checkout repository
        uses: actions/checkout@<sha> # vX.Y.Z
```

**Bad:**

```yaml
jobs:
  build:
    steps:
      - uses: actions/checkout@<sha> # vX.Y.Z
```

## Quoting

- Only quote scalar values when YAML would otherwise misinterpret them
- Quote values starting with `{`, containing `:`, boolean-like strings (`true`/`false`), or numeric strings
- Omit quotes everywhere else

**Good:**

```yaml
run-name: Release ${{ github.ref_name }}
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
```

**Bad:**

```yaml
run-name: 'Release ${{ github.ref_name }}'
concurrency:
  group: '${{ github.workflow }}-${{ github.ref }}'
```

## Pinning actions

- Pin every `uses:` to a full 40-character commit SHA
- Add a patch-level version comment (`# vX.Y.Z`) so Dependabot can update SHA and comment together
- Applies to reusable workflows too (`uses: org/repo/.github/workflows/foo.yml@<sha>`)
- Exception: first-party actions in the same repository (`uses: ./.github/actions/...`)
- Resolve SHAs via `gh api` — never invent or guess a commit SHA. Always use the commit SHA, never the annotated-tag object SHA.

**Good:**

```yaml
- uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1
```

**Bad:**

```yaml
- uses: actions/checkout@v4
- uses: actions/checkout@main
```

Resolving SHAs:

```bash
gh api repos/<owner>/<repo>/git/refs/tags/<vX.Y.Z> --jq '.object.sha'
# If .object.type == "tag", dereference:
gh api repos/<owner>/<repo>/git/tags/<sha> --jq '.object.sha'
```

## Permissions

- Declare workflow-level `permissions:` set to the strictest needed (default `contents: read`)
- Override per-job when one job needs more
- Never use `permissions: write-all` or omit `permissions:` entirely
- Add an inline comment justifying any non-`read` grant

**Good:**

```yaml
permissions:
  contents: read

jobs:
  deploy:
    permissions:
      contents: read
      id-token: write   # OIDC federation to AWS
```

## Secrets and configuration

- Use `vars.*` for configuration: region, account ID, role ARN, environment name
- Use `secrets.*` for credentials: API tokens, passwords, signing keys
- Never hardcode account IDs, role ARNs, or region names
- Authenticate to cloud providers with OIDC, never long-lived keys
- In reusable workflows, pass secrets explicitly — never use `secrets: inherit`

**Good:**

```yaml
permissions:
  id-token: write
  contents: read

steps:
  - name: Configure AWS credentials
    uses: aws-actions/configure-aws-credentials@<sha> # vX.Y.Z
    with:
      aws-region: ${{ vars.AWS_REGION }}
      role-to-assume: ${{ vars.AWS_ROLE_ARN_CONTINUOUS_DEPLOYMENT }}
```

**Bad:**

```yaml
jobs:
  call:
    uses: ./.github/workflows/reusable.yml
    secrets: inherit
```

## Untrusted input

- Never interpolate untrusted context directly into shell commands
- Untrusted contexts include `github.event.issue.title`, `.body`, `.comment.body`, `.pull_request.title`, `.pull_request.body`, `.pull_request.head.ref`, `.head_commit.message`, `.review.body`, `.review_comment.body`, and `.head_ref`
- Pass untrusted values through an `env:` variable and quote them in the shell

**Good:**

```yaml
- run: echo "Title: $TITLE"
  env:
    TITLE: ${{ github.event.issue.title }}
```

**Bad:**

```yaml
- run: echo "Title: ${{ github.event.issue.title }}"
```

## Triggers and isolation

- Default to `pull_request` for PR validation
- Avoid `pull_request_target` and `workflow_run` unless required — they run with write tokens and secrets while potentially checking out attacker-controlled code
- If `pull_request_target` is unavoidable, never check out the PR head, or check out into a sandbox without secrets
- Use `actions/checkout` with `persist-credentials: false` unless the job pushes commits

**Good:**

```yaml
- uses: actions/checkout@<sha> # vX.Y.Z
  with:
    persist-credentials: false
```

## Runners and concurrency

- Pin `runs-on:` to a specific OS version (`ubuntu-24.04`) over a floating label (`ubuntu-latest`)
- Add `concurrency:` to deploy and release workflows
- Use `cancel-in-progress: true` for CI and `false` for deploys

**Good:**

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: false
```

## Operating protocol

Before writing or reviewing a workflow:

1. Read existing workflows and match shell choice, naming, job structure, and comment style
1. Check `.github/dependabot.yml` for `package-ecosystem: github-actions` and propose adding it if absent
1. Check `CODEOWNERS` for `.github/workflows/` ownership and recommend it if absent
1. Resolve SHAs via `gh api` — never invent a commit SHA

## Security checklist

Run mentally (and via [zizmor](https://github.com/woodruffw/zizmor) when available) before declaring done.

### High severity — must fix

- `template-injection` — no `${{ ... }}` from untrusted context inside `run:` or `script:`
- `dangerous-triggers` — `pull_request_target` / `workflow_run` justified and hardened
- `unpinned-uses` — every `uses:` has a 40-char SHA and `# vX.Y.Z` comment
- `excessive-permissions` — workflow- and job-level `permissions:` minimal
- `secrets-inherit` — no `secrets: inherit`
- `known-vulnerable-actions` — no pinned versions in GHSA
- `github-env` — no untrusted writes to `$GITHUB_ENV` / `$GITHUB_PATH`

### Medium severity — fix unless justified

- `overprovisioned-secrets` — no `${{ toJSON(secrets) }}` or wholesale `${{ secrets }}`
- `cache-poisoning` — no `actions/cache` (or `setup-*` cache) in tag-triggered release workflows
- `ref-confusion` — pinned ref is not a name shared by both a tag and a branch
- `ref-version-mismatch` — the `# vX.Y.Z` comment matches what the SHA actually is

### Low severity — fix when reasonable

- `stale-action-refs` — pinned commit corresponds to a real tag
- `impostor-commit` — pinned SHA exists in the action repo's history

## Related resources

- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [zizmor — static analysis for GitHub Actions](https://github.com/woodruffw/zizmor)
- [GitHub Actions Standard](../GitHub-Actions/Standards.md)
