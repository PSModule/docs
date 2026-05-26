# PR Format

Pull requests in PSModule double as **release notes**. The description is written for end users of the solution, not for reviewers or developers. Implementation details go in a clearly separated technical section at the bottom.

## Title

```text
<Icon> [<Type>]: <User-facing outcome>
```

- The **Icon** matches the change type.
- The **Type** in brackets is one of: `Major`, `Feature` (Minor), `Patch`, `Fix`, `Docs`, `Maintenance`.
- The **outcome** describes what changed from the end user's perspective. Never internal function names, class names, refactoring verbs.

### Good titles

- `🌟 [Major]: Get-Widget cmdlet removed`
- `🚀 [Feature]: Custom module templates now supported`
- `🩹 [Patch]: Default timeout value corrected`
- `🪲 [Fix]: Parameter validation no longer fails on null input`
- `📖 [Docs]: Installation guide updated with prerequisites`
- `⚙️ [Maintenance]: Release workflow and dependencies updated`

### Bad titles

- `Add support for custom module templates` — describes the action, not the outcome.
- `Refactor parameter validation logic` — implementation language.
- `Update stuff` — meaningless.

## Change types

| Type        | Icon | Label       | Description                                           |
| ----------- | ---- | ----------- | ----------------------------------------------------- |
| Major       | 🌟   | `Major`     | Breaking changes that affect compatibility            |
| Minor       | 🚀   | `Minor`     | New features or enhancements                          |
| Patch       | 🩹   | `Patch`     | Small fixes or improvements                           |
| Fix         | 🪲   | `Patch`     | Bugfixes (Patch-level release impact)                 |
| Docs        | 📖   | `NoRelease` | Documentation changes only                            |
| Maintenance | ⚙️   | `NoRelease` | CI/CD, build configs, AI/agent files, internal upkeep |

### Detecting the change type

The change type is decided in this order:

