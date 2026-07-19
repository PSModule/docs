Import-Module -Name (Join-Path $PSScriptRoot 'Helper.psm1')

$repos = Show-RepoList
# Update-ActionList
# Update-FunctionAppList
Update-ModuleList -Repos $repos
