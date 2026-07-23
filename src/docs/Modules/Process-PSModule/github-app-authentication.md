# GitHub App Authentication

Process-PSModule uses GitHub App installation tokens for GitHub API operations in the pipeline instead of `github.token`.

## Secret contract at reusable workflow boundary

The root reusable workflow (`workflow.yml`) requires two caller-provided secrets:

- `GitHubAppClientId`: GitHub App Client ID (identifier, not a secret)
- `GitHubAppPrivateKey`: GitHub App RSA private key (sensitive)

Callers map their repository or organization secret names into this contract:

```yaml
secrets:
  GitHubAppClientId: ${{ secrets.PSMODULE_CLIENT_ID }}
  GitHubAppPrivateKey: ${{ secrets.PSMODULE_PRIVATE_KEY }}
```

## Token minting model

Each workflow that needs GitHub API access mints its own short-lived installation token with a pinned action:

```yaml
- uses: actions/create-github-app-token@fee1f7d63c2ff003460e3d139729b119787bc349
```

### Plan.yml (settings, version resolution, PR labels)

```yaml
- uses: actions/create-github-app-token@fee1f7d63c2ff003460e3d139729b119787bc349
  with:
    app-id: ${{ secrets.GitHubAppClientId }}
    private-key: ${{ secrets.GitHubAppPrivateKey }}
    repositories: ${{ github.event.repository.name }}
    permission-contents: read
    permission-pull-requests: write
```

### Publish-Module.yml (release creation, artifacts, PR comments, prerelease cleanup)

```yaml
- uses: actions/create-github-app-token@fee1f7d63c2ff003460e3d139729b119787bc349
  with:
    app-id: ${{ secrets.GitHubAppClientId }}
    private-key: ${{ secrets.GitHubAppPrivateKey }}
    repositories: ${{ github.event.repository.name }}
    permission-contents: write
    permission-pull-requests: write
```

### Build-Module.yml (repository metadata for module manifest)

```yaml
- uses: actions/create-github-app-token@fee1f7d63c2ff003460e3d139729b119787bc349
  with:
    app-id: ${{ secrets.GitHubAppClientId }}
    private-key: ${{ secrets.GitHubAppPrivateKey }}
    repositories: ${{ github.event.repository.name }}
    # no permission-* inputs required here
    # gh repo view relies on metadata: read (auto-granted to GitHub Apps)
```

## Token injection pattern

Inject the minted token as `GH_TOKEN` only on steps that call GitHub APIs (for example, `gh` CLI steps). Do not set it job-wide unless every step requires GitHub API access.

## Why GitHub App tokens are used

- identity is app-scoped, not tied to an individual user
- pipeline automation can write where `github.token` is constrained in reusable-workflow fork scenarios
- each token mint is repository-scoped and permission-scoped
- effective permission ceiling is enforced at app installation level

Required installation permissions for Process-PSModule use cases:

- `contents: write`
- `pull-requests: write`
- `metadata: read` (auto-granted)

## Permission model distinctions

1. **Workflow `permissions:` block** controls only `github.token`; it does not change GitHub App installation tokens.
2. **GitHub App installation permissions** are the hard ceiling for any token minted by that app.
3. **`repositories:` input** scopes token reach. Default to `${{ github.event.repository.name }}` unless cross-repo access is intentionally required.
4. **`permission-<scope>:` inputs** request a per-token subset of installation permissions; request only the minimum needed by that workflow.
