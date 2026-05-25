Import-Module -Name (Join-Path $PSScriptRoot 'Helper.psm1')

Show-RepoList
Update-ActionList
Update-FunctionAppList
Update-ModuleList
