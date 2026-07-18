# Output and error handling

## Output streams

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

## Suppressing output

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

## Error handling

**Practice:** Use `try`/`catch`/`finally`. Catch specific exception types. `throw` for unrecoverable errors. `Write-Error` for non-terminating. Use `try`/`catch` only when adding value (translation, enrichment, cleanup).

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

## Never pass -Verbose explicitly

**Practice:** Never pass `-Verbose` to commands inside scripts or module code. The only permitted exception is `-Verbose:$false` to explicitly silence a call.

**Why:** Passing `-Verbose` overrides the caller's preference, breaking the expected propagation of common parameters. This violates the principle of least surprise and makes verbose output uncontrollable (*Product mindset*).

**How:**

```powershell
# Good — verbose propagates from caller preference
Invoke-RestMethod -Uri $uri -Method Get

# Good — explicitly silencing a noisy call
Import-Module -Name Az.Accounts -Verbose:$false
```

```powershell
# Bad
Invoke-RestMethod -Uri $uri -Method Get -Verbose   # Overrides caller preference
```
