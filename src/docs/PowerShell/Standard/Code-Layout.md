# Code layout

## Brace style (OTBS)

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
{                                  # Brace must be on same line
}

if ($condition)
    Write-Output 'Missing braces'  # Always use braces
```

## Indentation and whitespace

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

## Line length

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

## Avoid semicolons as line terminators

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

## Regions

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

## Lowercase keywords

**Practice:** All PowerShell keywords must be lowercase: `function`, `filter`, `param`, `begin`, `process`, `end`, `if`, `else`, `elseif`, `switch`, `foreach`, `for`, `while`, `do`, `return`, `throw`, `try`, `catch`, `finally`.

**Why:** Consistent casing for language keywords separates them visually from PascalCase user-defined names. Lowercase keywords are the community convention enforced by formatters and linters (*Clean Code*).

**How:**

```powershell
# Good
function Get-Item {
    param()
    begin { }
    process { }
    end { }
}
```

```powershell
# Bad
Function Get-Item {
    Param()
    Begin { }
    Process { }
    End { }
}
```

## No ternary operators

**Practice:** Do not use ternary operators (`condition ? a : b`). Use `if`/`else` instead.

**Why:** Ternary operators are not available in PowerShell 5.1. Using `if`/`else` maintains cross-version compatibility (*Build for all developers*).

**How:**

```powershell
# Good
if ($condition) {
    $value = 'yes'
} else {
    $value = 'no'
}
```

```powershell
# Bad
$value = $condition ? 'yes' : 'no'   # Breaks on PowerShell 5.1
```
