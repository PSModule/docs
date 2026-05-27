# PowerShell standards

These standards apply to all PowerShell files across PSModule repositories. They implement the
engineering principles defined in [Principles](../Ways-of-Working/Principles.md) — specifically
*Clean Code*, *Make change easy*, *Shift Left*, and *Build for the modern engineer*.

Each standard states the practice, why it matters to us, and how to apply it.

---

## Code layout

### Brace style (OTBS)

**Practice:** Opening braces on the same line as the statement. Closing braces on their own line. Always use braces, even for single-statement blocks.

**Why:** Consistent braces make diffs single-line and prevent the PowerShell parser quirk where a newline before `{` silently breaks constructs. Adding a statement later cannot introduce a logic bug when braces are always present (*Make change easy*).

**How:**

```powershell
# Good
function Get-Example {
    if ($Name) {
        Write-Output "Hello, $Name"
    } else {
        Write-Output 'Hello, World'
    }
}
```

```powershell
# Bad
function Get-Example
{                                          # Brace must be on same line
}

if ($condition)
    Write-Output 'Missing braces'          # Always use braces
```

### Indentation and whitespace

**Practice:** 4-space indentation (no tabs). One space around operators and after commas. No trailing whitespace. One blank line between logical blocks. Files end with a single newline.

**Why:** Reviewers — human and agent — should focus on behaviour, not formatting (*4-eyes principle*). Mechanical consistency removes noise from diffs, keeping structural and behavioural changes visibly separate (*Make change easy*).

**How:**

```powershell
# Good
$value = Get-Something -Name 'Test'

foreach ($item in $Items) {
    $processed = Format-Item $item
}
```

```powershell
# Bad
$value=Get-Something -Name 'Test'
foreach($item in $Items){
$processed=Format-Item $item}
```

### Line length

**Practice:** Wrap at 115 characters. Prefer splatting or natural line breaks (after commas, pipes) over backtick continuations.

**Why:** Backtick continuation is fragile — a trailing space silently breaks it and the bug is invisible in most editors. Splatting achieves the same result deterministically (*Determinism before intelligence*) and diffs cleanly (*Make change easy*).

**How:**

```powershell
# Good — splatting
$params = @{
    Path        = 'C:\Temp'
    Filter      = '*.txt'
    Recurse     = $true
    ErrorAction = 'Stop'
}
Get-ChildItem @params

# Good — natural break after pipe
Get-ChildItem -Path $root |
    Where-Object { $_.Length -gt 1MB }
```

```powershell
# Bad — backtick continuation
Get-ChildItem -Path 'C:\Temp' `
    -Filter '*.txt' `
    -Recurse
```

### Avoid semicolons as line terminators

**Practice:** Do not use `;` to terminate lines or separate statements within a line. One statement per line.

**Why:** Semicolons are unnecessary in PowerShell and produce noisy edits when someone later removes them. One statement per line makes diffs atomic and readable (*Make change easy*).

**How:**

```powershell
# Good
$name = 'John'
$age = 30

$hashtable = @{
    Name = 'John'
    Age  = 30
}
```

```powershell
# Bad
$name = 'John'; $age = 30

$hashtable = @{ Name = 'John'; Age = 30 }
```

### Regions

**Practice:** Use `#region`/`#endregion` to mark logical sections. Label every region.

**Why:** Regions create named, collapsible blocks in VS Code without premature file-splitting (*DRY — with judgment*). Labels double as in-file documentation (*Documentation lives close to the thing it documents*).

**How:**

```powershell
# Good
#region Input validation
if (-not (Test-Path $ConfigPath)) {
    throw "Config not found: $ConfigPath"
}
#endregion Input validation

#region Helper functions
function Get-ConfigData { }
function New-UserAccount { }
#endregion Helper functions
```

```powershell
# Bad
#region
function Get-ConfigData { }   # Unlabelled — useless for navigation
#endregion
```

---

## Naming

### Functions and cmdlets

**Practice:** `Verb-Noun` PascalCase. Approved verbs only (see `Get-Verb`). Singular nouns.

**Why:** Approved verbs make commands discoverable and predictable to any caller — human or agent (*Clean Code*). Discoverable naming is how we *make it easy* for others to do more, faster.

**How:**

```powershell
# Good
function Get-UserProfile { }
function Set-ConfigValue { }
function Remove-TempFile { }
```

```powershell
# Bad
function GetUser { }          # Missing hyphen
function get-user { }         # Wrong case
function Do-Something { }     # Unapproved verb
function Get-Users { }        # Plural noun
```

### Use full command names

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

### Use full parameter names

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

