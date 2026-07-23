#Requires -Version 7.0

<#
    .SYNOPSIS
    Publishes pull request preview docs content to gh-pages.

    .DESCRIPTION
    Writes the PR preview build output into previews/pr-<number> on gh-pages,
    pushes branch updates, and ensures the preview comment is present on the PR.

    .EXAMPLE
    ./Publish-PreviewDocs.ps1 `
      -Repository "PSModule/docs" `
      -Token $token `
      -PullRequestNumber 42 `
      -PreviewUrl "https://psmodule.io/docs/previews/pr-42/" `
      -BuildDirectory "$PWD/src/site"
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
    # Public preview URL for PR comments and environment metadata.
    [Parameter(Mandatory = $true)]
    [string]$PreviewUrl,
    # Full path to the built static site directory.
    [Parameter(Mandatory = $true)]
    [string]$BuildDirectory,
    # Working directory used to clone gh-pages.
    [string]$PagesDirectory = '_pages',
    # Branch used as the Pages source branch.
    [string]$BaseBranch = 'gh-pages'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. "$PSScriptRoot/Shared.ps1"

if (-not (Test-Path -LiteralPath $BuildDirectory -PathType Container)) {
    throw "Build directory '$BuildDirectory' does not exist."
}

Invoke-Git -Arguments @(
    'clone',
    '--no-tags',
    '--depth', '1',
    '--branch', $BaseBranch,
    "https://x-access-token:$Token@github.com/$Repository.git",
    $PagesDirectory
)

$previewDirectory = Join-Path $PagesDirectory "previews/pr-$PullRequestNumber"
if (Test-Path -LiteralPath $previewDirectory) {
    Remove-Item -LiteralPath $previewDirectory -Recurse -Force
}

New-Item -Path $previewDirectory -ItemType Directory -Force | Out-Null
Get-ChildItem -LiteralPath $BuildDirectory -Force |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $previewDirectory -Recurse -Force
    }

New-Item -Path (Join-Path $PagesDirectory '.nojekyll') -ItemType File -Force | Out-Null

Invoke-Git -Arguments @('-C', $PagesDirectory, 'config', 'user.name', 'scribbler-bot[bot]')
Invoke-Git -Arguments @('-C', $PagesDirectory, 'config', 'user.email', 'scribe@psmodule.io')
Invoke-Git -Arguments @('-C', $PagesDirectory, 'add', '-A')

$status = (& git -C $PagesDirectory status --porcelain)
if (-not [string]::IsNullOrWhiteSpace($status)) {
    Invoke-Git -Arguments @('-C', $PagesDirectory, 'commit', '-m', "Update docs preview for PR #$PullRequestNumber")
    Invoke-Git -Arguments @('-C', $PagesDirectory, 'push', 'origin', "HEAD:refs/heads/$BaseBranch")
}

$commentBody = "<!-- docs-pr-preview -->`n✅ Preview is ready: $PreviewUrl"
$env:GH_TOKEN = $Token
Update-IssueComment -Repository $Repository -IssueNumber $PullRequestNumber -Marker '<!-- docs-pr-preview -->' -Body $commentBody

Write-WorkflowOutput -Name 'url' -Value $PreviewUrl
