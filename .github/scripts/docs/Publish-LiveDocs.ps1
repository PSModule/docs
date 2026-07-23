#Requires -Version 7.0

<#
    .SYNOPSIS
    Publishes live docs content to the gh-pages branch.

    .DESCRIPTION
    Clones gh-pages, replaces live content while keeping previews, and pushes
    the updated branch using the GitHub App token identity.

    .EXAMPLE
    ./Publish-LiveDocs.ps1 `
      -Repository "PSModule/docs" `
      -Token $token `
      -BuildDirectory "$PWD/src/site" `
      -CommitSha $env:GITHUB_SHA
#>
[CmdletBinding()]
param(
    # Repository in owner/name format.
    [Parameter(Mandatory = $true)]
    [string]$Repository,
    # GitHub App token used for authenticated git and gh operations.
    [Parameter(Mandatory = $true)]
    [string]$Token,
    # Full path to the built static site directory.
    [Parameter(Mandatory = $true)]
    [string]$BuildDirectory,
    # Commit SHA used in the publish commit message.
    [Parameter(Mandatory = $true)]
    [string]$CommitSha,
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
) -AllowFailure | Out-Null

if (-not (Test-Path -LiteralPath $PagesDirectory -PathType Container)) {
    throw "$BaseBranch branch is required for branch-based deployment."
}

Get-ChildItem -LiteralPath $PagesDirectory -Force |
    Where-Object { $_.Name -notin @('.git', 'previews') } |
    Remove-Item -Recurse -Force

Get-ChildItem -LiteralPath $BuildDirectory -Force |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $PagesDirectory -Recurse -Force
    }

New-Item -Path (Join-Path $PagesDirectory '.nojekyll') -ItemType File -Force | Out-Null

Invoke-Git -Arguments @('-C', $PagesDirectory, 'config', 'user.name', 'scribbler-bot[bot]')
Invoke-Git -Arguments @('-C', $PagesDirectory, 'config', 'user.email', 'scribe@psmodule.io')
Invoke-Git -Arguments @('-C', $PagesDirectory, 'add', '-A')

$status = (& git -C $PagesDirectory status --porcelain)
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-WorkflowOutput -Name 'has_changes' -Value 'false'
    exit 0
}

Invoke-Git -Arguments @('-C', $PagesDirectory, 'commit', '-m', "Deploy docs from $CommitSha")
Invoke-Git -Arguments @('-C', $PagesDirectory, 'push', 'origin', "HEAD:refs/heads/$BaseBranch")

Write-WorkflowOutput -Name 'has_changes' -Value 'true'
