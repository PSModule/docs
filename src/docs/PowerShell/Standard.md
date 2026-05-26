# PowerShell standards

This document defines coding standards for all PowerShell files across PSModule repositories.
Each standard states the principle, explains why it matters, and shows how to apply it.

## Brace style (OTBS)

**Principle:** Use One True Brace Style — opening braces on the same line, closing braces on their own line. Always use braces, even for single-statement blocks.

**Why:** Consistent brace placement prevents ambiguity, makes diffs cleaner, and avoids the PowerShell parser quirk where a newline before `{` can break certain constructs.

**How:**

```powershell
# Good
function Get-Example {
    param($Name)

    if ($Name) {
        Write-Output "Hello, $Name"
    } else {
        Write-Output 'Hello, World'
    }
}

foreach ($item in $items) {
    Get-Item $item
}
```

```powershell
# Bad
function Get-Example
{                                          # Opening brace must be on same line
}

if ($condition)
    Write-Output 'Missing braces'          # Single statements still need braces

if ($condition) { Write-Output 'Inline' } # Must be on separate lines
```

## Naming conventions

### Functions and cmdlets

**Principle:** Use `Verb-Noun` PascalCase with an approved PowerShell verb and a singular noun.

**Why:** Approved verbs make commands discoverable via `Get-Verb` and predictable to callers. Singular nouns keep naming consistent regardless of how many objects are returned.

**How:**

```powershell
# Good
function Get-UserProfile { }
function Set-ConfigValue { }
function New-DatabaseConnection { }
function Remove-TempFile { }
```

```powershell
# Bad
function GetUser { }          # Missing hyphen
function get-user { }         # Wrong case
function Do-Something { }     # Non-standard verb
function Get-Users { }        # Plural noun
```

### Parameters and variables

**Principle:** PascalCase for parameters and public variables; camelCase for local variables. Prefix booleans with `is`, `has`, or `should`. Never shadow automatic variables.

**Why:** Consistent casing communicates scope at a glance. Boolean prefixes eliminate guessing whether a value is a flag or a count. Shadowing automatic variables (`$Error`, `$Args`, etc.) causes subtle, hard-to-debug bugs.

**How:**

```powershell
# Good
$userName = 'John'
$isValid = $true
$hasPermission = $false
$totalCount = 0

param(
    [string] $ConfigPath,
    [switch] $Force
)
```

```powershell
# Bad
$usr = 'John'          # Too abbreviated
$valid = $true         # Boolean should be prefixed
$TOTAL_COUNT = 0       # Wrong case style
```

### Constants

**Principle:** PascalCase names marked read-only with `Set-Variable -Option ReadOnly`.

**Why:** Read-only marking causes PowerShell to throw if something tries to overwrite the value, turning a silent logic error into a visible failure.

**How:**

```powershell
# Good
Set-Variable -Name MaxRetries     -Value 3                        -Option ReadOnly
Set-Variable -Name DefaultTimeout -Value 30                       -Option ReadOnly
Set-Variable -Name ApiEndpoint    -Value 'https://api.example.com' -Option ReadOnly
```

## Parameters

**Principle:** Every function must have `[OutputType()]`, `[CmdletBinding()]`, and a typed `param()` block. Use validation attributes. Mandatory parameters come first. Use `[switch]` for boolean flags.

**Why:** `CmdletBinding` enables `-Verbose`, `-WhatIf`, and common parameters for free. Type constraints catch bad input early. `[switch]` defaults to `$false` without extra code and communicates intent clearly.

**How:**

```powershell
# Good
function Get-UserData {
<#
    .SYNOPSIS
    Retrieves user data from the database.

    .DESCRIPTION
    Retrieves user data from the database by user ID.

    .EXAMPLE
    Get-UserData -UserId '12345' -IncludeDeleted
#>
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
}
```

```powershell
# Bad
function Get-UserData($id, $del) {
    # No param block, no types, unclear names
}
```

## Indentation and whitespace

**Principle:** 4-space indentation, one space around operators and after commas, no trailing whitespace, one blank line between logical blocks, files end with a single newline.

**Why:** Mechanical consistency removes formatting noise from code review and prevents diff pollution from whitespace-only changes.

