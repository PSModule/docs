# Documentation and comments

## Comment-based help

**Practice:** Comment-based help goes first inside the function body. Include sections in this order: `.SYNOPSIS` (one sentence, imperative mood), `.DESCRIPTION` (one paragraph per behaviour or parameter set), `.EXAMPLE` (at least one per public behaviour), `.INPUTS`, `.OUTPUTS` (matches `[OutputType()]`), `.NOTES`, `.LINK`. Use inline comments above each parameter (not `.PARAMETER`). Comments explain *why*, not *what*.

**Why:** Documentation lives close to the thing it documents (*Principles*). Help inside the body ensures `Get-Help` always finds it and makes it collapsible in VS Code. Explaining *why* preserves context that code alone cannot express — this is how knowledge becomes shared (*Write it down*, *Context-first development*).

**How:**

```powershell
# Good
function New-UserAccount {
    <#
        .SYNOPSIS
        Create a new user account.

        .DESCRIPTION
        Creates a new user account with the specified username and email.

        .EXAMPLE
        New-UserAccount -UserName 'jdoe' -Email 'jdoe@example.com'

        .INPUTS
        None.

        .OUTPUTS
        [PSCustomObject]

        .NOTES
        Requires admin permissions on the target tenant.

        .LINK
        https://psmodule.io/MyModule/Functions/Users/New-UserAccount/
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