### Parameters and variables

**Practice:** PascalCase for parameters and public variables. camelCase for local variables. Prefix booleans with `is`, `has`, or `should`. Never shadow automatic variables.

**Why:** Consistent casing communicates scope at a glance (*Clean Code*). Boolean prefixes eliminate guessing. Shadowing automatic variables (`$Error`, `$Args`) causes subtle bugs — catching these at write time is cheaper than in production (*Shift Left*).

**How:**

```powershell
# Good
$userName = 'John'
$isValid = $true
$hasPermission = $false

param(
    [string] $ConfigPath,
    [switch] $Force
)
```

```powershell
# Bad
$usr = 'John'          # Too abbreviated
$valid = $true         # Should be $isValid
$TOTAL_COUNT = 0       # Wrong case style
```

### Constants

**Practice:** PascalCase. Mark with `Set-Variable -Option ReadOnly`.

**Why:** Read-only marking turns a silent logic error into a visible failure at the earliest moment (*Shift Left*). Constants make intent explicit for anyone reading the code (*Write it down*).

**How:**

```powershell
# Good
Set-Variable -Name MaxRetries -Value 3 -Option ReadOnly
Set-Variable -Name DefaultTimeout -Value 30 -Option ReadOnly
```

### Use explicit paths

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

---

## Function structure

### Always use CmdletBinding

**Practice:** Every function must have `[CmdletBinding()]`, `[OutputType()]`, and a typed `param()` block with validation attributes. Mandatory parameters first. Use `[switch]` for boolean flags.

**Why:** `CmdletBinding` gives `-Verbose`, `-WhatIf`, and common parameters for free — features users expect from a well-built product (*Product mindset*). Validation attributes reject bad input at the boundary, not deep in the call stack (*Shift Left*). Typed parameters are self-documenting for agents (*Human–agent coexistence*).

**How:**

```powershell
# Good
function Get-UserData {
    [OutputType([PSCustomObject])]
    [CmdletBinding()]
    param(
        # The unique identifier of the user.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $UserId,

        # Include deleted users in the results.
        [Parameter()]
        [switch] $IncludeDeleted
    )

    process { }
}
```

```powershell
# Bad
function Get-UserData($id, $del) {
    # No CmdletBinding, no types, unclear names
}
```

### Pipeline design

**Practice:** Functions that process collections should accept pipeline input via `ValueFromPipeline` and implement `begin`/`process`/`end` blocks.

**Why:** Pipeline-aware functions compose with the ecosystem — streaming data without loading entire collections into memory. This follows *Open/Closed*: extend by composing, not modifying. Users expect commands to work naturally in a pipeline (*Product mindset*).

**How:**

```powershell
# Good
function Update-Item {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $Item
    )

    begin { $count = 0 }

    process {
        $Item.LastModified = Get-Date
        $count++
        Write-Output $Item
    }

    end { Write-Verbose "Processed $count items" }
}

$items | Update-Item
```

### Script structure

**Practice:** `#Requires` → comment-based help → `param()` → variables → functions → execution in `try`/`catch`.

**Why:** `#Requires` fails fast on incompatible environments (*Shift Left*). Consistent ordering means agents can reliably parse and generate scripts (*Human–agent coexistence*). A top-level `try`/`catch` prevents partial runs.

**How:**

```powershell
# Good
#Requires -Version 7.4

[CmdletBinding()]
param(
    [string] $ConfigPath = '.\config.json'
)

$ErrorActionPreference = 'Stop'

#region Helper functions
function Get-ConfigData {
    param([string] $Path)
}
#endregion Helper functions

try {
    $config = Get-ConfigData -Path $ConfigPath
} catch {
    Write-Error "Script failed: $_"
    exit 1
}
```

---

## Documentation and comments

**Practice:** Comment-based help goes first inside the function body. Use inline comments above each parameter (not `.PARAMETER`). Comments explain *why*, not *what*.

**Why:** Documentation lives close to the thing it documents (*Principles*). Help inside the body ensures `Get-Help` always finds it and makes it collapsible in VS Code. Explaining *why* preserves context that code alone cannot express — this is how knowledge becomes shared (*Write it down*, *Context-first development*).

**How:**

```powershell
# Good
function New-UserAccount {
<#
    .SYNOPSIS
    Creates a new user account.

    .DESCRIPTION
    Creates a new user account with the specified username and email.

    .EXAMPLE
    New-UserAccount -UserName 'jdoe' -Email 'jdoe@example.com'

    .LINK
    https://example.com/docs/New-UserAccount
#>
    [CmdletBinding()]
    param(
        # The username for the new account.
        [Parameter(Mandatory)]
        [string] $UserName,

        # The email address for the new account.
        [Parameter(Mandatory)]
        [string] $Email
    )

    # Validate before hitting the database — fail fast
    if ($Email -notmatch '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') {
        throw "Invalid email format: $Email"
    }
}
```

