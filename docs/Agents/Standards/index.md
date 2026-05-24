# Standards

Per-language and per-platform standards referenced by the [Builder](https://github.com/PSModule/.github-private/blob/main/agents/builder.md) and [Reviewer](https://github.com/PSModule/.github-private/blob/main/agents/reviewer.md) agents.

## How standards interact with repos

1. **Repo-local linter config wins.** If a repo has `.editorconfig`, `.github/linters/*`, `PSScriptAnalyzerSettings.psd1`, `eslint.config.*`, etc., those rules are authoritative.
2. **Published standards fill the gap.** When the repo is silent on a rule, the standard below applies.
3. **Standards evolve.** When a published standard becomes outdated, it gets updated here — and downstream repos can adopt the change deliberately.

## Available standards

- **[PowerShell Modules](../../PowerShell/Modules/Standards.md)** — module layout, naming, parameter design, style, tests.
- **[GitHub Actions](../../GitHub-Actions/Standards.md)** — workflow security, SHA pinning, permissions, OIDC, the Zizmor checklist.

> More standards will be added as PSModule adopts more languages and platforms. Each new standard follows the same shape: principles → concrete rules → examples.

## When a standard is missing

If an agent is working on a language or platform that doesn't yet have a published standard:

1. Use the repo's existing conventions as the primary signal.
2. Apply the relevant linter or formatter defaults.
3. Surface the gap as a follow-up issue — proposing a new standard doc.

The goal is to grow this section as we go, not to wait until everything is documented before starting.
