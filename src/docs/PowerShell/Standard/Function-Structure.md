# Function structure

## Always use CmdletBinding

**Practice:** Every function must have `[CmdletBinding()]`, `[OutputType()]`, and a typed `param()` block with validation attributes. Mandatory parameters first. Use `[switch]` for boolean flags. Add `SupportsShouldProcess` only on commands that mutate state (create, update, remove, copy, install, publish). Never add it to `Get-`, `Test-`, `Resolve-`, `ConvertTo-`, `ConvertFrom-` commands.

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

## Parameter attribute order

**Practice:** Place parameter attributes in this order, each on its own line: `[Parameter()]`, validation attributes, `[ArgumentCompleter()]`, `[Alias()]`, typed declaration.

**Why:** Consistent ordering makes parameter blocks scannable across all functions in a codebase. Reviewers know exactly where to look for each concern (*4-eyes principle*, *Clean Code*).

**How:**

```powershell
# Good
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('Active', 'Archived')]
    [ArgumentCompleter({ Get-StateCompleter })]
    [Alias('Status')]
    [string] $State
)
```

```powershell
# Bad
param(
    [Alias('Status')]
    [string]
    [ValidateSet('Active', 'Archived')]
    [Parameter(Mandatory)]
    $State                                  # Random order, type on wrong line
)
```

## Parameter sets

**Practice:** Single mode — no named set, no `DefaultParameterSetName`. Multiple modes — every set has an intent-revealing name. Never use `'Default'`, `'ByID'`, or `'__AllParameterSets'` as set names. Set `DefaultParameterSetName` to the most common user intent.

**Why:** Intent-revealing names document the function's modes directly in the metadata (*Write it down*). Users can discover modes via `Get-Help` without reading the implementation (*Product mindset*).

**How:**

```powershell
# Good — multiple parameter sets
function Get-Project {
    [CmdletBinding(DefaultParameterSetName = 'List projects')]
    param(
        [Parameter(ParameterSetName = 'List projects')]
        [string] $Filter,

        [Parameter(Mandatory, ParameterSetName = 'Get a project by name')]
        [string] $Name
    )
}
```

```powershell
# Bad
function Get-Project {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param(
        [Parameter(ParameterSetName = 'Default')]
        [string] $Filter,

        [Parameter(Mandatory, ParameterSetName = 'ByName')]
        [string] $Name
    )
}
```

## Pipeline design

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

## Script structure

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