```powershell
# Bad
function New-UserAccount {
    param($UserName, $Email)
    # Check email                          # States "what", not "why"
    if ($Email -notmatch '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') { throw 'Invalid' }
}
```

---

## Readability

### String handling

**Practice:** Single quotes for literals. Double quotes only for expansion. Here-strings for multi-line. `-f` operator for formatting.

**Why:** Single-quoted strings are literal — no accidental variable expansion. Choosing the correct quote style makes intent explicit at write time (*Shift Left*, *Clean Code*).

**How:**

```powershell
# Good
$name     = 'John'
$greeting = "Hello, $name"
$path     = 'C:\Temp\file.txt'
$message  = 'The value is: {0}' -f $value
```

```powershell
# Bad
$name     = "John"                         # No expansion needed — use single quotes
$greeting = 'Hello, $name'                 # Variable will not expand
$message  = 'The value is: ' + $value      # Use -f operator
```

### Comparison operators

**Practice:** Use PowerShell operators (`-eq`, `-ne`, `-gt`, `-contains`). Place `$null` on the left of null checks.

**Why:** C-style operators silently produce wrong results. `$null -eq $collection` is safe even when `$collection` is an array. Bugs surface at write time, not in production (*Shift Left*).

**How:**

```powershell
# Good
if ($value -eq 10) { }
if ($list -contains $item) { }
if ($null -eq $collection) { }          # Safe for arrays
```

```powershell
# Bad
if ($value == 10) { }                   # Not a PowerShell operator
if ($list -eq $item) { }               # Use -contains
if ($collection -eq $null) { }         # Unsafe on arrays
```

### Splatting

**Practice:** Use splatting when a call has more than two or three parameters.

**Why:** Long parameter lines are hard to diff and review (*4-eyes principle*). Splatting makes parameters easy to add or remove in isolation (*Make change easy*).

**How:**

```powershell
# Good
$params = @{
    Path        = 'C:\Temp'
    Filter      = '*.txt'
    Recurse     = $true
    ErrorAction = 'Stop'
}
Get-ChildItem @params
```

```powershell
# Bad
Get-ChildItem -Path 'C:\Temp' -Filter '*.txt' -Recurse $true -ErrorAction 'Stop'
```

### Arrays and hashtables

**Practice:** Use `@()` for arrays, `@{}` for hashtables. One item per line in multi-line collections. Align hashtable values.

**Why:** Explicit syntax makes intent clear (*Clean Code*). One item per line produces single-line diffs (*Make change easy*).

**How:**

```powershell
# Good
$items = @(
    'First'
    'Second'
    'Third'
)

$config = @{
    Name = 'John'
    Age  = 30
}
```

```powershell
# Bad
$items = 'First', 'Second', 'Third'
$config = @{Name = 'John'; Age = 30}
```

---

## Control flow

### If/else

**Practice:** Always use braces. `elseif` (one word). One space before `{`. Break complex conditions across lines.

**Why:** Missing braces cause logic bugs when lines are added later (*Make change easy*). `elseif` is idiomatic PowerShell.

**How:**

```powershell
# Good
if ($condition) {
    Do-Something
} elseif ($otherCondition) {
    Do-SomethingElse
} else {
    Do-Default
}
```

```powershell
# Bad
if ($condition)
{                                         # Brace on wrong line
    Do-Something
}

if ($condition) Do-Something              # Missing braces
```

### Loops

**Practice:** Prefer `foreach` over `for` when the index is not needed. Always use braces.

**Why:** `foreach` reads like prose and avoids off-by-one errors (*Clean Code*). Braces protect against accidental modification (*Make change easy*).

**How:**

```powershell
# Good
foreach ($item in $collection) {
    Process-Item $item
}
```

```powershell
# Bad
foreach ($item in $collection) Process-Item $item  # Missing braces
```

### Switch statements

**Practice:** Opening brace on same line. Case blocks indented 4 spaces. Always include `default`.

**Why:** A `default` case makes it explicit that unmatched values are handled intentionally. Unhandled cases are silent failures (*Shift Left*).

**How:**

```powershell
# Good
switch ($value) {
    'Option1' { Do-FirstThing }
    'Option2' { Do-SecondThing }
    default   { Do-DefaultThing }
}
```

---

## Output and error handling

### Output streams

