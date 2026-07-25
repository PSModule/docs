# Contributing

Thanks for helping improve the PSModule documentation. Everything here is a work in progress — if you find a
problem, fix it if it's small, or open an issue if it needs more discussion.

## Repository layout

- `src/docs/`: the documentation source, built as a [Zensical](https://zensical.org/) site.
- `src/includes/`, `src/overrides/`: shared snippets and theme customizations for the site.
- `src/zensical.toml`: site configuration and navigation.
- `guidance/`: example PowerShell snippets referenced from the docs.

## Making changes

1. Create a worktree/branch for your change (see [Git Worktrees](https://msxorg.github.io/docs/Ways-of-Working/Git-Worktrees/)).
2. Edit the relevant page(s) under `src/docs/`. Update `src/zensical.toml` navigation if you add or move a page.
3. Open a draft pull request early and push small, incremental commits so the change is easy to review.
4. Merge to `main` once review passes. The `Docs` workflow (`.github/workflows/Docs.yml`) builds and publishes the
   site to GitHub Pages on every merge to `main`.

## Building and previewing locally

```powershell
pip install zensical
cd src
zensical build --clean
```

The built site is written to `src/site/`. See the [Zensical docs](https://zensical.org/docs/setup/basics/) for
live-reloading preview options.

## Linting

Pull requests are linted with [super-linter](https://github.com/super-linter/super-linter) via the `Docs` workflow.
Keep Markdown changes consistent with the surrounding style and fix any linter findings reported on the PR.
