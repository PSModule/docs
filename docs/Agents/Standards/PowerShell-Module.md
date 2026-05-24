# PowerShell Module Standard

Standards for implementing and reviewing PowerShell modules in the PSModule organization. These rules apply to modules built with the [PSModule framework](https://github.com/PSModule/PSModule).

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
| `src/scripts/*.ps1`                           | Scripts loaded via the manifest into caller scope                         | Normal module-internal code                              |
| `src/finally.ps1`                             | End-of-module wiring (removal handlers, etc.)                             | Per-call logic                                           |
| `examples/*.ps1`                              | Realistic user scenarios                                                  | Substitutes for comment-based help examples              |
| `tests/`                                      | Pester tests and test data                                                | Generated test results or build output                   |

Layout rules:

- **One declaration per file.** Filename matches the declared symbol exactly, including casing.
- **Group by domain.** Use resource or behaviour groups — not verb folders, not endpoint paths.
- **Mirror public and private domains.** Public command under `src/functions/public/Projects/` has related private helpers under `src/functions/private/Projects/`.

## Naming

### Functions and filters

- Use approved PowerShell verbs (`Get-Verb`).
- Use singular PascalCase nouns prefixed with the module's term of art.
- Name commands after objects, not lookup mechanisms. `Get-ContosoProject -ID 42`, not `Get-ContosoProjectByID`.
- Public aliases only when they preserve compatibility or bridge terminology. Private functions and parameters have no aliases.
- Use `filter` only for pure pipeline transforms. Use `function` with `begin` / `process` / `end` when setup or cleanup is needed.

### Parameters

- PascalCase, full words.
- Convert external `snake_case` to PascalCase.
- Avoid repeating the noun: `-ID` not `-ProjectID` in `Get-ContosoProject`.
- Same parameter name for the same concept across the module.
- Positive switches: `-Force`, `-Recurse`, `-PassThru`.

### Variables

- camelCase for locals, PascalCase for parameters.
- Full names: `$projectResponse`, `$requestBody`, `$normalizedPath`, `$apiUri`.
- No Hungarian prefixes (`$strName`, `$intCount`).
- No `$temp`, `$data`, `$result`, `$obj` as final names.
- Splats named after the call they feed: `$getProjectSplat`, `$invokeApiSplat`.

### Classes and enums

- PascalCase + module prefix: `ContosoProject`, `ContosoProjectState`.
- Singular enums.
- PascalCase properties. Boolean properties start with `Is`, `Has`, or `Can`.
- Sizes in bytes in a property named `Size`.
- Optional timestamps use `[System.Nullable[datetime]]`.

### Files

- Filename equals symbol name plus extension: `Get-ContosoProject.ps1`, `ContosoProject.ps1`, `ContosoProject.Types.ps1xml`.
- Casing matches the declared symbol.

## Style

- **Lowercase keywords:** `function`, `filter`, `param`, `begin`, `process`, `end`, `if`, `else`, `elseif`, `switch`, `foreach`, `for`, `while`, `do`, `return`, `throw`, `try`, `catch`, `finally`.
- **One True Brace Style.** Opening brace on the same line; closing brace on its own line; `else` / `elseif` / `catch` / `finally` on the line with the preceding closing brace.
- **4-space indentation, no tabs.**
- **Line length** — max 150 characters (PSScriptAnalyzer `PSAvoidLongLines`).
- **Always include `param()`**, even when empty.
- **Type every parameter and class property.**
- `[CmdletBinding()]` on functions. `[CmdletBinding(SupportsShouldProcess)]` only on commands that mutate state (create, update, remove, copy, install, publish). **Never** on `Get-`, `Test-`, `Resolve-`, `ConvertTo-`, `ConvertFrom-`.
- `[OutputType()]` on public functions, with the most specific type.
- `begin` / `process` / `end` blocks on public commands.
- Suppress output with `$null = <expression>`, not `| Out-Null`.
- No `Write-Host` in module code. Use `Write-Verbose`, `Write-Debug`, `Write-Information`.
- Respect caller preferences — don't force `-Verbose:$true` inside the module.
- Use `try` / `catch` only when adding value (translation, enrichment, cleanup).
- String emptiness: `-not $Param`, never `[string]::IsNullOrEmpty(...)`.

## Public function structure

1. Comment-based help (see below).
2. `[OutputType([T])]`.
3. `[CmdletBinding(...)]` with `DefaultParameterSetName` when multiple sets exist.
4. Documented, typed, attribute-ordered `param()` block.
5. `begin` — initialize shared state, resolve context, validate.
6. `process` — process pipeline input, call private helpers.
7. `end` — cleanup.

Parameter attribute order (each on its own line):

1. `[Parameter(...)]` — one per parameter set.
2. Validation attributes — `[ValidateNotNullOrEmpty()]`, `[ValidateSet()]`, `[ValidateRange()]`, etc.
3. `[ArgumentCompleter(...)]`.
4. `[Alias(...)]`.
5. Typed declaration: `[string] $Name`.

Parameter sets:

- Single mode → no named set, no `DefaultParameterSetName`.
- Multiple modes → every set has an intent-revealing name (`'List projects'`, `'Get a project by name'`). Never `'Default'`, `'ByID'`, `'__AllParameterSets'`.
- Set `DefaultParameterSetName` to the most common user intent.

## Private functions

- Mandatory `[GitHubContext] $Context` (or equivalent for the module).
- No aliases.
- No pipeline input.
- No defaulting from context — public callers resolve before calling.
- Required inputs declared as mandatory.

## Comment-based help

Required public help, in order:

1. `.SYNOPSIS` — one sentence in imperative mood.
2. `.DESCRIPTION` — one short paragraph per behaviour or parameter set.
3. `.EXAMPLE` — at least one per public behaviour or parameter set.
4. `.INPUTS` — pipeline input type names.
5. `.OUTPUTS` — matches `[OutputType()]`.
6. `.NOTES` — implementation, permissions, upstream reference notes.
7. `.LINK` — generated repository docs page first, then upstream references. URL pattern: `https://psmodule.io/<RepoName>/Functions/<Group>/<Command>/`.

Parameter descriptions are **one-line `#` comments above each parameter** inside `param()`, not `.PARAMETER` blocks.

## SOLID applied

- **Single Responsibility.** One file, one function. One function, one user-visible behaviour. If the synopsis needs "and", split it.
- **Open/Closed.** Extend via parameter sets, private helpers, or new files — not boolean switches that fork large blocks.
- **Liskov.** A derived class must work wherever the base is expected.
- **Interface Segregation.** Narrow, intent-named parameter sets.
- **Dependency Inversion.** Public functions depend on resolved inputs and local abstractions. Private helpers own the concrete REST / GraphQL / filesystem / process calls.

## DRY with judgment

Extract a helper after the same non-trivial logic appears in three or more places, or when duplicated logic is load-bearing. Don't create a helper for a single caller.

## Tests

- Pester tests under `tests/`.
- Filenames: `<ModuleName>.Tests.ps1` or `<Function>.Tests.ps1`.
- One test file per public command for unit tests; integration tests grouped by scenario.
- Tests run against the dot-sourced source files, not against an installed module — see [PSModule Test Specification](https://psmodule.io/docs/PowerShell-Modules/Test-Specification/).