**How:**

```powershell
# Good
function Process-Data {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [array] $Items
    )

    $results = @()

    foreach ($item in $Items) {
        $processed = Format-Item $item
        $results += $processed
    }

    return $results
}
```

```powershell
# Bad
function Process-Data{
    param($Items)
    $results=@()
    foreach($item in $Items){
        $processed=Format-Item $item
    $results+=$processed
    }
    return $results
}
```

## Comments and help

**Principle:** Comment-based help goes first inside the function body, before any code. Use inline parameter comments above each parameter. Comments explain *why*, not *what*.

**Why:** Placing help first keeps it adjacent to the function signature, makes it easy to collapse in editors, and ensures `Get-Help` always finds it. Describing *why* preserves context that the code cannot express.

**How:**

```powershell
# Good
function New-UserAccount {
<#
    .SYNOPSIS
    Creates a new user account.

    .DESCRIPTION
    Creates a new user account with the specified username and email.
    Validates the email format before creation.

    .EXAMPLE
    New-UserAccount -UserName 'jdoe' -Email 'jdoe@example.com'

    Creates a new user account for jdoe.

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

    # Validate before processing to fail fast rather than hitting the database
    if ($Email -notmatch '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') {
        throw "Invalid email format: $Email"
    }
}
```

```powershell
# Bad
function New-UserAccount {
    param($UserName, $Email)
    # Check email
    if ($Email -notmatch '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') { throw 'Invalid email' }
}
```

## String handling

**Principle:** Single quotes for literals, double quotes only when expansion is needed, here-strings for multi-line content, `-f` operator for formatting.

**Why:** Single-quoted strings are evaluated literally — no accidental variable expansion or escape processing. This prevents subtle bugs and makes intent explicit.

**How:**

```powershell
# Good
$name     = 'John'
$greeting = "Hello, $name"
$path     = 'C:\Temp\file.txt'
$message  = 'The value is: {0}' -f $value

$multiLine = @"
This is a multi-line string
with variable: $name
"@
```

```powershell
# Bad
$name     = "John"                         # No variables — use single quotes
$greeting = 'Hello, $name'                 # Variable will not expand
$message  = 'The value is: ' + $value      # Use -f operator instead
```

## Control structures

### If/else

**Principle:** Always use braces, use `elseif` (one word), one space before `{`, complex conditions broken across lines.

**Why:** Missing braces are a common source of logic bugs when adding lines later. `elseif` (one word) is idiomatic PowerShell.

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

if ($user.IsActive -and
    $user.HasPermission -and
    $user.Age -gt 18) {
    Grant-Access
}
```

```powershell
# Bad
if ($condition)
{                                         # Brace on wrong line
    Do-Something
}

if ($condition) Do-Something              # Missing braces

if($condition){                           # Missing spaces
    Do-Something
}
```

### Loops

**Principle:** Prefer `foreach` over `for` when the index is not needed. Always use braces.

**Why:** `foreach` is more readable and avoids off-by-one errors. Consistent braces protect against accidental modification.

**How:**

```powershell
# Good
foreach ($item in $collection) {
    Process-Item $item
}

for ($i = 0; $i -lt $count; $i++) {
    Process-Index $i
}
```

```powershell
# Bad
foreach ($item in $collection)
{                                         # Brace on wrong line
    Process-Item $item
}

