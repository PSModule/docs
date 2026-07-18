# Control flow

## If/else

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

## Loops

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

## Switch statements

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
