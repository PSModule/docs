# Commit Conventions

Commit messages serve two audiences: the engineer reading `git log` six months from now, and the agents trying to reconstruct what changed and why. Both need the same thing — **direct, descriptive messages** that say what was done.

## Rules

1. **State what was done or what the result is.** Imperative or declarative, both work.
2. **No conventional-commit prefixes.** No `fix:`, `feat:`, `docs:`, `chore:`, `refactor:`, etc. The change type is captured at the PR level — repeating it on every commit adds noise without information.
3. **No generic messages.** `Update for PR`, `WIP`, `fixes`, `more changes` — all forbidden. They erase traceability.
4. **One logical change per commit.** Micro-iterative discipline. If a change touches three unrelated concerns, that's three commits.
5. **Reference issues by number when natural** — but don't force it. `Fixes #N` belongs in the PR description, not every commit message.

## Examples

### Good

- `Add reserved word validation to Lua parser`
- `Correct hex float parsing for negative exponents`
- `Update installation prerequisites in README`
- `Remove deprecated Get-Widget cmdlet`
- `Switch pagination to link-header-based`
- `Add regression test for null context in Resolve-GitHubContext`

### Bad

- `fix: parsing bug` — prefix + vague.
- `Update for PR` — meaningless.
- `WIP` — never commit work that needs a placeholder message; squash or amend first.
- `Refactor stuff` — vague.
- `Changes` — ø.

## Body (optional)

A commit message body is fine for non-trivial changes that need context. Keep it short. Wrap at ~72 characters per line.

```text
Switch pagination to link-header-based

The previous page-number approach hardcoded the page size, which
breaks when the API returns the default. Link headers are what
the GitHub REST API documents as the supported pagination
mechanism.
```

## Why no conventional commits

PSModule classifies changes at the PR level via labels and the change-type field. The release note is generated from the PR description, not from commit messages. Conventional-commit prefixes inside the repo:

- Duplicate information already captured elsewhere.
- Encourage `chore:` and `refactor:` over descriptive messages.
- Lock the repo into a tooling pattern (Commitizen, semantic-release) that PSModule doesn't use.

Direct, descriptive messages serve both engineers and agents without the ceremony.

## When working with agents

The Builder writes commits during the micro-iterative loop. Each commit covers one discrete change. The Responder writes commits when addressing review feedback — one commit per thread when practical, so the link between feedback and fix is preserved in history.

Never let an agent commit with a placeholder message. If a commit can't be described in one clear line, the change is probably too broad — split it.
