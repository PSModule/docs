# Readability

## String handling

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

## Comparison operators

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

## Splatting

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

## Arrays and hashtables

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

## String emptiness

**Practice:** Test string emptiness with `-not $Param`. Never use `[string]::IsNullOrEmpty(...)`.

**Why:** `-not` on a string evaluates to `$true` for both `$null` and empty string, is idiomatic PowerShell, and reads naturally. The .NET method adds noise and is redundant in PowerShell context (*Clean Code*).

**How:**

```powershell
# Good
if (-not $Name) {
    throw 'Name is required'
}
```

```powershell
# Bad
if ([string]::IsNullOrEmpty($Name)) {
    throw 'Name is required'
}
```

## Wildcard detection

**Practice:** Use `[System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($Value)` to detect wildcards. Never use `$Value.Contains('*')`.

**Why:** The `.Contains('*')` approach misses `?`, `[`, and `` ` `` — all valid PowerShell wildcard characters. The built-in API handles the full wildcard grammar correctly (*Determinism before intelligence*).

**How:**

```powershell
# Good
if ([System.Management.Automation.WildcardPattern]::ContainsWildcardCharacters($Path)) {
    # Handle wildcard path
}
```

```powershell
# Bad
if ($Path.Contains('*')) {
    # Misses ?, [, and backtick wildcards
}
```

## Cross-platform environment access

**Practice:** Use `[System.Environment]::ProcessorCount` instead of `$env:NUMBER_OF_PROCESSORS`. Prefer .NET APIs over platform-specific environment variables.

**Why:** `$env:NUMBER_OF_PROCESSORS` is only available on Windows. The .NET API works reliably on all platforms (*Build for all developers*).

**How:**

```powershell
# Good
$cpuCount = [System.Environment]::ProcessorCount
```

```powershell
# Bad
$cpuCount = $env:NUMBER_OF_PROCESSORS   # Windows-only
```
