param(
    [Parameter(Mandatory = $true)]
    [string]$Repository,
    [Parameter(Mandatory = $true)]
    [string]$Token,
    [Parameter(Mandatory = $true)]
    [int]$PullRequestNumber,
    [Parameter(Mandatory = $true)]
    [string]$PreviewUrl,
    [Parameter(Mandatory = $true)]
    [string]$BuildDirectory,
    [Parameter(Mandatory = $true)]
    [string]$HeadBranch,
    [string]$PagesDirectory = '_pages',
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
    Invoke-Git -Arguments @('-C', $PagesDirectory, 'push', '--force-with-lease', 'origin', "HEAD:refs/heads/$HeadBranch")

    $env:GH_TOKEN = $Token
    $prNumber = Upsert-PullRequest `
        -Repository $Repository `
        -HeadBranch $HeadBranch `
        -BaseBranch $BaseBranch `
        -Title "docs(preview): PR #$PullRequestNumber" `
        -Body "Automated preview content update for #$PullRequestNumber`nPreview URL: $PreviewUrl"
    Enable-PullRequestAutoMerge -Repository $Repository -PullRequestNumber $prNumber
}

$commentBody = "<!-- docs-pr-preview -->`n✅ Preview is ready: $PreviewUrl"
$env:GH_TOKEN = $Token
Upsert-IssueComment -Repository $Repository -IssueNumber $PullRequestNumber -Marker '<!-- docs-pr-preview -->' -Body $commentBody

Set-WorkflowOutput -Name 'url' -Value $PreviewUrl
