#Requires -Version 7.0

<#
    .SYNOPSIS
    Removes pull request preview artifacts and related environment state.

    .DESCRIPTION
    Deletes previews/pr-<number> from gh-pages, deactivates and removes preview
    deployments, deletes the preview environment, and updates the PR comment.

    .EXAMPLE
    ./Cleanup-PreviewDocs.ps1 -Repository "PSModule/docs" -Token $token -PullRequestNumber 42 -PreviewUrl "https://psmodule.io/docs/previews/pr-42/" -EnvironmentName "pr-preview-42"
#>
[CmdletBinding()]
param(
    # Repository in owner/name format.
    [Parameter(Mandatory = $true)]
    [string]$Repository,
    # GitHub App token used for authenticated git and gh operations.
    [Parameter(Mandatory = $true)]
    [string]$Token,
    # Pull request number used for preview path and comment targeting.
    [Parameter(Mandatory = $true)]
    [int]$PullRequestNumber,
    # Public preview URL for PR comments.
    [Parameter(Mandatory = $true)]
    [string]$PreviewUrl,
    # Environment name to clean up from repository environments.
    [Parameter(Mandatory = $true)]
    [string]$EnvironmentName,
    # Working directory used to clone gh-pages.
    [string]$PagesDirectory = '_pages',
    # Branch used as the Pages source branch.
    [string]$BaseBranch = 'gh-pages'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. "$PSScriptRoot/Shared.ps1"

$clonedPages = $true
Invoke-Git -Arguments @(
    'clone',
    '--no-tags',
    '--depth', '1',
    '--branch', $BaseBranch,
    "https://x-access-token:$Token@github.com/$Repository.git",
    $PagesDirectory
) -AllowFailure | Out-Null

if (-not (Test-Path -LiteralPath $PagesDirectory -PathType Container)) {
    $clonedPages = $false
}

if ($clonedPages) {
    $previewDirectory = Join-Path $PagesDirectory "previews/pr-$PullRequestNumber"
    if (Test-Path -LiteralPath $previewDirectory) {
        Remove-Item -LiteralPath $previewDirectory -Recurse -Force
    }

    Invoke-Git -Arguments @('-C', $PagesDirectory, 'config', 'user.name', 'scribbler-bot[bot]')
    Invoke-Git -Arguments @('-C', $PagesDirectory, 'config', 'user.email', 'scribe@psmodule.io')
    Invoke-Git -Arguments @('-C', $PagesDirectory, 'add', '-A')

    $status = (& git -C $PagesDirectory status --porcelain)
    if (-not [string]::IsNullOrWhiteSpace($status)) {
        Invoke-Git -Arguments @('-C', $PagesDirectory, 'commit', '-m', "Remove docs preview for PR #$PullRequestNumber")
        Invoke-Git -Arguments @('-C', $PagesDirectory, 'push', 'origin', "HEAD:refs/heads/$BaseBranch")
    }
}

$env:GH_TOKEN = $Token
$deploymentsJson = Invoke-Gh -Arguments @('api', "repos/$Repository/deployments?environment=$EnvironmentName&per_page=100")
$deployments = @($deploymentsJson | ConvertFrom-Json)

foreach ($deployment in $deployments) {
    Invoke-Gh -Arguments @('api', '--method', 'POST', "repos/$Repository/deployments/$($deployment.id)/statuses", '-f', 'state=inactive') | Out-Null
    Invoke-Gh -Arguments @('api', '--method', 'DELETE', "repos/$Repository/deployments/$($deployment.id)") | Out-Null
}

$deleteEnvironmentExit = Invoke-Gh -Arguments @('api', '--method', 'DELETE', "repos/$Repository/environments/$EnvironmentName") -AllowFailure
if ($LASTEXITCODE -ne 0) {
    $environmentCheckExit = Invoke-Gh -Arguments @('api', "repos/$Repository/environments/$EnvironmentName") -AllowFailure
    if ($LASTEXITCODE -eq 0) {
        throw "Failed to delete environment '$EnvironmentName'."
    }
}

$commentBody = "<!-- docs-pr-preview -->`n🧹 Preview removed: $PreviewUrl"
Upsert-IssueComment -Repository $Repository -IssueNumber $PullRequestNumber -Marker '<!-- docs-pr-preview -->' -Body $commentBody
