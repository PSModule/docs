# Naming

## Functions and cmdlets

**Practice:** `Verb-Noun` PascalCase. Approved verbs only (see `Get-Verb`). Singular nouns. Name commands after objects, not lookup mechanisms. Use `filter` only for pure pipeline transforms; use `function` with `begin`/`process`/`end` when setup or cleanup is needed.

**Why:** Approved verbs make commands discoverable and predictable to any caller — human or agent (*Clean Code*). Discoverable naming is how we *make it easy* for others to do more, faster.

**How:**

```powershell
# Good
function Get-UserProfile { }
function Set-ConfigValue { }
function Remove-TempFile { }
Get-ContosoProject -ID 42              # Named after the object
```

```powershell
# Bad
function GetUser { }                   # Missing hyphen
function get-user { }                  # Wrong case
function Do-Something { }             # Unapproved verb
function Get-Users { }                # Plural noun
function Get-ContosoProjectByID { }   # Named after lookup mechanism
```

## Use full command names

**Practice:** Always use the full `Verb-Noun` command name. Never use aliases in scripts or shared code.

**Why:** Not everyone knows the same aliases — `ls`, `dir`, `gci` all mean `Get-ChildItem`. Full names are unambiguous for every reader — including agents and contributors from other platforms (*Build for all developers*, *Clean Code*).

**How:**

```powershell
# Good
Get-Process -Name Explorer
Get-ChildItem -Path $root
ForEach-Object { $_.Name }
```

```powershell
# Bad
gps -Name Explorer
gci $root
% { $_.Name }
```

## Use full parameter names

**Practice:** Always spell out parameter names explicitly. Do not rely on positional binding or abbreviation.

**Why:** Explicit parameters make scripts self-documenting and resilient to future parameter-set changes. Readers unfamiliar with the command immediately understand what each argument means (*Clean Code*, *Human–agent coexistence*).

**How:**

```powershell
# Good
Get-Process -Name Explorer
Get-Content -Path $file -TotalCount 10
```

```powershell
# Bad
Get-Process Explorer              # Positional — unclear which parameter
Get-Content $file -Tot 10         # Abbreviated — fragile if params change
```

## Parameters and variables

**Practice:** PascalCase for parameters and public variables. camelCase for local variables. Full words, no abbreviations. Convert external `snake_case` to PascalCase. Avoid repeating the command noun in parameter names. Use the same parameter name for the same concept across a module. Prefix booleans with `is`, `has`, or `should`. Positive switches: `-Force`, `-Recurse`, `-PassThru`. Never shadow automatic variables. Name splats after the call they feed.

**Why:** Consistent casing communicates scope at a glance (*Clean Code*). Boolean prefixes eliminate guessing. Shadowing automatic variables (`$Error`, `$Args`) causes subtle bugs — catching these at write time is cheaper than in production (*Shift Left*).

**How:**

```powershell
# Good
$userName = 'John'
$isValid = $true
$hasPermission = $false
$getProjectSplat = @{ Name = 'Contoso' }

param(
    [string] $ConfigPath,
    [switch] $Force
)

# In Get-ContosoProject, use -ID not -ProjectID
function Get-ContosoProject {
    param([int] $ID)
}
```

```powershell
# Bad
$usr = 'John'          # Too abbreviated
$valid = $true         # Should be $isValid
$TOTAL_COUNT = 0       # Wrong case style
$temp = Get-Item .     # Meaningless name
$data = @{}            # Meaningless name
```

## Constants

**Practice:** PascalCase. Mark with `Set-Variable -Option ReadOnly`.

**Why:** Read-only marking turns a silent logic error into a visible failure at the earliest moment (*Shift Left*). Constants make intent explicit for anyone reading the code (*Write it down*).

**How:**

```powershell
# Good
Set-Variable -Name MaxRetries -Value 3 -Option ReadOnly
Set-Variable -Name DefaultTimeout -Value 30 -Option ReadOnly
```

## Classes and enums

**Practice:** PascalCase for class and enum names. Singular enum names. PascalCase for properties. Boolean properties start with `Is`, `Has`, or `Can`. Sizes in bytes in a property named `Size`. Optional timestamps use `[System.Nullable[datetime]]`.

**Why:** Consistent casing across types makes the API predictable. Singular enum names align with .NET conventions and read naturally in parameter declarations (*Clean Code*).

**How:**

```powershell
# Good
class ContosoProject {
    [string] $Name
    [bool] $IsActive
    [int] $Size
    [System.Nullable[datetime]] $ArchivedAt
}

enum ContosoProjectState {
    Active
    Archived
    Deleted
}
```

```powershell
# Bad
class contoso_project { }         # Wrong casing
enum ProjectStates { }            # Plural
```

## File naming

**Practice:** Filename equals the declared symbol name plus extension. Casing matches the declared symbol.

**Why:** Predictable file naming enables tooling and humans to locate symbols instantly without searching (*Make change easy*). A 1:1 mapping between file and symbol eliminates ambiguity.

**How:**

```powershell
# Good
# Get-ContosoProject.ps1   → contains function Get-ContosoProject
# ContosoProject.ps1       → contains class ContosoProject
# ContosoProject.Types.ps1xml → type extensions for ContosoProject
```

```powershell
# Bad
# helpers.ps1              → unclear what's inside
# get-project.ps1          → casing doesn't match function name
```

## Use explicit paths

**Practice:** Use `$PSScriptRoot`-based or absolute paths. Avoid relative paths (`.`, `..`) and `~`.

**Why:** Relative paths depend on the current location and break when called from .NET methods or other contexts. `~` depends on the current provider and can error unexpectedly. Explicit paths produce deterministic results across all platforms (*Build for all developers*, *Determinism before intelligence*).

**How:**

```powershell
# Good
$configPath = Join-Path -Path $PSScriptRoot -ChildPath 'config.json'
Get-Content -Path $configPath
```

```powershell
# Bad
Get-Content .\config.json                    # Relative — depends on $PWD
Get-Content ~\config.json                    # Provider-dependent
[System.IO.File]::ReadAllText('.\data.txt')  # .NET uses a different working directory
```
