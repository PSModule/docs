Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [switch]$AllowFailure
    )

    & git @Arguments
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0 -and -not $AllowFailure) {
        throw "git $($Arguments -join ' ') failed with exit code $exitCode."
    }

    return $exitCode
}

function Set-WorkflowOutput {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    if (-not $env:GITHUB_OUTPUT) {
        throw 'GITHUB_OUTPUT is not defined.'
    }

    "$Name=$Value" >> $env:GITHUB_OUTPUT
}

function Invoke-Gh {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [switch]$AllowFailure
    )

    $output = & gh @Arguments
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0 -and -not $AllowFailure) {
        throw "gh $($Arguments -join ' ') failed with exit code $exitCode."
    }

    return $output
}

function Upsert-PullRequest {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Repository,
        [Parameter(Mandatory = $true)]
        [string]$HeadBranch,
        [Parameter(Mandatory = $true)]
        [string]$BaseBranch,
        [Parameter(Mandatory = $true)]
        [string]$Title,
        [Parameter(Mandatory = $true)]
        [string]$Body
    )

    $existing = Invoke-Gh -Arguments @('pr', 'list', '--repo', $Repository, '--base', $BaseBranch, '--head', $HeadBranch, '--state', 'open', '--json', 'number', '--jq', '.[0].number')
    if ([string]::IsNullOrWhiteSpace($existing)) {
        return (Invoke-Gh -Arguments @('pr', 'create', '--repo', $Repository, '--base', $BaseBranch, '--head', $HeadBranch, '--title', $Title, '--body', $Body, '--json', 'number', '--jq', '.number'))
    }

    Invoke-Gh -Arguments @('pr', 'edit', $existing, '--repo', $Repository, '--title', $Title, '--body', $Body) | Out-Null
    return $existing
}

function Enable-PullRequestAutoMerge {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Repository,
        [Parameter(Mandatory = $true)]
        [string]$PullRequestNumber
    )

    Invoke-Gh -Arguments @('pr', 'merge', $PullRequestNumber, '--repo', $Repository, '--squash', '--auto', '--delete-branch') | Out-Null
}

function Upsert-IssueComment {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Repository,
        [Parameter(Mandatory = $true)]
        [int]$IssueNumber,
        [Parameter(Mandatory = $true)]
        [string]$Marker,
        [Parameter(Mandatory = $true)]
        [string]$Body
    )

    $commentsJson = Invoke-Gh -Arguments @('api', "repos/$Repository/issues/$IssueNumber/comments?per_page=100")
    $comments = @($commentsJson | ConvertFrom-Json)
    $existing = $comments | Where-Object { $_.body -like "*$Marker*" } | Select-Object -First 1

    if ($null -ne $existing) {
        Invoke-Gh -Arguments @('api', '--method', 'PATCH', "repos/$Repository/issues/comments/$($existing.id)", '-f', "body=$Body") | Out-Null
        return
    }

    Invoke-Gh -Arguments @('api', '--method', 'POST', "repos/$Repository/issues/$IssueNumber/comments", '-f', "body=$Body") | Out-Null
}