1. **Explicit user input** — if the contributor / Shipper specified a type, use it.
2. **Pre-1.0.0 rule** — projects with no version tags or latest tag below `v1.0.0` follow [SemVer §4](https://semver.org/#spec-item-4). Major is **never** auto-detected for pre-1.0.0 projects. Breaking changes there are classified as Minor (`0.x.0`).
3. **Artifact-based inference** from the branch diff:

    | Artifact type          | How to recognize                                              | Important files (affect artifact)                              | Non-important (framework / tooling)                              |
    | ---------------------- | ------------------------------------------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------- |
    | PowerShell Module      | `src/` with `.ps1`/`.psm1`, or a `.psd1` manifest             | `src/**`, `*.psd1`, `*.psm1`                                   | `.github/**`, `*.md`, `tests/**`, `scripts/**`, `agents/**`      |
    | GitHub Action          | `action.yml` at repo root                                     | `action.yml`, `src/**`                                         | `.github/**`, `*.md`, `tests/**`, `agents/**`                    |
    | Reusable Workflow      | `.github/workflows/` with callable workflows                  | `.github/workflows/**`                                         | `*.md`, `tests/**`, `agents/**`                                  |

4. **Classification rules** (apply in order):
    1. **Docs** — all changes are documentation only.
    2. **Maintenance** — all changes are non-important for the artifact (no shipped change).
    3. **Patch** — important-file changes are small fixes or minor improvements.
    4. **Minor** — important-file changes add features without breaking.
    5. **Major** — important-file changes break backward compatibility (pre-1.0.0 → downgrade to Minor).

If the branch contains both important and non-important changes, classify based on the important changes only.

## Description structure

Ordered, top to bottom.

### 1. Leading paragraph — Summary

A concise paragraph describing **what changes for the user**. Present tense, active voice. Never open with implementation language ("Refactored", "Updated class", "Added null checks").

### 2. User-facing changes — sections with headers

Organize by **what the user experiences**, not by what was changed internally.

- `## Breaking Changes` — what stopped working or changed incompatibly (Major only).
- `## New: <capability>` — new things the user can do.
- `## Changed: <behavior>` — existing behavior that now works differently.
- `## Fixed: <problem>` — problems now resolved.

Under each header:

- What the user can now do, or what changed for them.
- What they need to do differently — migration steps, new parameters, changed defaults.
- Examples or code snippets showing new usage.

Do **not** mention internal function names, class names, private APIs, or refactoring decisions here.

### 3. Technical details (optional)

```markdown
## Technical Details
```

For reviewers and maintainers. Not part of the release note. Include:

- Which internal functions, classes, or files were changed.
- Implementation approach and design decisions.
- Backward compatibility notes for developers.
- **Implementation plan progress** — cross-reference Section 3 of the linked issue. Which tasks does this PR complete? Which remain?

Omit the section entirely if there's nothing noteworthy.

### 4. Related issues

A collapsible `<details>` block at the very end of the description containing issue links. Always use fully qualified references (`Owner/Repo#N`) so links work across repositories.

```markdown
<details>
<summary>Related issues</summary>

- Fixes PSModule/GitHub#123
- PSModule/Process-PSModule#124

</details>
```

One bullet per linked issue. Use a [closing keyword](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue) (`Fixes`, `Closes`, `Resolves`) when the PR fully addresses the issue. Otherwise, list the reference without a keyword to indicate a relationship without auto-closing.

If no issue is linked: **stop**. PRs without issues break the workflow. Route back to the [Ideator](https://github.com/PSModule/.github-private/blob/main/agents/ideator.md) or proceed only on explicit user confirmation. The Shipper enforces this.

## Formatting

- Paragraphs are written as a **single unbroken line**. GitHub renders mid-paragraph newlines as spaces.
- The PR description is **the release note**. Write it for users, not reviewers.
- If a linked issue exists, the PR title and description should align with the issue's user-facing framing and the Technical Decisions section (Section 2).

## Example

````markdown
Repository objects now include custom properties directly — no separate API call needed. Queries that encounter missing or inaccessible resources now return partial results with warnings instead of failing entirely.

## New: Custom properties on repository objects

`Get-GitHubRepository` now returns custom properties inline on the repository object. Previously, retrieving custom properties required a separate call to `Get-GitHubRepositoryCustomProperty`.

```powershell
$repo = Get-GitHubRepository -Owner 'MyOrg' -Name 'MyRepo'
$repo.CustomProperties | Format-Table
```

`Get-GitHubRepositoryCustomProperty` remains available if only the properties are needed.

## Fixed: Queries no longer fail when a resource doesn't exist

Commands that query a specific repository, enterprise, or release by name now return nothing instead of throwing when the resource doesn't exist. This makes them safe to use in conditional logic without try/catch.

## Technical Details

- `GitHubRepository` class: `CustomProperties` property changed from `[PSCustomObject]` to `[GitHubCustomProperty[]]`.
- `Invoke-GitHubGraphQLQuery`: error handling split into partial-success (data + errors → warnings) and full-failure (errors only → terminating error) branches.
- Null guards added to `Get-GitHubRepositoryByName`, `Get-GitHubMyRepositoryByName`, and related functions.
- Implementation plan progress: tasks 1–3 in #218 completed; task 4 (integration tests) remains.

<details>
<summary>Related issues</summary>

- Fixes PSModule/GitHub#218
- PSModule/GitHub#219

</details>
````

## Drafts and readiness

- The Shipper always creates the PR as **draft** so CI attaches immediately.
- Marking ready for review is the contributor's decision — never the agent's.
- Suggested gates before marking ready: tests pass locally, description finalized, no known issues.

## Branches and commits

- Branch naming: `<type>/<issue-number>-<short-slug>`, e.g. `fix/123-pagination-truncation`.
- Commit messages: plain, direct, descriptive. **No conventional-commit prefixes** (`fix:`, `feat:`, `docs:`). See [Commit Conventions](Commit-Conventions.md).
- Self-review the staged diff before each commit. Unintended files (debug output, editor temp, credentials) get caught before they reach the remote.

## Labels and assignment

- Apply the change-type label.
- Apply phase labels if the repo uses them (Planning, Implementation, etc.).
- Assign the current user.
- Request reviewers per `CODEOWNERS`; if none, fall back to repo defaults or skip.
