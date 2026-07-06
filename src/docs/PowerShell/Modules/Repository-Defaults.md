# PowerShell module repository defaults

This page defines the default repository contract for PowerShell module repositories in the PSModule organization. It describes what a newly created or maintained module repository should look like before module-specific code, tests, documentation, and managed repository files are considered.

The implementation standard still lives in [PowerShell module standard](Standards.md). This page covers repository defaults: files, metadata, README shape, release integration, placeholder handling, shared community files, and managed-file distribution.

## Scope

These defaults apply to repositories whose primary artifact is a PowerShell module published through the PSModule framework.

They do not apply directly to:

- GitHub Action repositories such as `Build-PSModule`, `Invoke-Pester`, or `Publish-PSModule`.
- Documentation repositories such as `PSModule/docs`.
- Template repositories other than `Template-PSModule`.
- Test, archive, service, or infrastructure repositories that are not published as module artifacts.

Each initiative should keep its own repository standards in its central documentation repository. For the PSModule organization, this repository is the source of truth.

## Repository creation

Create new module repositories from [`PSModule/Template-PSModule`](https://github.com/PSModule/Template-PSModule). The template provides the framework wiring, starter layout, and CI/CD expectations.

After creating the repository:

1. Replace template tokens such as `{{ NAME }}` and `{{ DESCRIPTION }}`.
2. Remove scaffold functions, tests, and examples that do not represent the module.
3. Set repository metadata and custom properties.
4. Confirm the README reflects the module's actual status and uses `Install-PSResource` for installation.
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
| `README.md` | Concise landing page for the repository. |
| `LICENSE` | Repository license. PSModule module repositories default to MIT unless a different license is explicitly decided. |
| `CONTRIBUTING.md` | Contribution workflow or a repository-level pointer to the organization contribution guide. |
| `SECURITY.md` | Security support policy and private vulnerability reporting instructions. |
| `SUPPORT.md` | Support expectations and where users ask for help. |
| `CODE_OF_CONDUCT.md` | Community conduct expectations. |
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
| `CONTRIBUTING.md` | Shared contribution workflow and expectations. |
| `SECURITY.md` | Private vulnerability reporting and latest-version support policy. |
| `SUPPORT.md` | Support channel and issue-routing expectations. |
| `CODE_OF_CONDUCT.md` | Community participation rules. |
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
- **Mandatory file sets** should allow organization-critical files such as `SECURITY.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, and supply-chain configuration to be pushed to applicable repositories without each repository having to subscribe manually.

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

Dependabot PRs still go through normal review. Automated dependency updates are not a substitute for reviewing release notes, changed permissions, pinned SHAs, or generated lock files.

## README default

A module README is a landing page, not the command reference. It should help a user identify the module, install it, and find generated documentation.

Module installation examples must use PSResourceGet:

```powershell
Install-PSResource -Name <ModuleName>
```

Do not use `Install-Module` in new module repository documentation. `Install-Module` belongs only in legacy/historical context where changing it would misrepresent the referenced system.

For implemented modules, use this shape:

````markdown
# <ModuleName>

<One short paragraph describing the module from the user's perspective.>

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name <ModuleName>
Import-Module -Name <ModuleName>
```

## Documentation

Documentation is published at [psmodule.io/<ModuleName>](https://psmodule.io/<ModuleName>/).

Use PowerShell help and command discovery for module details:

```powershell
Get-Command -Module <ModuleName>
Get-Help -Name 'CommandName' -Examples
```

## Contributing

Issues and pull requests are welcome. Please use the repository issue tracker to report bugs, request features, or discuss improvements.
````

README pages should not duplicate generated command documentation. Do not add full command inventories, parameter tables, or long usage sections when those details are already produced from comment-based help.

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

## Contributing

Issues and pull requests are welcome when implementation work begins.
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
Select-String -Path README.md -Pattern '^## (Usage|Commands|Examples)$'
git diff --check -- README.md
```

`Template-PSModule` is the exception: it intentionally keeps `{{ NAME }}` and `{{ DESCRIPTION }}` tokens because those are template inputs.

## Documentation ownership

Command details belong in comment-based help and generated documentation. The README points to those sources instead of re-stating them.

Use these defaults:

- Command synopsis, parameters, examples, links, and outputs live in comment-based help.
- Group overview pages live next to public command groups in `src/functions/public/<Group>/<Group>.md`.
- Realistic end-to-end scenarios live in `examples/`.
- README pages stay short and stable.

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
