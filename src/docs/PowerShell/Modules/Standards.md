# PowerShell module standard

Standards for implementing and reviewing PowerShell modules in the PSModule organization. These rules apply to modules built with the [PSModule framework](https://github.com/PSModule/PSModule).

For general PowerShell coding standards (naming, style, function structure, documentation, readability, error handling), see [PowerShell Standards](../Standard/index.md). This page covers only module-specific conventions.

> **Repo-local config wins.** Repo-level `PSScriptAnalyzerSettings.psd1`, `.github/linters/.powershell-psscriptanalyzer.psd1`, and equivalent local rules override anything below. This standard fills the gap.

## Repository layout

The framework treats `src/` as the source for the compiled module. Place code in the folder that matches its responsibility.

| Folder or file                                | Purpose                                                                   | Do not put here                                          |
| --------------------------------------------- | ------------------------------------------------------------------------- | -------------------------------------------------------- |
| `src/header.ps1`                              | Single comment block at the top of the compiled module                    | Runtime code                                             |
| `src/manifest.psd1`                           | Intentional manifest overrides                                            | Generated values (functions, types, version, GUID, etc.) |
| `src/data/*.psd1`                             | Static read-only configuration                                            | Mutable state, secrets, computed values                  |
| `src/init/*.ps1`                              | Code that runs once at import (module-scope init, completer registration) | Per-call logic, network calls, slow work                 |
| `src/classes/private/*.ps1`                   | Internal classes                                                          | Public pipeline output types                             |
| `src/classes/public/*.ps1`                    | Classes returned to users or accepted as parameter types                  | Transport wrappers with no user-facing model             |
| `src/enums/*.ps1`                             | Enums for class properties, parameters, validation                        | Configuration constants                                  |
| `src/types/<TypeName>.Types.ps1xml`           | Type metadata — aliases, script properties, member sets                   | Display views or duplicated class properties             |
| `src/formats/<TypeName>.Format.ps1xml`        | Default table / list / wide display views                                 | Behavior, business logic, type aliases                   |
| `src/functions/private/<Group>/Verb-Noun.ps1` | One private helper per file, grouped by domain                            | Public aliases, pipeline input, context defaulting       |
| `src/functions/public/<Group>/Verb-Noun.ps1`  | One exported command per file, grouped by resource or domain              | Raw transport code, multiple commands per file           |
| `src/assemblies/`                             | Bundled binaries copied into the build artifact                           | Source-compiled code                                     |
| `src/modules/`                                | Nested modules packaged with the compiled output                          | Functions that belong in `src/functions/`                |
| `src/variables/private/*.ps1`                 | Module-scoped variables not exported                                      | Public API values                                        |
| `src/variables/public/*.ps1`                  | Variables exported and documented                                         | Computed or mutable state                                |
| `src/scripts/*.ps1`                           | Scripts loaded via the manifest into caller scope                         | Normal module-internal code                              |
| `src/finally.ps1`                             | End-of-module wiring (removal handlers, etc.)                             | Per-call logic                                           |
| `examples/*.ps1`                              | Realistic user scenarios                                                  | Substitutes for comment-based help examples              |
| `icon/icon.png`                               | Module icon linked from manifest and documentation                        | Source code or configuration                             |
| `tests/`                                      | Pester tests and test data                                                | Generated test results or build output                   |
| `tests/BeforeAll.ps1`                         | Shared setup script executed once before the test matrix                  | Per-test setup                                           |
| `tests/AfterAll.ps1`                          | Shared teardown script executed once after the test matrix                | Per-test teardown                                        |

Layout rules:

- **One declaration per file.** Filename matches the declared symbol exactly, including casing.
- **Group by domain.** Use resource or behaviour groups — not verb folders, not endpoint paths.
- **Mirror public and private domains.** Public command under `src/functions/public/Projects/` has related private helpers under `src/functions/private/Projects/`.
- **Declare dependencies where they are used.** Use `#Requires -Modules <Name>` at the top of each function file that needs an external module. Do not add `RequiredModules` to `src/manifest.psd1` — the build collects all `#Requires` declarations automatically and writes them into the compiled manifest. Entries in `src/manifest.psd1` are silently ignored for this purpose.
- **Group documentation pages with source.** Place a `<Group>.md` file alongside the function files in each `src/functions/public/<Group>/` folder to provide a category overview in generated documentation.

## Module naming

- Prefix public nouns with the module's term of art: `ContosoProject`, not `Project`.
- Public aliases only when they preserve compatibility or bridge terminology. Private functions and parameters have no aliases.

## Private functions

- Mandatory context parameter (e.g., `[GitHubContext] $Context`) or equivalent for the module.
- No aliases.
- No pipeline input.
- No defaulting from context — public callers resolve before calling.
- Required inputs declared as mandatory.

## SOLID applied

- **Single Responsibility.** One file, one function. One function, one user-visible behaviour. If the synopsis needs "and", split it.
- **Open/Closed.** Extend via parameter sets, private helpers, or new files — not boolean switches that fork large blocks.
- **Liskov.** A derived class must work wherever the base is expected.
- **Interface Segregation.** Narrow, intent-named parameter sets.
- **Dependency Inversion.** Public functions depend on resolved inputs and local abstractions. Private helpers own the concrete REST / GraphQL / filesystem / process calls.

## Parameter design

### Smart defaults

Every parameter that has a natural default should declare one. The most common use case must work with the fewest parameters possible. Reserve `Mandatory` for values the command genuinely cannot infer or derive.

- Prefer `= 'main'` over making `-Branch` mandatory in commands that act on branches.
- Prefer sensible page sizes, counts, or ranges over requiring callers to specify them.
- Prefer `= $false` for switches rather than leaving the behaviour implicit.

This is a usability expression of the **Open/Closed** principle: the common path is open by default; callers that need different behaviour extend it by supplying alternatives — they are never forced to know the default just to get started.

### Object-first parameters

Parameters represent attributes of a real-world entity. Design them to reflect that structure.

- **Prefer typed objects.** If a concept has a class — `[GitHubRepo]`, `[GitHubContext]`, `[ContosoProject]` — accept the object rather than its constituent fields. The caller can pass the whole thing; the implementation unpacks what it needs.
- **Group flat parameters by their conceptual object.** When a typed object is not available, prefix each parameter with the name of the entity it belongs to: `$ServerHost`, `$ServerPort`, `$ServerTls` rather than `$Host`, `$Port`, `$Tls`. The prefix makes the grouping explicit, prevents collisions with unrelated parameters, and avoids shadowing PowerShell built-in variables (`$Host`).
- **Offer both modes when callers need both.** A parameter set that accepts an object and a parallel parameter set that accepts its individual attributes are equally valid; use both when that genuinely serves users.

This mirrors **Interface Segregation**: each parameter set represents one coherent input contract — not a flat list of loosely related knobs — so callers only touch what they need.

> Note: the rule "avoid repeating the noun" (e.g. `-ID` not `-ProjectID` in `Get-ContosoProject`) applies to a command's *own* noun. The object-prefix convention above applies when a single command spans *multiple* conceptual objects (`$ServerHost` vs `$ClientID`) — the prefix is the object name, not the command noun, so there is no conflict.

## DRY with judgment

Extract a helper after the same non-trivial logic appears in three or more places, or when duplicated logic is load-bearing. Don't create a helper for a single caller.

## Principles

### Colocation of concerns

Keep related things together so the connection between code and its context is visible at a glance:

- `#Requires -Modules` belongs in the function files that use the dependency, not in a central manifest.
- Parameter descriptions are `#` comments directly above each parameter in `param()`, not `.PARAMETER` blocks.
- Tests for a public function live alongside it, not in a separate unrelated folder.

### Linear versioning

The release process treats each merged PR as a release on a single linear ancestry. There is no patching of older versions — security fixes go on the current tip of `main` only.

### Release and feature branches

For large work, open a release branch and target it from feature branches. Apply the `Prerelease` label on the release branch PR to publish preview versions before the final merge to `main`.

## Tests

- Pester tests under `tests/`.
- Filenames: `<ModuleName>.Tests.ps1` or `<Function>.Tests.ps1`.
- One test file per public command for unit tests; integration tests grouped by scenario.
- Tests run against the dot-sourced source files, not against an installed module — see [PSModule Test Specification](https://psmodule.io/docs/PowerShell-Modules/Test-Specification/).

### Shared test infrastructure

Tests run in parallel across multiple OS runners. Provision shared infrastructure once rather than inside each test file:

- `tests/BeforeAll.ps1` — runs once before the full test matrix. Create shared resources here.
- `tests/AfterAll.ps1` — runs once after the full test matrix. Remove shared resources here.

Use `$env:GITHUB_RUN_ID` (stable per workflow run, shared across all runners) for deterministic resource names:

```powershell
$resourceName = "Test-$($env:RUNNER_OS)-$($env:GITHUB_RUN_ID)"
```

Do not use `[guid]::NewGuid()` or `Get-Random` for shared names — these produce different values on each runner. Clean up stale resources at the start of `BeforeAll.ps1` before creating new ones.

### Enforced framework tests

The CI pipeline automatically tests every source file against the following rules. Violations fail the build:

| Test ID | Rule |
| ------- | ---- |
| `NumberOfProcessors` | Use `[System.Environment]::ProcessorCount`, not `$env:NUMBER_OF_PROCESSORS` |
| `Verbose` | Do not pass `-Verbose` to commands unless explicitly silenced with `-Verbose:$false` |
| `OutNull` | Use `$null = ...` instead of `\| Out-Null` |
| `NoTernary` | No ternary operators — maintain PowerShell 5.1 compatibility |
| `LowercaseKeywords` | All PowerShell keywords must be lowercase |
| `FunctionCount` | Each file must contain exactly one function or filter |
| `FunctionName` | Filename must match the function or filter name |
| `CmdletBinding` | Every function must have `[CmdletBinding()]` |
| `ParamBlock` | Every function must have a `param()` block |
| `FunctionTest` | Every public function must have a corresponding test |

To skip a specific rule for one file only, add a comment at the very top of that file:

```powershell
#SkipTest:<TestID>:<Reason>
```

Use skip comments sparingly and always include a meaningful reason. Prefer refactoring to comply over skipping.
