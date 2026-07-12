# PowerShell module repository defaults

This page defines the default repository contract for PowerShell module repositories in the PSModule organization. It describes what a newly created or maintained module repository should look like before module-specific code, tests, documentation, and managed repository files are considered.

The implementation standard still lives in [PowerShell module standard](Standards.md). Type-specific conventions for integration (API) and data modules live in [Module types](Module-Types.md). This page covers repository defaults: files, metadata, README shape, release integration, placeholder handling, shared community files, agent onboarding files, and managed-file distribution.

## Scope

These defaults apply to repositories whose primary artifact is a PowerShell module published through the PSModule framework.

They do not apply directly to:

- GitHub Action repositories such as `Build-PSModule`, `Invoke-Pester`, or `Publish-PSModule`.
- Documentation repositories such as `PSModule/docs`.
- Template repositories other than `Template-PSModule`.
- Test, archive, service, or infrastructure repositories that are not published as module artifacts.

Two baseline expectations still apply to every PSModule repository, including the types listed above. Each repository stands on its own — it carries its own governance and community files instead of relying on the organization `.github` fallback — and each repository ships the [agent onboarding files](#agent-onboarding-files) so an agent can work in it without prior context. What differs by type is the concrete file set and layout: the required files, README shape, and framework wiring on the rest of this page are module defaults, and non-module repositories keep only the equivalent baseline appropriate to their own type. This repository, `PSModule/docs`, follows those two baseline expectations itself.

Each initiative should keep its own repository standards in its central documentation repository. For the PSModule organization, this repository is the source of truth.

## Repository creation

Create new module repositories from [`PSModule/Template-PSModule`](https://github.com/PSModule/Template-PSModule). The template provides the framework wiring, starter layout, and CI/CD expectations.

After creating the repository:

1. Replace template tokens such as `{{ NAME }}` and `{{ DESCRIPTION }}`.
2. Remove scaffold functions, tests, and examples that do not represent the module.
3. Set repository metadata and custom properties.
4. Confirm the README answers the start-page questions and uses `Install-PSResource` for installation.
5. Confirm required common files are present.
6. Confirm `.github/PSModule.yml` only overrides defaults when the module needs different behavior.

## Required repository metadata

Each module repository should have:

- A concise GitHub repository description that starts with or clearly says `A PowerShell module ...`.
- `RepoType: Module` as the repository custom property.
- Topics that help users find the module, when relevant.
- Branch protection and workflow requirements inherited from organization defaults.
- `main` as the default branch unless there is a documented legacy reason.

The repository description is used as a short landing-page summary in documentation and automation. Keep it user-facing and avoid implementation details.

## Default branch and worktrees

Use `main` for active module repositories. Legacy repositories that still use `master` should not be used as examples for new work.

Local work should use the organization worktree convention:

- The bare repository stays at the repository root.
- `main/` tracks the default branch.
- Feature worktrees use `<type>-<slug>` directories and `<type>/<slug>` branches.

For branch and worktree details, see [Git Worktrees](../../Ways-of-Working/Git-Worktrees.md).

## Default repository layout

Module repositories use the PSModule framework layout:

| Path | Default purpose |
| ---- | --------------- |
| `README.md` | Concise start page for the module. |
| `LICENSE` | Repository license. PSModule module repositories default to MIT unless a different license is explicitly decided. |
| `CONTRIBUTING.md` | Self-contained contribution workflow for this repository. Does not rely on an organization-level fallback. |
| `SECURITY.md` | Security support policy and private vulnerability reporting instructions. |
| `SUPPORT.md` | Support expectations and where users ask for help. |
| `CODE_OF_CONDUCT.md` | Community conduct expectations. |
| `AGENTS.md` | Agent onboarding entry point. Points agents to the PSModule and MSX documentation for the why, how, and what. |
| `CLAUDE.md` | Claude Code entry point. Imports `AGENTS.md` so Claude reads the same instructions. |
| `.github/copilot-instructions.md` | VS Code and GitHub Copilot repository instructions. Points to the same documentation. |
| `.github/PSModule.yml` | Module workflow configuration overrides. |
| `.github/workflows/workflow.yml` | Reusable Process-PSModule workflow entry point. |
| `.github/dependabot.yml` | Dependency and supply-chain update configuration. |
| `.github/CODEOWNERS` | Ownership routing for reviews and protected areas. |
| `.github/pull_request_template.md` | PR Manager-compatible pull request template. |
| `.gitattributes` | Git line-ending and file handling defaults. |
| `.gitignore` | Shared ignore rules. |
| `src/` | Module source compiled into the shipped artifact. |
| `src/functions/public/` | Exported commands, grouped by domain. |
| `src/functions/private/` | Internal helper commands, grouped by domain. |
| `src/classes/public/` | Public classes that are part of the user-facing model. |
| `src/classes/private/` | Internal implementation classes. |
| `src/data/` | Static module data that ships with the module. |
| `examples/` | Realistic user scenarios, not copies of command help. |
| `docs/` | Product documentation source when the module needs documentation beyond generated command help. |
| `tests/` | Pester tests and test data. |
| `icon/` | Module icon assets. |

Detailed source layout rules live in [PowerShell module standard](Standards.md#repository-layout).

## Required common files

Every module repository must carry the same baseline community, governance, and automation files. GitHub's organization-level `.github` community-file fallback is useful for display defaults, but it is not enough as the long-term PSModule standard because:

- agents and humans need the files in the repository they are changing, not only inherited through GitHub UI behavior;
- tools such as Dependabot, linters, CODEOWNERS, and release automation read repository-local files;
- reviews need diffs against the actual managed file in the target repository;
- repository-local files make the standard portable to other initiatives such as MSXOrg, where each initiative should define its own standards and managed files;
- central fallback files in `PSModule/.github` do not provide a reliable enforcement or update workflow across all repositories.

Required baseline files for module repositories:

| File | Why it is required |
| ---- | ------------------ |
| `README.md` | Repository landing page and evergreen context for humans and agents. |
| `LICENSE` | Clear legal terms for reuse, packaging, and redistribution. |
| `CONTRIBUTING.md` | Self-contained contribution workflow and expectations for this repository. |
| `SECURITY.md` | Private vulnerability reporting and latest-version support policy. |
| `SUPPORT.md` | Support channel and issue-routing expectations. |
| `CODE_OF_CONDUCT.md` | Community participation rules. |
| `AGENTS.md` | Cross-tool agent instructions pointing to the PSModule and MSX documentation. |
| `CLAUDE.md` | Claude Code entry point that imports `AGENTS.md`. |
| `.github/copilot-instructions.md` | VS Code and GitHub Copilot repository instructions pointing to the documentation. |
| `.github/dependabot.yml` | Supply-chain maintenance for GitHub Actions and PowerShell dependencies. |
| `.github/CODEOWNERS` | Review routing for source, docs, and GitHub workflow files. |
| `.github/pull_request_template.md` | Consistent PR Manager-style PR descriptions and change classification. |
| `.github/release.yml` | Release-note and changelog categorization where the repository creates GitHub releases. |
| `.github/PSModule.yml` | Module workflow defaults and overrides. |
| `.github/linters/.markdown-lint.yml` | Markdown linting defaults. |
| `.github/linters/.powershell-psscriptanalyzer.psd1` | PSScriptAnalyzer defaults. |
| `.gitattributes` | Git attribute defaults. |
| `.gitignore` | Shared ignore rules. |

Repositories can add local files, but they should not remove these baseline files unless the repository is explicitly outside the module standard.

Each repository must stand on its own. It carries its own copy of every file above and does not depend on the organization `.github` fallback: that fallback is only surfaced in GitHub's web UI, and agents, linters, and local tooling do not read it.

## Agent onboarding files

Every repository must be usable by an agent that has never seen it before, without special configuration. Each repository carries its own agent entry points that *point to* the authoritative documentation instead of restating it:

- `AGENTS.md` — the cross-tool entry point, read by the GitHub Copilot coding agent, VS Code, and other AGENTS.md-aware tools. It names what the repository is in a line or two and points to the PSModule documentation (`https://psmodule.io`, source in [`PSModule/docs`](https://github.com/PSModule/docs)) for the module's why/how/what, and to the MSX documentation (`https://msxorg.github.io/docs`, source in [`MSXOrg/docs`](https://github.com/MSXOrg/docs)) for organization-level principles and ways of working.
- `CLAUDE.md` — a thin file that imports `AGENTS.md` with `@AGENTS.md` so Claude Code reads the same instructions. Claude-specific notes, if any, go below the import.
- `.github/copilot-instructions.md` — repository instructions for VS Code and GitHub Copilot that point to the same documentation.

These files are the agent equivalent of the README: pointers, not copies. Keep them short so the linked documentation stays the single source of truth. Like the other governance files, they live in the repository itself so it can stand on its own.

## Managed file distribution

Shared files should be treated as managed files. The current distribution service is [`PSModule/Distributor`](https://github.com/PSModule/Distributor). It keeps source file sets under `Repos/{Type}/{Selection}/` and syncs those files into repositories through pull requests.

The current Distributor model is subscription-based:

- `Type` is an organization repository custom property that maps a repository to a type folder such as `Module` or `Action`.
- `SubscribeTo` is an organization repository custom property that selects file sets such as `dependabot.yml`, `Linter Settings`, `PSModule Settings`, `CODEOWNERS`, `License`, `.gitattributes`, and `.gitignore`.
- Sync changes are delivered through a `managed-files/update` branch and a `⚙️ [Maintenance]: Sync managed files` pull request.
- Managed files are overwritten by the source file set. Local edits to managed files should be made in Distributor, not directly in the receiving repository.
- Removing a file from a Distributor file set does not delete the previously distributed file from target repositories; cleanup is explicit.

Two follow-up Distributor capabilities define the desired direction:

- **Global file sets** should allow common file sets such as `.gitattributes`, `.gitignore`, and `License` to be defined once and made available to all repository types while still requiring subscription.
- **Mandatory file sets** should allow organization-critical files such as `SECURITY.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, the agent onboarding files (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`), and supply-chain configuration to be pushed to applicable repositories without each repository having to subscribe manually.

Until mandatory file sets exist, repository owners are still responsible for ensuring the required common files exist. Distributor is the preferred implementation mechanism; this document is the standard that says what must exist and why.

## Supply-chain defaults

Every module repository must include `.github/dependabot.yml`. Dependabot is part of the repository supply-chain control, not an optional convenience.

Module repositories should configure at least:

```yaml
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
    labels:
      - "dependencies"
      - "github-actions"

  - package-ecosystem: "powershell"
    directory: "/"
    schedule:
      interval: "weekly"
    labels:
      - "dependencies"
      - "powershell"
```

The GitHub Actions ecosystem keeps pinned actions current. The PowerShell ecosystem keeps PowerShell dependency declarations current where Dependabot supports them. Repositories with additional package ecosystems should add them explicitly rather than replacing these defaults.

Dependabot PRs still go through normal review. Automated dependency updates are not a substitute for reviewing release notes, changed permissions, pinned SHAs, or generated lockfiles.

## README default

A module README is a start page, not the command reference or full manual. It brings a reader in, answers the first questions, and sends them to the right documentation surface.

Making the README shorter must not delete unique information. The README is published as the module's landing page on the documentation site (for example `psmodule.io/<ModuleName>`); the per-command reference is generated separately from comment-based help. So the README is often the only published home for prerequisites, platform and dependency notes, authentication and setup guidance, operational behavior such as caching, state, or update and versioning semantics, and upstream attribution. Trimming the README must preserve that content: keep it on the landing page, or move it only to another surface that also publishes (a command group's overview page under `src/functions/public/<Group>/<Group>.md`, or comment-based help). Only remove content that is genuinely duplicated by the generated command reference.

The README answers these questions, in this order:

| Question | Module README responsibility |
| --- | --- |
| What is it? | Name the module and define its scope in one short paragraph. |
| Why should I care? | State the value or kind of task the module makes easier. |
| How do I get it? | Show the PowerShell Gallery install and import commands. |
| How does it work? | Show one to three representative usage examples. |
| How do I get more info? | Link to generated module documentation and PowerShell help. |

Module installation examples must use PSResourceGet:

```powershell
Install-PSResource -Name <ModuleName>
```

Do not use `Install-Module` in new module repository documentation. `Install-Module` belongs only in legacy/historical context where changing it would misrepresent the referenced system.

For implemented modules, use this shape:

````markdown
# <ModuleName>

<One short paragraph describing what the module is and why it is useful.>

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name <ModuleName>
Import-Module -Name <ModuleName>
```

## Usage

Use this section as a short showcase and introduction to how the module works. Show the most important things the module makes possible with one to three realistic examples; `### Example: <scenario>` subsections are fine when you have more than one.

The goal is discovery, not exhaustive command documentation. A reader should understand why the module exists and what kind of tasks it helps with.

```powershell
# Replace this with a real example that demonstrates the module's value.
Get-Command -Module <ModuleName>
```

## Documentation

Documentation is published at [psmodule.io/<ModuleName>](https://psmodule.io/<ModuleName>/).

Use PowerShell help and command discovery for module details:

```powershell
Get-Command -Module <ModuleName>
Get-Help -Name <Command> -Examples
```
````

In the documentation examples, replace `<Command>` with a real command exported by the module, for example `Get-Help -Name Get-GitHubRepository -Examples`, so the snippet runs as written. Do not ship placeholder tokens such as `'CommandName'` or `<CommandName>` as if they were runnable commands.

Implemented modules must include the `## Usage` showcase before the documentation link. Keep it focused on discovery: show one to three representative outcomes, not every command, parameter, or edge case. A landing page with only an installation snippet and a documentation link is not enough for a module that has working commands. Do not title this section `## Capabilities`; use `## Usage` (or `## Examples`).

Keep, trim, or relocate content — do not delete it:

- **Keep on the landing page:** the overview, prerequisites and requirements (PowerShell version, supported platforms, module or native dependencies), installation, the usage showcase, and the short operational notes a reader needs before first use.
- **Trim:** exhaustive command inventories, parameter tables, and repetitive examples that differ only by a parameter. These come from comment-based help — point to `Get-Help` and the documentation site instead of restating them.
- **Relocate only to a published home — never drop:** long-form guides and unique conceptual content (authentication and setup walkthroughs, deep operational detail, end-to-end scenarios) may move out of the README only into a surface that is actually published: a command group's overview page under `src/functions/public/<Group>/<Group>.md`, or comment-based help. A bare top-level `docs/` folder is not published by the current docs build, so moving content there drops it from the site. When there is no published home for it yet, keep the full content in the README. A longer landing page is acceptable and expected for feature-rich modules; do not shorten by deleting.

Retain upstream attribution and licensing context. Credit, acknowledgements, donation notes, and third-party license notices for wrapped or bundled work must stay in the README, or move to a clearly linked place. The rule below about community and policy sections does not apply to attribution the project is expected to carry.

README pages should not duplicate generated command documentation. Do not add full command inventories, parameter tables, or long reference sections when those details are already produced from comment-based help.

Do not add a community-file, policy, or Contributing link section to the README by default, and do not add a `## Contributing` section. Each repository carries its own `CONTRIBUTING.md`, `SECURITY.md`, `SUPPORT.md`, and `CODE_OF_CONDUCT.md`; readers and tools find them through the repository file tree and GitHub renders them in its UI. The README links or restates them only when the module has an unusual rule the user must know before using it, or when it carries required upstream attribution.

## Placeholder and in-progress repositories

If a repository is reserved for a future module or still contains scaffold code, say that directly. Do not leave `{{ NAME }}`, `{{ DESCRIPTION }}`, `PSModuleTemplate`, `Greet-Entity`, or similar template examples in the README.

Use this shape for placeholder repositories:

````markdown
# <ModuleName>

<One sentence describing what the module is intended to become.>

## Status

This repository is currently a placeholder. The module source still contains scaffold code, so there are no supported commands or usage examples to document yet.

## Documentation

When this module is implemented, command details should live in PowerShell help and generated documentation rather than being duplicated in this README.
````

Use the same pattern for in-progress modules with stub commands, but name the stub honestly:

```markdown
This repository is currently in progress. The current `<CommandName>` command is a stub and throws `NotImplementedException`, so there are no supported conversion commands or usage examples to document yet.
```

## README validation

Before opening a README-only PR, check that the README follows the default and does not contain leftover scaffolding:

```powershell
Select-String -Path README.md -SimpleMatch -Pattern 'Greet-Entity', 'PSModuleTemplate', 'YourModuleName'
Select-String -Path README.md -SimpleMatch -Pattern '{{ NAME }}', '{{ DESCRIPTION }}'
Select-String -Path README.md -SimpleMatch -Pattern "-Name 'CommandName'", '<CommandName>'
Select-String -Path README.md -Pattern '^## (Commands|Capabilities)$'
Select-String -Path README.md -Pattern '^Install-Module\b'
git diff --check -- README.md
```

`Template-PSModule` is the exception: it intentionally keeps `{{ NAME }}` and `{{ DESCRIPTION }}` tokens because those are template inputs.

For an implemented module, also confirm the README keeps a `## Usage` showcase and that any unique content removed from the previous version — prerequisites, setup or authentication guidance, operational notes, or upstream attribution — was relocated to a published surface (`src/functions/public/<Group>/<Group>.md`, `examples/`, or comment-based help) rather than deleted.

## Documentation ownership

Command details belong in comment-based help and generated documentation. The README can showcase capability, then points to those sources for reference detail.

Use these defaults:

- Command synopsis, parameters, examples, links, and outputs live in comment-based help.
- Group overview pages live next to public command groups in `src/functions/public/<Group>/<Group>.md`.
- Realistic end-to-end scenarios live in `examples/`.
- Product docs beyond generated command help live under `docs/` and publish through GitHub Pages or the initiative's module documentation site.
- README capability examples are short, representative, and user-facing.
- README pages stay focused and stable, and keep the narrative content that has no other published home.

This keeps the repository landing page readable and prevents drift between README content, PowerShell help, and generated documentation.

## Release and PR defaults

Module repositories use the Process-PSModule workflow. Version and release behavior is driven by PR labels and workflow settings.

Default expectations:

- `Major`, `Minor`, `Patch`, and `Prerelease` labels determine release behavior.
- Documentation-only README standardization PRs use the `Docs`/`NoRelease` behavior when available.
- Source changes under `src/` are module-impacting and should trigger the full module workflow.
- README and documentation changes should update the site without pretending to be module API changes.

See [Versioning](Versioning.md) for semantic version rules and [PowerShell module standard](Standards.md#cicd-pipeline) for the Process-PSModule pipeline.

## Template maintenance

`Template-PSModule` defines the default README shape and starter repository contract. When this page changes a default, update `Template-PSModule` in the same work item when practical.

The template README may contain tokens, but generated module repositories should not keep them after the initial setup commit.
