param(
    [Parameter(Mandatory = $true)]
    [string]$ConfigPath,
    [Parameter(Mandatory = $true)]
    [string]$SiteUrl
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$content = Get-Content -LiteralPath $ConfigPath -Raw
$updated = $content -replace '(?m)^site_url = ".*"$', "site_url = `"$SiteUrl`""
Set-Content -LiteralPath $ConfigPath -Value $updated