foreach ($item in $collection) Process-Item $item  # Missing braces
```

### Switch statements

**Principle:** Opening brace on the same line, case blocks indented 4 spaces, always include `default`.

**Why:** A `default` case makes it explicit that unmatched values are handled intentionally, not overlooked.

**How:**

```powershell
# Good
switch ($value) {
    'Option1' {
        Do-FirstThing
    }
    'Option2' {
        Do-SecondThing
    }
    default {
        Do-DefaultThing
    }
}
```

## Error handling

**Principle:** Use `try`/`catch`/`finally`. Catch specific exception types. Use `throw` for unrecoverable errors, `Write-Error` for non-terminating errors.

**Why:** Catching all exceptions silently hides bugs and makes production failures invisible. Specific catch blocks let you handle recoverable errors differently from fatal ones.

**How:**

```powershell
# Good
function Get-FileContent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    try {
        if (-not (Test-Path $Path)) {
            throw "File not found: $Path"
        }

        Get-Content -Path $Path -ErrorAction Stop
    } catch [System.IO.IOException] {
        Write-Error "IO error reading file: $_"
        throw
    } catch {
        Write-Error "Unexpected error: $_"
        throw
    } finally {
        # Cleanup regardless of outcome
    }
}
```

```powershell
# Bad
function Get-FileContent {
    param([string]$Path)
    try {
        Get-Content -Path $Path
    } catch {
        # Swallowing errors silently
    }
}
```

## Output and logging

**Principle:** Use `Write-Output` for return values. Never use `Write-Host`. Use `Write-Verbose`, `Write-Warning`, `Write-Error`, and `Write-Information` for their respective purposes.

**Why:** `Write-Host` writes directly to the console host and bypasses the pipeline, redirects, and `-Verbose`/`-Silent` flags. This breaks composability and makes scripts untestable.

**How:**

```powershell
# Good
function Get-ProcessedData {
    [CmdletBinding()]
    param($Data)

    Write-Verbose "Processing $($Data.Count) items"

    $result = Process-Data $Data

    if ($result.Warnings) {
        Write-Warning 'Processing completed with warnings'
    }

    Write-Output $result
}
```

```powershell
# Bad
function Get-ProcessedData {
    param($Data)
    Write-Host 'Processing data...'  # Bypasses pipeline
    $result = Process-Data $Data
    Write-Host $result               # Use Write-Output
}
```

## Suppressing output

**Principle:** Use `$null =` to discard output from cmdlets. Use `[void]` for .NET method calls. Never pipe to `Out-Null`.

**Why:** `| Out-Null` creates an extra pipeline stage and is measurably slower, especially inside loops. `$null =` is evaluated at parse time with no runtime cost.

**How:**

```powershell
# Good
$null = New-Item -Path $path -ItemType Directory
$null = $list.Add($item)
[void]$list.Add($item)
```

```powershell
# Bad
New-Item -Path $path -ItemType Directory | Out-Null  # Slower pipeline stage
$list.Add($item) | Out-Null
```

## Pipeline design

**Principle:** Functions that process collections should accept pipeline input via `ValueFromPipeline` and implement `begin`/`process`/`end` blocks.

**Why:** Pipeline-aware functions integrate with the PowerShell ecosystem, enabling streaming processing and composability with other commands without loading entire collections into memory.

**How:**

```powershell
# Good
function Update-Item {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $Item
    )

    begin {
        $count = 0
    }

    process {
        $Item.LastModified = Get-Date
        $count++
        Write-Output $Item
    }

    end {
        Write-Verbose "Processed $count items"
    }
}

$items | Update-Item
```

## Arrays and hashtables

**Principle:** Use `@()` for arrays, `@{}` for hashtables. Multi-line collections have one item per line. Align hashtable values for readability.

**Why:** Explicit collection syntax makes intent clear. One item per line makes diffs readable and allows easy reordering.

**How:**

```powershell
# Good
$numbers = @(1, 2, 3, 4, 5)

$multiLineArray = @(
    'First item'
    'Second item'
    'Third item'
)

$hashtable = @{
    Name = 'John'
    Age  = 30
    City = 'Seattle'
}
```

```powershell
# Bad
$array = 1, 2, 3, 4, 5                                    # Use @() syntax
$hashtable = @{Name = 'John'; Age = 30; City = 'Seattle'}  # Use multi-line format
```

## Splatting

**Principle:** Use splatting when a function call has more than two or three parameters. Build the hashtable first, then splat with `@`.

**Why:** Long parameter lines exceed the line-length limit, wrap unpredictably, and are hard to diff. Splatting also makes it easy to conditionally add parameters before the call.

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

## Comparison operators

**Principle:** Use PowerShell operators (`-eq`, `-ne`, `-gt`, etc.). Place `$null` on the left side of null comparisons.

**Why:** C-style operators (`==`, `!=`) do not work in PowerShell. For null checks, `$null -eq $collection` is safe even when `$collection` is an array; the reverse can return unexpected results or throw.

**How:**

```powershell
# Good
if ($value -eq 10) { }
if ($name -like 'John*') { }
if ($email -match '^[\w-\.]+@') { }
if ($list -contains $item) { }
if ($name -ceq 'JOHN') { }              # Case-sensitive match
if ($null -eq $collection) { }          # Safe null check for collections
```

```powershell
# Bad
if ($value == 10) { }                   # Wrong operator
if ($list -eq $item) { }                # Use -contains for collections
if ($collection -eq $null) { }          # Unsafe — can error on arrays
```

## Script structure

**Principle:** `#Requires` at the top, then `param()`, then functions, then execution logic in a `try`/`catch` block.

