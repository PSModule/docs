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
    [string]$EnvironmentName,
    [Parameter(Mandatory = $true)]
    [string]$HeadBranch,
    [string]$PagesDirectory = '_pages',
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
        Invoke-Git -Arguments @('-C', $PagesDirectory, 'push', '--force-with-lease', 'origin', "HEAD:refs/heads/$HeadBranch")

        $env:GH_TOKEN = $Token
        $prNumber = Upsert-PullRequest `
            -Repository $Repository `
            -HeadBranch $HeadBranch `
            -BaseBranch $BaseBranch `
            -Title "docs(preview): cleanup PR #$PullRequestNumber" `
            -Body "Automated cleanup for preview URL: $PreviewUrl"
        Enable-PullRequestAutoMerge -Repository $Repository -PullRequestNumber $prNumber
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
