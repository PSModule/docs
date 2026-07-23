#Requires -Version 7.0

<#
    .SYNOPSIS
    Updates generated index content for the docs repository.

    .DESCRIPTION
    Orchestrates the update-index action flow by collecting organization repository
    metadata and regenerating module catalog documentation artifacts.

    .EXAMPLE
    ./Invoke-UpdateIndex.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module -Name (Join-Path $PSScriptRoot 'update-index.Helpers.psm1')

LogGroup 'Initialize update-index run' {
    Write-Host "Starting update-index in [$PSScriptRoot]"
}

LogGroup 'Collect repositories' {
    $repos = Show-RepoList
    Write-Host "Repository collection complete: $($repos.Count) records"
}

LogGroup 'Skipped generators' {
    Write-Host 'Update-ActionList is currently disabled in Invoke-UpdateIndex.ps1'
    Write-Host 'Update-FunctionAppList is currently disabled in Invoke-UpdateIndex.ps1'
}

LogGroup 'Update module catalog docs' {
    Update-ModuleList -Repos $repos
}

LogGroup 'Finalize update-index run' {
    Write-Host 'update-index run completed'
}