**Why:** `#Requires` prevents the script from running on incompatible environments before any code executes. A top-level `try`/`catch` ensures all unhandled errors produce a clean failure instead of a partial run.

**How:**

```powershell
# Good
#Requires -Version 7.4

<#
    .SYNOPSIS
    Manages user accounts.

    .DESCRIPTION
    Provides functions to create, update, and delete user accounts.
#>

[CmdletBinding()]
param(
    [string] $ConfigPath = '.\config.json'
)

$ErrorActionPreference = 'Stop'

#region Helper functions
function Get-ConfigData {
    param([string] $Path)
}

function New-UserAccount {
    param($UserName, $Email)
}
#endregion

try {
    $config = Get-ConfigData -Path $ConfigPath
} catch {
    Write-Error "Script failed: $_"
    exit 1
}
```

## Regions

**Principle:** Use `#region`/`#endregion` to mark logical sections within a file. Label every region.

**Why:** Regions create named, collapsible blocks in VS Code and most PowerShell-aware editors. They make long files navigable without splitting them into separate files, and the label doubles as lightweight in-file documentation.

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
function Get-ConfigData { }   # Unlabelled — reader must read the body to know what this is
#endregion
```

## Performance

**Principle:** Use `List[T]` instead of `@()` in loops. Use `-Filter` over `Where-Object`. Use `.Where()` and `.ForEach()` method syntax over pipeline for large collections.

**Why:** Appending to a PowerShell array (`$results += $item`) creates a new array copy on every iteration — O(n²) for n items. `List[T]` appends in amortized O(1). Provider `-Filter` parameters are evaluated at the source before any data crosses the pipeline.

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
    $results += $processedItem           # New array copy every iteration
}

Get-ChildItem -Path C:\Temp | Where-Object { $_.Name -like '*.txt' }
```

## Line length

**Principle:** Wrap at 100–120 characters. Prefer splatting over backtick continuations.

**Why:** Backtick line continuation is fragile — a trailing space after the backtick silently breaks it. Splatting achieves the same result more robustly and is easier to read.

**How:**

```powershell
# Good — use splatting
$params = @{
    Parameter1 = $value1
    Parameter2 = $value2
    Parameter3 = $value3
}
$result = Get-Something @params
```

```powershell
# Bad — fragile backtick continuation
$result = Get-Something -Parameter1 $value1 `
    -Parameter2 $value2 `
    -Parameter3 $value3
```

## Testing

**Principle:** Write Pester tests for every function. Name files `*.Tests.ps1`. Structure with `Describe`, `Context`, and `It` blocks. Use `BeforeAll`/`AfterAll` for setup and teardown.

**Why:** Tests document expected behavior, catch regressions, and give contributors confidence to refactor. Consistent naming lets tooling discover tests automatically.

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

## Security

**Principle:** Never hardcode credentials. Use `SecureString` and `Get-Credential`. Validate all user input. Support `-WhatIf`/`-Confirm` for destructive operations. Never use `Invoke-Expression` with user-supplied data.

**Why:** Hardcoded secrets end up in source control and logs. `Invoke-Expression` with unsanitized input is a direct code injection vector. `-WhatIf` support lets operators preview destructive changes before committing.

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

$cred = Get-Credential -Message 'Enter admin credentials'
```

```powershell
# Bad
$password = 'MyPassword123'   # Hardcoded secret
Invoke-Expression $userInput  # Code injection risk
```
