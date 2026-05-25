# GitHub Actions Standard

Standards for authoring and reviewing GitHub Actions workflows (`.github/workflows/*.yml`), composite actions (`action.yml`), and reusable workflows.

> Applies whenever creating, modifying, or auditing workflow files. The [Builder](https://github.com/PSModule/.github-private/blob/main/agents/builder.md) and [Reviewer](https://github.com/PSModule/.github-private/blob/main/agents/reviewer.md) agents enforce these rules.

## Scope

- ✅ `.github/workflows/*.{yml,yaml}`, `action.yml`, `.github/dependabot.yml`, `CODEOWNERS` entries for workflows.
- ❌ Application source code stays out. If a fix requires changes outside `.github/`, surface it as a recommendation and stop.

## Operating protocol

Before writing or reviewing:

1. **Read existing workflows.** Match shell choice, naming, job structure, comment style, conventions.
2. **Check `.github/dependabot.yml`** for `package-ecosystem: github-actions`. Propose adding it if absent.
3. **Check `CODEOWNERS`** for `.github/workflows/` ownership. Recommend if absent (don't edit `CODEOWNERS` unless explicitly asked).
4. **Resolve SHAs via `gh api`.** Never invent or guess a commit SHA.

## Style

### S1 — Always name jobs and steps

Every job and every step must have a `name:` field. Names should be short, human-readable, and describe what the job or step does — not how.

```yaml
# ✅ Required
jobs:
  build:
    name: Build module
    steps:
      - name: Checkout repository
        uses: actions/checkout@<sha> # vX.Y.Z

# ❌ Anonymous — hard to read in the GitHub UI and logs
jobs:
  build:
    steps:
      - uses: actions/checkout@<sha> # vX.Y.Z
```

### S2 — Use quotes sparingly

Only quote scalar values when YAML would misinterpret them without quotes (e.g. values starting with `{`, containing `:`, boolean-like strings such as `true`/`false`, numeric strings). Omit quotes everywhere else.

```yaml
# ✅ Quotes only where needed
run-name: Release ${{ github.ref_name }}
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}

# ❌ Unnecessary quotes
run-name: 'Release ${{ github.ref_name }}'
concurrency:
  group: '${{ github.workflow }}-${{ github.ref }}'
```

## Security

### R1 — Pin every `uses:` to a full 40-char SHA with a patch level version comment

```yaml
# ✅ Required
- uses: actions/checkout@34e114876b0b11c390a56381ad16ebd13914f8d5 # v4.3.1

# ❌ Mutable tag
- uses: actions/checkout@v4

# ❌ Branch ref
- uses: actions/checkout@main
```

- Comment format: `# vX.Y.Z` (patch-level, `v` prefix) — Dependabot updates SHA and comment together.
- Applies to **reusable workflows** too: `uses: org/repo/.github/workflows/foo.yml@<sha>`.
- **Exception:** first-party actions in the same repo (`uses: ./.github/actions/...`).

Resolving SHAs:

```bash
gh api repos/<owner>/<repo>/git/refs/tags/<vX.Y.Z> --jq '.object.sha'
# If .object.type == "tag", dereference:
gh api repos/<owner>/<repo>/git/tags/<sha> --jq '.object.sha'
```

Always use the **commit** SHA, never the annotated-tag object SHA.

### R2 — Declare minimum `permissions:` explicitly

- Workflow-level `permissions:` set to the strictest needed. Default `contents: read`.
- Override per-job when one job needs more.
- **Never** `permissions: write-all` or omit `permissions:` entirely.
- Inline comment justifying any non-`read` grant (Zizmor `undocumented-permissions`).

```yaml
permissions:
  contents: read

jobs:
  deploy:
    permissions:
      contents: read
      id-token: write   # OIDC federation to AWS
```

### R3 — Cloud auth uses OIDC, never long-lived keys

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

Same pattern for GCP (`google-github-actions/auth` with `workload_identity_provider`), Azure (`azure/login` with `client-id`/`tenant-id`/`subscription-id`), Vault.

### R4 — `vars.*` for config, `secrets.*` for credentials

- Region, account ID, role ARN, environment name → `vars.*`.
- API tokens, passwords, signing keys → `secrets.*`.
- Never hardcode account IDs, role ARNs, or region names.

### R5 — Never interpolate untrusted context into shell

Untrusted contexts: `github.event.issue.title`, `.body`, `.comment.body`, `.pull_request.title`, `.pull_request.body`, `.pull_request.head.ref`, `.head_commit.message`, `.review.body`, `.review_comment.body`, `.head_ref`.

```yaml
# ❌ Template injection
- run: echo "Title: ${{ github.event.issue.title }}"

# ✅ Pass via env var, quote in shell
- run: echo "Title: $TITLE"
  env:
    TITLE: ${{ github.event.issue.title }}
```

Zizmor `template-injection` — the #1 real-world Actions CVE pattern.

### R6 — Avoid `pull_request_target` and `workflow_run` unless required

- `pull_request_target` runs with **write tokens and secrets** in the base repo context while potentially checking out attacker-controlled code from a fork. If unavoidable: never `actions/checkout` the PR head, or check out into a sandbox without secrets.
- `workflow_run` has the same hazard class.
- Default to `pull_request` for PR validation; use environments + required reviewers when secrets are needed.

### R7 — `actions/checkout` with `persist-credentials: false` unless pushing

```yaml
- uses: actions/checkout@<sha> # vX.Y.Z
  with:
    persist-credentials: false
```

Without this, the `GITHUB_TOKEN` is left in `.git/config` and can leak into uploaded artifacts (Zizmor `artipacked`).

### R8 — `concurrency:` on deploy/release workflows

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: false   # true for CI; false for deploys
```

### R9 — Pin `runs-on:` to a specific OS version

```yaml
# ✅
runs-on: ubuntu-24.04

# ⚠️ Acceptable but less reproducible
runs-on: ubuntu-latest
```

### R10 — Reusable workflows: explicit `secrets:`, never `secrets: inherit`

```yaml
# ❌
jobs:
  call:
    uses: ./.github/workflows/reusable.yml
    secrets: inherit

# ✅
jobs:
  call:
    uses: ./.github/workflows/reusable.yml
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

## Zizmor audit checklist

Run mentally (and via [zizmor](https://github.com/woodruffw/zizmor) when available) before declaring done.

### High severity — must fix

- `template-injection` — no `${{ ... }}` from untrusted context inside `run:` or `script:`.
- `dangerous-triggers` — `pull_request_target` / `workflow_run` justified and hardened.
- `unpinned-uses` — every `uses:` has a 40-char SHA + `# vX.Y.Z` comment.
- `excessive-permissions` — workflow- and job-level `permissions:` minimal.
- `secrets-inherit` — no `secrets: inherit`.
- `known-vulnerable-actions` — no pinned versions in GHSA.
- `github-env` — no untrusted writes to `$GITHUB_ENV` / `$GITHUB_PATH`.
- `github-app` — `actions/create-github-app-token` calls scope `repositories:` and `permissions:`.
- `hardcoded-container-credentials` — container `credentials:` use `secrets.*`.

### Medium severity — fix unless justified

- `overprovisioned-secrets` — no `${{ toJSON(secrets) }}` or wholesale `${{ secrets }}`.
- `cache-poisoning` — no `actions/cache` (or `setup-*` cache) in release workflows triggered by tags.
- `unredacted-secrets` — no `fromJSON(secrets.*)` paths that get echoed.
- `ref-confusion` — pinned ref isn't a name shared by both a tag and a branch.
- `use-trusted-publishing` — PyPI/npm/etc. publishing uses OIDC trusted publishing.
- `ref-version-mismatch` — the `# vX.Y.Z` comment matches what the SHA actually is.

### Low severity — fix when reasonable

- `stale-action-refs` — pinned commit corresponds to a real tag.
- `impostor-commit` — pinned SHA exists in the action repo's history.

## Verification protocol

When producing a workflow, report:

- Every action pinned with `owner/repo@sha # vX.Y.Z`.
- The `permissions:` declared.
- Any checklist item intentionally skipped and why.
