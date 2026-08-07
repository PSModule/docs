#Requires -Version 7.0

<#
    .SYNOPSIS
    Sets the site_url field in a Zensical configuration file.

    .DESCRIPTION
    Replaces the existing top-level site_url assignment in the provided
    zensical.toml file so workflow builds use the expected canonical URL.

    .EXAMPLE
    ./Set-ZensicalSiteUrl.ps1 -ConfigPath "$PWD/src/zensical.toml" -SiteUrl "https://psmodule.io/docs/previews/pr-42/"
#>
[CmdletBinding()]
param(
    # Full path to the Zensical config file.
    [Parameter(Mandatory = $true)]
    [string]$ConfigPath,
    # Canonical URL to write to site_url.
    [Parameter(Mandatory = $true)]
    [string]$SiteUrl
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$content = Get-Content -LiteralPath $ConfigPath -Raw
$updated = $content -replace '(?m)^site_url = ".*"$', "site_url = `"$SiteUrl`""
Set-Content -LiteralPath $ConfigPath -Value $updated