**Practice:** `Write-Output` for return values. Never `Write-Host`. Use `Write-Verbose`, `Write-Warning`, `Write-Error`, `Write-Information` for their respective purposes.

**Why:** Each stream has one job (*Single Responsibility*). `Write-Host` bypasses the pipeline, breaks testing, and behaves differently in CI than locally (*Build for all developers*).

**How:**

```powershell
# Good
Write-Verbose "Processing $($Data.Count) items"
Write-Output $result
```

```powershell
# Bad
Write-Host 'Processing data...'          # Bypasses pipeline
Write-Host $result                       # Untestable
```

### Suppressing output

**Practice:** `$null =` for cmdlets. `[void]` for .NET method calls. Never `| Out-Null`.

**Why:** `| Out-Null` adds a pipeline stage — measurably slower in loops. `$null =` is resolved at parse time with no runtime cost (*Build for the modern engineer*).

**How:**

```powershell
# Good
$null = New-Item -Path $path -ItemType Directory
[void]$list.Add($item)
```

```powershell
# Bad
New-Item -Path $path -ItemType Directory | Out-Null
$list.Add($item) | Out-Null
```

### Error handling

**Practice:** Use `try`/`catch`/`finally`. Catch specific exception types. `throw` for unrecoverable errors. `Write-Error` for non-terminating.

**Why:** Silently swallowing exceptions hides bugs — the opposite of *Shift Left*. Specific catch blocks separate recoverable from fatal errors. Meaningful messages serve the next person diagnosing the failure (*Write it down*).

**How:**

```powershell
# Good
try {
    Get-Content -Path $Path -ErrorAction Stop
} catch [System.IO.IOException] {
    Write-Error "IO error: $_"
    throw
} catch {
    Write-Error "Unexpected error: $_"
    throw
}
```

```powershell
# Bad
try {
    Get-Content -Path $Path
} catch {
    # Silently swallowed
}
```

---

## Performance

**Practice:** Use `List[T]` instead of `@()` in loops. Use `-Filter` over `Where-Object`. Use `.Where()` and `.ForEach()` for large collections.

**Why:** `$results += $item` copies the entire array on every iteration — O(n²). `List[T]` appends in O(1). Provider `-Filter` is evaluated at the source before data crosses the pipeline. Use the construct that scales (*Build for the modern engineer*).

**How:**

```powershell
# Good
$results = [System.Collections.Generic.List[PSObject]]::new()
foreach ($item in $collection) {
    $results.Add($processedItem)
}

Get-ChildItem -Path C:\Temp -Filter *.txt
$filtered = $collection.Where({ $_.Value -gt 10 })
```

```powershell
# Bad
$results = @()
foreach ($item in $collection) {
    $results += $processedItem           # O(n²)
}

Get-ChildItem -Path C:\Temp | Where-Object { $_.Name -like '*.txt' }
```

---

## Testing

**Practice:** Pester tests for every function. Files named `*.Tests.ps1`. Structure: `Describe` → `Context` → `It`. Use `BeforeAll`/`AfterAll` for setup.

**Why:** Tests are the executable specification (*TDD*). They catch regressions before production (*Shift Left*) and give contributors confidence to refactor. Consistent naming lets CI, pre-commit hooks, and editors discover tests automatically (*Testable locally*, *Validatable in PRs*).

**How:**

```powershell
# Good
Describe 'Get-UserAccount' {
    Context 'When user exists' {
        It 'Should return user object' {
            $result = Get-UserAccount -UserId '123'
            $result | Should -Not -BeNullOrEmpty
            $result.UserId | Should -Be '123'
        }
    }

    Context 'When user does not exist' {
        It 'Should throw' {
            { Get-UserAccount -UserId '999' } | Should -Throw
        }
    }
}
```

---

## Security

**Practice:** Never hardcode credentials. Use `SecureString`/`Get-Credential`. Validate all input. Support `-WhatIf`/`-Confirm` for destructive operations. Never `Invoke-Expression` with user-supplied data.

**Why:** Hardcoded secrets in source control are irreversible — they cannot be fully recalled (*Make change easy* — irreversible decisions deserve more care). `Invoke-Expression` with unsanitized input is a code injection vector. `-WhatIf` lets operators preview destructive changes (*4-eyes principle*).

**How:**

```powershell
# Good
function Remove-UserData {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $UserId
    )

    if ($PSCmdlet.ShouldProcess($UserId, 'Remove user data')) {
        # Perform deletion
    }
}
```

```powershell
# Bad
$password = 'MyPassword123'   # Hardcoded secret
Invoke-Expression $userInput  # Code injection risk
```
