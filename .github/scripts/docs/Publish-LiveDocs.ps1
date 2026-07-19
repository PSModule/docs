param(
    [Parameter(Mandatory = $true)]
    [string]$Repository,
    [Parameter(Mandatory = $true)]
    [string]$Token,
    [Parameter(Mandatory = $true)]
    [string]$BuildDirectory,
    [Parameter(Mandatory = $true)]
    [string]$HeadBranch,
    [Parameter(Mandatory = $true)]
    [string]$CommitSha,
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
    Set-WorkflowOutput -Name 'has_changes' -Value 'false'
    exit 0
}

Invoke-Git -Arguments @('-C', $PagesDirectory, 'commit', '-m', "Deploy docs from $CommitSha")
Invoke-Git -Arguments @('-C', $PagesDirectory, 'push', '--force-with-lease', 'origin', "HEAD:refs/heads/$HeadBranch")

$env:GH_TOKEN = $Token
$prNumber = Upsert-PullRequest `
    -Repository $Repository `
    -HeadBranch $HeadBranch `
    -BaseBranch $BaseBranch `
    -Title 'docs(publish): update live docs' `
    -Body "Automated docs publish from `$CommitSha`nLive URL: https://psmodule.io/docs/"
Enable-PullRequestAutoMerge -Repository $Repository -PullRequestNumber $prNumber

Set-WorkflowOutput -Name 'has_changes' -Value 'true'
Set-WorkflowOutput -Name 'pr_number' -Value $prNumber
