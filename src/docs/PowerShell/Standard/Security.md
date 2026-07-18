# Security

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
