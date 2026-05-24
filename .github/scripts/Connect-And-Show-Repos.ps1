#Requires -Module GitHub

[CmdletBinding()]
param(
    # Name of the organization to connect to. Defaults to the owner of the current repository.
    [Parameter()]
    [string] $Owner = $env:GITHUB_REPOSITORY_OWNER
)

LogGroup "Connect to organization [$Owner]" {
    Connect-GitHubApp -Organization $Owner -Default
    Write-Output "Owner: $Owner"
    $rawRepos = Get-GitHubRepository -Organization $Owner -AdditionalProperty Description
    Write-Output "Found $($rawRepos.Count) repositories"
    $repos = $rawRepos | ForEach-Object {
        $rawRepo = $_
        $properties = Get-GitHubRepositoryCustomProperty -Owner $Owner -Repo $rawRepo.name
        $properties | Where-Object { $_.property_name -eq 'Type' } | ForEach-Object {
            $type = $_.value
            [pscustomobject]@{
                Name        = $rawRepo.Name
                Owner       = $Owner
                Type        = $type
                Description = $rawRepo.Description
            }
        }
    } | Sort-Object Type, Name
    $repos | Format-Table -AutoSize
}
