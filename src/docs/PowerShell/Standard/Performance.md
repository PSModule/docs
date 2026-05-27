# Performance

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
