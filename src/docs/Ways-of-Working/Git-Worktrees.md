# Git Worktrees

All repositories are set up as **bare clones with worktrees**. This enables parallel work — multiple agents (or a human and an agent) can work on different issues in the same repository simultaneously without conflicts, stashing, or context-switching.

## Why worktrees

| Problem with traditional clones              | How worktrees solve it                                    |
| -------------------------------------------- | --------------------------------------------------------- |
| Only one branch checked out at a time        | Each issue gets its own worktree — parallel by default    |
| Switching branches requires clean state      | Worktrees are independent — no stashing or committing WIP |
| Agent work blocks human work on same repo    | Different worktrees, no interference                      |
| Default branch gets dirty during development | `<default>/` worktree is always a clean reference         |

## Repository layout

```text
<repo-root>/
├── .bare/              # bare git data (the actual repository)
├── .git                # file containing: gitdir: ./.bare
├── <default>/          # worktree: default branch (always clean, never worked in directly)
├── 42-add-pagination/  # worktree: issue #42 in progress
└── 99-fix-null-ref/    # worktree: issue #99 in progress
```

- **`.bare/`** — the shared git object store. All worktrees share this.
- **`.git`** — a file (not a directory) that points git tooling to `.bare/`.
- **`<default>/`** — the default branch worktree (e.g. `main` or `master`). Kept as a clean reference. Used for diffing, reading docs, running comparisons. Never directly committed to.
- **`<N>-<slug>/`** — one worktree per issue in flight. Named by issue number and a short slug. Branch name matches the folder name.

## Remotes

Every repository has exactly two remotes (or one, if it is not a fork):

| Remote         | Points to                    | Required | Purpose                                          |
| -------------- | ---------------------------- | -------- | ------------------------------------------------ |
| **`origin`**   | Our copy on the server       | Always   | Push branches, open PRs, CI runs against this.   |
| **`upstream`** | The parent repo (forks only) | Forks    | Track upstream changes, sync the default branch. |

No other remotes are added. This keeps the model simple and predictable for both humans and agents.

### How it works in practice

- **Non-fork repos** — only `origin` exists. Branches are pushed to `origin`, PRs are opened against `origin`.
- **Forked repos** — `origin` is our fork, `upstream` is the original repository. The default branch tracks `upstream` for syncing; feature branches are pushed to `origin` and PRs are opened from `origin` into `upstream`.

### Fetch configuration

Both remotes are configured with full refspecs so `git fetch --all --prune` keeps everything current:

```text
[remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*

[remote "upstream"]   # forks only
    fetch = +refs/heads/*:refs/remotes/upstream/*
```

## Setup (one-time per repository)

```powershell
# Clone as bare into .bare/
git clone --bare https://github.com/<owner>/<repo>.git .bare

# Create the .git pointer file
Set-Content .git "gitdir: ./.bare" -NoNewline

# Configure fetch refspec (bare clones don't set this automatically)
git -C .bare config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

# Fetch remote branches
git -C .bare fetch origin

# Determine the default branch
$defaultBranch = git -C .bare symbolic-ref HEAD | ForEach-Object { $_ -replace 'refs/heads/', '' }

# Create the default branch worktree
git -C .bare worktree add "../$defaultBranch" $defaultBranch

# Set upstream tracking (prevents "Publish Branch" prompt in VS Code)
git -C .bare config "branch.$defaultBranch.remote" origin
git -C .bare config "branch.$defaultBranch.merge" "refs/heads/$defaultBranch"
```

> The [Checkout-GitHubRepo](https://github.com/MariusStorhaug/.dev/blob/main/.github/Checkout-GitHubRepo.ps1) script automates this for all repositories.

## Working on an issue

```powershell
# From the repo root (where .bare/ lives)
$defaultBranch = git -C .bare symbolic-ref HEAD | ForEach-Object { $_ -replace 'refs/heads/', '' }
git -C .bare worktree add ../42-add-pagination -b 42-add-pagination $defaultBranch

# Set upstream tracking (prevents "Publish Branch" prompt in VS Code)
git -C .bare config branch.42-add-pagination.remote origin
git -C .bare config branch.42-add-pagination.merge refs/heads/42-add-pagination

# Open in VS Code
code 42-add-pagination
```

Then follow the normal Implement flow: initial commit → push → draft PR → build → finalize.

## Cleanup after merge

```powershell
# Remove the worktree
git -C .bare worktree remove 42-add-pagination

# Delete the local branch ref
git -C .bare branch -D 42-add-pagination

# Prune if needed (removes stale worktree references)
git -C .bare worktree prune
```
