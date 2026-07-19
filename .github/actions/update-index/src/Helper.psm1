#Requires -Modules GitHub

[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidLongLines', '',
    Justification = 'Markdown templates'
)]
[CmdletBinding()]
param()

function Show-RepoList {
    <#
        .SYNOPSIS
        Displays a formatted list of repositories for a GitHub organization.

        .DESCRIPTION
        Connects to the specified GitHub organization, retrieves all repositories with their
        descriptions and custom Type property, then outputs a sorted table grouped by type and name.

        .EXAMPLE
        Show-RepoList

        Connects using the current repository's owner and prints a table of all repos with their type.

        .EXAMPLE
        Show-RepoList -Owner 'PSModule'

        Connects to the PSModule organization and prints a table of all repos with their type.
    #>
    [CmdletBinding()]
    param(
        # Name of the organization to connect to. Defaults to the owner of the current repository.
        [Parameter()]
        [string] $Owner = $env:GITHUB_REPOSITORY_OWNER
    )

    LogGroup "Connect to organization [$Owner]" {
        Connect-GitHubApp -Organization $Owner -Default
        Get-GitHubContext | Select-Object * | Format-List | Out-String
    }

    LogGroup "Get repositories for organization [$Owner]" {
        $rawRepos = Get-GitHubRepository -Owner $Owner -AdditionalProperty @(
            'description',
            'default_branch',
            'stargazers_count',
            'open_issues_count',
            'html_url'
        )
        Write-Output "Found $($rawRepos.Count) repositories"
        $repos = $rawRepos | ForEach-Object {
            $rawRepo = $_
            $rawRepo.CustomProperties | Where-Object { $_.Name -eq 'Type' } | ForEach-Object {
                $type = $_.Value
                [pscustomobject]@{
                    Name            = $rawRepo.Name
                    Owner           = $Owner
                    Type            = $type
                    Description     = $rawRepo.Description
                    DefaultBranch   = $rawRepo.DefaultBranch
                    Stars           = $rawRepo.StargazersCount
                    OpenIssuesCount = $rawRepo.OpenIssuesCount
                    HtmlUrl         = $rawRepo.HtmlUrl
                }
            }
        } | Sort-Object Type, Name
        $repos | Format-Table -AutoSize
    }

    $repos
}

function Update-MDSection {
    <#
        .SYNOPSIS
        Updates a specific section within a markdown file.

        .DESCRIPTION
        This function searches for a named section within a markdown file, identified by special comment markers.
        It replaces the content between the markers with the provided new content. If the markers are not found,
        an error is thrown. The function supports `-WhatIf` and `-Confirm` parameters for safety.

        .EXAMPLE
        Update-MDSection -Path '.\profile\README.md' -Name 'MODULE_LIST' -Content 'New module list'

        Output:
        ```powershell
        (No explicit output, but the markdown file section is updated)
        ```

        Updates the section named 'MODULE_LIST' in the specified markdown file with the provided content.
    #>
    [outputType([void])]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # Path to the markdown file where the section should be updated.
        [Parameter()]
        [string] $Path = 'src\docs\index.md',

        # Name of the section to be updated, used in comment markers.
        [Parameter()]
        [string] $Name = 'MODULE_LIST',

        # The new content to insert between the section markers.
        [Parameter()]
        [string] $Content
    )

    $startSegment = "<!-- $Name`_START -->"
    $endSegment = "<!-- $Name`_END -->"
    $currentContent = Get-Content -Path $Path
    $startIndex = $currentContent.IndexOf($startSegment)
    $endIndex = $currentContent.IndexOf($endSegment)

    if ($startIndex -lt 0) {
        throw "[$Name] The start comment segment was not found in the file."
    }
    if ($endIndex -lt 0) {
        throw "[$Name] The end comment segment was not found in the file."
    }
    if ($endIndex -lt $startIndex) {
        throw "[$Name] The end comment segment was found before the start comment segment."
    }

    $updatedContent = $currentContent[0..$startIndex] + $Content + $currentContent[($endIndex)..($currentContent.Length - 1)]
    if ($PSCmdlet.ShouldProcess('Readme section', 'Update')) {
        Set-Content -Path $Path -Value $updatedContent
    }
}

function Get-PropertyValue {
    [OutputType([object])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $InputObject,

        [Parameter(Mandatory)]
        [string[]] $Names,

        [Parameter()]
        [object] $Default = $null
    )

    foreach ($name in $Names) {
        $property = $InputObject.PSObject.Properties[$name]
        if ($null -eq $property) {
            continue
        }
        if ($null -eq $property.Value) {
            continue
        }
        $value = [string]$property.Value
        if ([string]::IsNullOrWhiteSpace($value)) {
            continue
        }
        return $property.Value
    }

    return $Default
}

function Invoke-GitHubApi {
    [OutputType([object])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Uri
    )

    try {
        Invoke-GitHubAPI -Method GET -Uri $Uri -ErrorAction Stop
    }
    catch {
        $statusCode = $null
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
        }
        if ($statusCode -eq 404) {
            return $null
        }

        Write-Warning "GitHub API call failed for [$Uri]: $($_.Exception.Message)"
        return $null
    }
}

function Get-RepositoryReadmeContent {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Owner,
        [Parameter(Mandatory)]
        [string] $Name
    )

    $uri = "https://api.github.com/repos/$Owner/$Name/readme"
    $response = Invoke-GitHubApi -Uri $uri
    if ($null -eq $response) {
        return ''
    }

    $encodedContent = Get-PropertyValue -InputObject $response -Names @('content')
    if ([string]::IsNullOrWhiteSpace([string]$encodedContent)) {
        return ''
    }

    $cleanContent = ([string]$encodedContent).Replace("`n", '').Replace("`r", '')
    [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($cleanContent))
}

function Get-MarkdownSummary {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Markdown
    )

    if ([string]::IsNullOrWhiteSpace($Markdown)) {
        return ''
    }

    $text = $Markdown
    $text = [regex]::Replace($text, '(?s)```.*?```', ' ')
    $text = [regex]::Replace($text, '(?m)^!\[[^\]]*\]\([^\)]*\)\s*$', '')
    $text = [regex]::Replace($text, '(?m)^#+\s+', '')
    $text = [regex]::Replace($text, '\[([^\]]+)\]\([^\)]+\)', '$1')
    $text = [regex]::Replace($text, '(?m)^\s*>+\s*', '')
    $text = [regex]::Replace($text, '[*_`~]', '')
    $text = [regex]::Replace($text, '\r?\n', "`n")

    foreach ($paragraph in ($text -split "`n`n")) {
        $candidate = [regex]::Replace($paragraph, '\s+', ' ').Trim()
        if (-not [string]::IsNullOrWhiteSpace($candidate)) {
            return $candidate
        }
    }

    ''
}

function ConvertTo-HtmlAttributeValue {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Value,
        [Parameter()]
        [int] $MaxLength = 160
    )

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return ''
    }

    $singleLine = [regex]::Replace($Value, '\s+', ' ').Trim()
    if ($singleLine.Length -gt $MaxLength) {
        $singleLine = $singleLine.Substring(0, $MaxLength - 1).TrimEnd() + '...'
    }

    $singleLine = $singleLine.Replace('&', '&amp;')
    $singleLine = $singleLine.Replace('"', '&quot;')
    $singleLine = $singleLine.Replace('<', '&lt;')
    $singleLine = $singleLine.Replace('>', '&gt;')
    $singleLine
}

function Get-OpenItemCount {
    [OutputType([int])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Owner,
        [Parameter(Mandatory)]
        [string] $Name,
        [Parameter(Mandatory)]
        [ValidateSet('issue', 'pr')]
        [string] $Type
    )

    $query = [uri]::EscapeDataString("repo:$Owner/$Name type:$Type state:open")
    $uri = "https://api.github.com/search/issues?q=$query&per_page=1"
    $response = Invoke-GitHubApi -Uri $uri
    if ($null -eq $response) {
        return 0
    }

    [int](Get-PropertyValue -InputObject $response -Names @('total_count') -Default 0)
}

function Get-RepositoryVersion {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Owner,
        [Parameter(Mandatory)]
        [string] $Name
    )

    $latestReleaseUri = "https://api.github.com/repos/$Owner/$Name/releases/latest"
    $latestRelease = Invoke-GitHubApi -Uri $latestReleaseUri
    if ($null -ne $latestRelease) {
        $releaseName = Get-PropertyValue -InputObject $latestRelease -Names @('tag_name', 'name')
        if (-not [string]::IsNullOrWhiteSpace([string]$releaseName)) {
            return [string]$releaseName
        }
    }

    $latestTagUri = "https://api.github.com/repos/$Owner/$Name/tags?per_page=1"
    $latestTags = Invoke-GitHubApi -Uri $latestTagUri
    if ($null -eq $latestTags -or $latestTags.Count -eq 0) {
        return 'N/A'
    }

    [string](Get-PropertyValue -InputObject $latestTags[0] -Names @('name') -Default 'N/A')
}

function Get-WorkflowReference {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Owner,
        [Parameter(Mandatory)]
        [string] $Name,
        [Parameter(Mandatory)]
        [string] $DefaultBranch
    )

    foreach ($workflowPath in @('.github/workflows/workflow.yml', '.github/workflows/workflow.yaml')) {
        $encodedRef = [uri]::EscapeDataString($DefaultBranch)
        $uri = "https://api.github.com/repos/$Owner/$Name/contents/$workflowPath?ref=$encodedRef"
        $response = Invoke-GitHubApi -Uri $uri
        if ($null -eq $response) {
            continue
        }

        $content = Get-PropertyValue -InputObject $response -Names @('content')
        if ([string]::IsNullOrWhiteSpace([string]$content)) {
            continue
        }

        $decoded = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String(([string]$content).Replace("`n", '').Replace("`r", '')))
        $match = [regex]::Match($decoded, '(?m)uses:\s*PSModule/Process-PSModule/.+?@(?<ref>[^\s#]+)')
        if ($match.Success) {
            return $match.Groups['ref'].Value
        }
    }

    'N/A'
}

function Get-ProcessReferenceStatus {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Reference,
        [Parameter()]
        [string] $LatestVersion
    )

    if ([string]::IsNullOrWhiteSpace($Reference) -or $Reference -eq 'N/A') {
        return 'not-configured'
    }

    if ($Reference -match '^[0-9a-f]{7,40}$') {
        return 'sha-pinned'
    }

    if ([string]::IsNullOrWhiteSpace($LatestVersion) -or $LatestVersion -eq 'N/A') {
        return 'unknown'
    }

    $referenceNormalized = $Reference.TrimStart('v')
    $latestNormalized = $LatestVersion.TrimStart('v')
    if ($referenceNormalized -eq $latestNormalized) {
        return 'up-to-date'
    }

    $referenceVersion = $null
    $latestVersionParsed = $null
    $hasReferenceVersion = [version]::TryParse(($referenceNormalized -replace '-.*$'), [ref]$referenceVersion)
    $hasLatestVersion = [version]::TryParse(($latestNormalized -replace '-.*$'), [ref]$latestVersionParsed)
    if ($hasReferenceVersion -and $hasLatestVersion) {
        if ($referenceVersion -lt $latestVersionParsed) {
            return 'behind'
        }
        return 'ahead'
    }

    'behind'
}

function New-ModuleCatalogPage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path,
        [Parameter(Mandatory)]
        [pscustomobject] $ModuleData
    )

    $content = @"
# $($ModuleData.Name)

> This page is generated from repository metadata by the docs index pipeline.

- Repository: [$($ModuleData.Owner)/$($ModuleData.Name)](https://github.com/$($ModuleData.Owner)/$($ModuleData.Name))
- Description: $($ModuleData.Description)
- Version: `$($ModuleData.Version)`
- Process-PSModule: `$($ModuleData.ProcessReference)` (`$($ModuleData.ProcessStatus)`)
- Open issues: [$($ModuleData.Issues)](https://github.com/$($ModuleData.Owner)/$($ModuleData.Name)/issues)
- Open PRs: [$($ModuleData.PullRequests)](https://github.com/$($ModuleData.Owner)/$($ModuleData.Name)/pulls)
- Stars: [$($ModuleData.Stars)](https://github.com/$($ModuleData.Owner)/$($ModuleData.Name)/stargazers)

## About

$($ModuleData.About)

## README

[View source README](https://github.com/$($ModuleData.Owner)/$($ModuleData.Name)#readme)
"@

    Set-Content -Path $Path -Value $content
}

function Update-ActionList {
    <#
        .SYNOPSIS
        Updates the GitHub Actions list section in the documentation.

        .DESCRIPTION
        Generates an HTML table of all GitHub Actions repositories from the module's repo list
        and updates the ACTION_LIST section in the GitHub Actions index markdown file.

        .EXAMPLE
        Update-ActionList

        Regenerates the action table and writes it to docs\GitHub-Actions\index.md.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $actionTableRowTemplate = @'
    <tr>
        <td><a href="https://github.com/{{ OWNER }}/{{ NAME }}/">{{ NAME_HYPHENED }}</a></td>
        <td>
            {{ DESCRIPTION }}
            <br>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/issues"><img src="https://img.shields.io/github/issues-raw/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIElzc3VlczwvdGl0bGU+PHBhdGggZD0iTTggOS41YTEuNSAxLjUgMCAxIDAgMC0zIDEuNSAxLjUgMCAwIDAgMCAzWiIgZmlsbD0iIzg0OEQ5NyIvPjxwYXRoIGQ9Ik04IDBhOCA4IDAgMSAxIDAgMTZBOCA4IDAgMCAxIDggMFpNMS41IDhhNi41IDYuNSAwIDEgMCAxMyAwIDYuNSA2LjUgMCAwIDAtMTMgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4=" alt="GitHub Issues"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/pulls"><img src="https://img.shields.io/github/issues-pr-raw/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFB1bGwgUmVxdWVzdHM8L3RpdGxlPjxwYXRoIGQ9Ik0xLjUgMy4yNWEyLjI1IDIuMjUgMCAxIDEgMyAyLjEyMnY1LjI1NmEyLjI1MSAyLjI1MSAwIDEgMS0xLjUgMFY1LjM3MkEyLjI1IDIuMjUgMCAwIDEgMS41IDMuMjVabTUuNjc3LS4xNzdMOS41NzMuNjc3QS4yNS4yNSAwIDAgMSAxMCAuODU0VjIuNWgxQTIuNSAyLjUgMCAwIDEgMTMuNSA1djUuNjI4YTIuMjUxIDIuMjUxIDAgMSAxLTEuNSAwVjVhMSAxIDAgMCAwLTEtMWgtMXYxLjY0NmEuMjUuMjUgMCAwIDEtLjQyNy4xNzdMNy4xNzcgMy40MjdhLjI1LjI1IDAgMCAxIDAtLjM1NFpNMy43NSAyLjVhLjc1Ljc1IDAgMSAwIDAgMS41Ljc1Ljc1IDAgMCAwIDAtMS41Wm0wIDkuNWEuNzUuNzUgMCAxIDAgMCAxLjUuNzUuNzUgMCAwIDAgMC0xLjVabTguMjUuNzVhLjc1Ljc1IDAgMSAwIDEuNSAwIC43NS43NSAwIDAgMC0xLjUgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4NCg==" alt="GitHub Pull Requests"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/stargazers"><img src="https://img.shields.io/github/stars/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFN0YXJzPC90aXRsZT48cGF0aCBkPSJNOCAuMjVhLjc1Ljc1IDAgMCAxIC42NzMuNDE4bDEuODgyIDMuODE1IDQuMjEuNjEyYS43NS43NSAwIDAgMSAuNDE2IDEuMjc5bC0zLjA0NiAyLjk3LjcxOSA0LjE5MmEuNzUxLjc1MSAwIDAgMS0xLjA4OC43OTFMOCAxMi4zNDdsLTMuNzY2IDEuOThhLjc1Ljc1IDAgMCAxLTEuMDg4LS43OWwuNzItNC4xOTRMLjgxOCA2LjM3NGEuNzUuNzUgMCAwIDEgLjQxNi0xLjI4bDQuMjEtLjYxMUw3LjMyNy42NjhBLjc1Ljc1IDAgMCAxIDggLjI1Wm0wIDIuNDQ1TDYuNjE1IDUuNWEuNzUuNzUgMCAwIDEtLjU2NC40MWwtMy4wOTcuNDUgMi4yNCAyLjE4NGEuNzUuNzUgMCAwIDEgLjIxNi42NjRsLS41MjggMy4wODQgMi43NjktMS40NTZhLjc1Ljc1IDAgMCAxIC42OTggMGwyLjc3IDEuNDU2LS41My0zLjA4NGEuNzUuNzUgMCAwIDEgLjIxNi0uNjY0bDIuMjQtMi4xODMtMy4wOTYtLjQ1YS43NS43NSAwIDAgMS0uNTY0LS40MUw4IDIuNjk0WiIgZmlsbD0iIzg0OEQ5NyIvPjwvc3ZnPg==" alt="GitHub Stars"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/watchers"><img src="https://img.shields.io/github/watchers/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFRhZ3M8L3RpdGxlPjxwYXRoIGQ9Ik04IDJjMS45ODEgMCAzLjY3MS45OTIgNC45MzMgMi4wNzggMS4yNyAxLjA5MSAyLjE4NyAyLjM0NSAyLjYzNyAzLjAyM2ExLjYyIDEuNjIgMCAwIDEgMCAxLjc5OGMtLjQ1LjY3OC0xLjM2NyAxLjkzMi0yLjYzNyAzLjAyM0MxMS42NyAxMy4wMDggOS45ODEgMTQgOCAxNGMtMS45ODEgMC0zLjY3MS0uOTkyLTQuOTMzLTIuMDc4QzEuNzk3IDEwLjgzLjg4IDkuNTc2LjQzIDguODk4YTEuNjIgMS42MiAwIDAgMSAwLTEuNzk4Yy40NS0uNjc3IDEuMzY3LTEuOTMxIDIuNjM3LTMuMDIyQzQuMzMgMi45OTIgNi4wMTkgMiA4IDJaTTEuNjc5IDcuOTMyYS4xMi4xMiAwIDAgMCAwIC4xMzZjLjQxMS42MjIgMS4yNDEgMS43NSAyLjM2NiAyLjcxN0M1LjE3NiAxMS43NTggNi41MjcgMTIuNSA4IDEyLjVjMS40NzMgMCAyLjgyNS0uNzQyIDMuOTU1LTEuNzE1IDEuMTI0LS45NjcgMS45NTQtMi4wOTYgMi4zNjYtMi43MTdhLjEyLjEyIDAgMCAwIDAtLjEzNmMtLjQxMi0uNjIxLTEuMjQyLTEuNzUtMi4zNjYtMi43MTdDMTAuODI0IDQuMjQyIDkuNDczIDMuNSA4IDMuNWMtMS40NzMgMC0yLjgyNS43NDItMy45NTUgMS43MTUtMS4xMjQuOTY3LTEuOTU0IDIuMDk2LTIuMzY2IDIuNzE3Wk04IDEwYTIgMiAwIDEgMS0uMDAxLTMuOTk5QTIgMiAwIDAgMSA4IDEwWiIgZmlsbD0iIzg0OEQ5NyIvPjwvc3ZnPg==" alt="GitHub Watchers"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/forks"><img src="https://img.shields.io/github/forks/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIEZvcmtzPC90aXRsZT48cGF0aCBkPSJNNSA1LjM3MnYuODc4YzAgLjQxNC4zMzYuNzUuNzUuNzVoNC41YS43NS43NSAwIDAgMCAuNzUtLjc1di0uODc4YTIuMjUgMi4yNSAwIDEgMSAxLjUgMHYuODc4YTIuMjUgMi4yNSAwIDAgMS0yLjI1IDIuMjVoLTEuNXYyLjEyOGEyLjI1MSAyLjI1MSAwIDEgMS0xLjUgMFY4LjVoLTEuNUEyLjI1IDIuMjUgMCAwIDEgMy41IDYuMjV2LS44NzhhMi4yNSAyLjI1IDAgMSAxIDEuNSAwWk01IDMuMjVhLjc1Ljc1IDAgMSAwLTEuNSAwIC43NS43NSAwIDAgMCAxLjUgMFptNi43NS43NWEuNzUuNzUgMCAxIDAgMC0xLjUuNzUuNzUgMCAwIDAgMCAxLjVabS0zIDguNzVhLjc1Ljc1IDAgMSAwLTEuNSAwIC43NS43NSAwIDAgMCAxLjUgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4=" alt="GitHub Forks"></a>
        </td>
        <td>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/releases/latest"><img src="https://img.shields.io/github/v/release/{{ OWNER }}/{{ NAME }}?style=flat-square&logo=github&logoColor=a0a0a0&label=&labelColor=505050&color=blue" alt="GitHub release (with filter)"></a>
        </td>
    </tr>
'@
    $actionTableRows = ''
    $repos | Where-Object { $_.Type -eq 'Action' } | ForEach-Object {
        $name_hyphened = ($_.Name).Replace('-', '&#8209;')
        $actionTableRow = $actionTableRowTemplate.replace('{{ OWNER }}', $_.Owner)
        $actionTableRow = $actionTableRow.replace('{{ NAME }}', $_.Name)
        $actionTableRow = $actionTableRow.replace('{{ NAME_HYPHENED }}', $name_hyphened)
        $actionTableRow = $actionTableRow.replace('{{ DESCRIPTION }}', $_.Description)
        $actionTableRow = $actionTableRow.TrimEnd()
        $actionTableRow += [Environment]::NewLine
        $actionTableRows += $actionTableRow
    }
    $actionTable = @"

<table>
    <tr>
        <th width="10%">Name</th>
        <th width="80%">Description</th>
        <th width="10%">Version</th>
    </tr>
$actionTableRows</table>

"@
    Update-MDSection -Path '.\src\docs\GitHub-Actions\index.md' -Name 'ACTION_LIST' -Content $actionTable
}

function Update-ModuleList {
    <#
        .SYNOPSIS
        Updates the PowerShell modules list section in the documentation.

        .DESCRIPTION
        Generates an enriched HTML table for PSModule module repositories and writes
        repository-specific catalog pages that summarize README and module metadata.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter()]
        [object[]] $Repos = @()
    )

    if ($Repos.Count -eq 0) {
        $Repos = Show-RepoList
    }

    $moduleRepos = $Repos | Where-Object {
        $_.Type -eq 'Module' -and $_.Owner -eq 'PSModule'
    } | Sort-Object Name

    $catalogFolderPath = Join-Path 'src\docs\Modules\Catalog' 'Repositories'
    if (-not (Test-Path $catalogFolderPath)) {
        New-Item -Path $catalogFolderPath -ItemType Directory | Out-Null
    }

    $processLatestVersion = Get-RepositoryVersion -Owner 'PSModule' -Name 'Process-PSModule'
    $moduleTableRows = ''

    foreach ($repo in $moduleRepos) {
        $owner = [string](Get-PropertyValue -InputObject $repo -Names @('Owner') -Default 'PSModule')
        $name = [string](Get-PropertyValue -InputObject $repo -Names @('Name') -Default '')
        if ([string]::IsNullOrWhiteSpace($name)) {
            continue
        }

        $description = [string](Get-PropertyValue -InputObject $repo -Names @('Description') -Default 'No description available.')
        if ([string]::IsNullOrWhiteSpace($description)) {
            $description = 'No description available.'
        }

        $defaultBranch = [string](Get-PropertyValue -InputObject $repo -Names @('DefaultBranch', 'default_branch') -Default 'main')
        if ([string]::IsNullOrWhiteSpace($defaultBranch)) {
            $defaultBranch = 'main'
        }

        $readmeContent = Get-RepositoryReadmeContent -Owner $owner -Name $name
        $aboutSummary = Get-MarkdownSummary -Markdown $readmeContent
        if ([string]::IsNullOrWhiteSpace($aboutSummary)) {
            $aboutSummary = $description
        }

        $titleSummary = ConvertTo-HtmlAttributeValue -Value $aboutSummary
        $version = Get-RepositoryVersion -Owner $owner -Name $name
        $processReference = Get-WorkflowReference -Owner $owner -Name $name -DefaultBranch $defaultBranch
        $processStatus = Get-ProcessReferenceStatus -Reference $processReference -LatestVersion $processLatestVersion
        $issues = Get-OpenItemCount -Owner $owner -Name $name -Type issue
        $pullRequests = Get-OpenItemCount -Owner $owner -Name $name -Type pr
        $stars = [int](Get-PropertyValue -InputObject $repo -Names @('Stars', 'stargazers_count', 'StargazersCount') -Default 0)

        $modulePageFileName = "$name.md"
        $modulePagePath = Join-Path $catalogFolderPath $modulePageFileName
        $modulePageRelativeLink = "./Repositories/$modulePageFileName"

        $moduleData = [pscustomobject]@{
            Owner            = $owner
            Name             = $name
            Description      = $description
            Version          = $version
            ProcessReference = $processReference
            ProcessStatus    = $processStatus
            Issues           = $issues
            PullRequests     = $pullRequests
            Stars            = $stars
            About            = $aboutSummary
        }
        New-ModuleCatalogPage -Path $modulePagePath -ModuleData $moduleData

        $moduleTableRows += @"
    <tr>
        <td><a href="$modulePageRelativeLink" title="$titleSummary">$name</a></td>
        <td><code>$version</code></td>
        <td><code>$processReference</code><br><sub>$processStatus</sub></td>
        <td><a href="https://github.com/$owner/$name/issues">$issues</a></td>
        <td><a href="https://github.com/$owner/$name/pulls">$pullRequests</a></td>
        <td><a href="https://github.com/$owner/$name/stargazers">$stars</a></td>
    </tr>
"@
    }

    $moduleTable = @"

<table>
    <tr>
        <th width="24%">Name</th>
        <th width="12%">Version</th>
        <th width="24%">ProcessVersion</th>
        <th width="10%">Issues</th>
        <th width="10%">PRs</th>
        <th width="10%">Stars</th>
    </tr>
$moduleTableRows</table>

"@

    Update-MDSection -Path '.\src\docs\Modules\Catalog\index.md' -Name 'MODULE_CATALOG' -Content $moduleTable
}

function Update-FunctionAppList {
    <#
        .SYNOPSIS
        Updates the Azure Function Apps list section in the documentation.

        .DESCRIPTION
        Generates an HTML table of all Azure Function App repositories from the module's repo list
        and updates the FUNCTIONAPP_LIST section in the PowerShell FunctionApps index markdown file.

        .EXAMPLE
        Update-FunctionAppList

        Regenerates the function app table and writes it to docs\PowerShell\FunctionApps\index.md.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $functionAppTableRowTemplate = @'
    <tr>
        <td><a href="https://github.com/{{ OWNER }}/{{ NAME }}/">{{ NAME_HYPHENED }}</a></td>
        <td>
            {{ DESCRIPTION }}
            <br>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/issues"><img src="https://img.shields.io/github/issues-raw/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIElzc3VlczwvdGl0bGU+PHBhdGggZD0iTTggOS41YTEuNSAxLjUgMCAxIDAgMC0zIDEuNSAxLjUgMCAwIDAgMCAzWiIgZmlsbD0iIzg0OEQ5NyIvPjxwYXRoIGQ9Ik04IDBhOCA4IDAgMSAxIDAgMTZBOCA4IDAgMCAxIDggMFpNMS41IDhhNi41IDYuNSAwIDEgMCAxMyAwIDYuNSA2LjUgMCAwIDAtMTMgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4=" alt="GitHub Issues"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/pulls"><img src="https://img.shields.io/github/issues-pr-raw/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFB1bGwgUmVxdWVzdHM8L3RpdGxlPjxwYXRoIGQ9Ik0xLjUgMy4yNWEyLjI1IDIuMjUgMCAxIDEgMyAyLjEyMnY1LjI1NmEyLjI1MSAyLjI1MSAwIDEgMS0xLjUgMFY1LjM3MkEyLjI1IDIuMjUgMCAwIDEgMS41IDMuMjVabTUuNjc3LS4xNzdMOS41NzMuNjc3QS4yNS4yNSAwIDAgMSAxMCAuODU0VjIuNWgxQTIuNSAyLjUgMCAwIDEgMTMuNSA1djUuNjI4YTIuMjUxIDIuMjUxIDAgMSAxLTEuNSAwVjVhMSAxIDAgMCAwLTEtMWgtMXYxLjY0NmEuMjUuMjUgMCAwIDEtLjQyNy4xNzdMNy4xNzcgMy40MjdhLjI1LjI1IDAgMCAxIDAtLjM1NFpNMy43NSAyLjVhLjc1Ljc1IDAgMSAwIDAgMS41Ljc1Ljc1IDAgMCAwIDAtMS41Wm0wIDkuNWEuNzUuNzUgMCAxIDAgMCAxLjUuNzUuNzUgMCAwIDAgMC0xLjVabTguMjUuNzVhLjc1Ljc1IDAgMSAwIDEuNSAwIC43NS43NSAwIDAgMC0xLjUgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4NCg==" alt="GitHub Pull Requests"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/stargazers"><img src="https://img.shields.io/github/stars/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFN0YXJzPC90aXRsZT48cGF0aCBkPSJNOCAuMjVhLjc1Ljc1IDAgMCAxIC42NzMuNDE4bDEuODgyIDMuODE1IDQuMjEuNjEyYS43NS43NSAwIDAgMSAuNDE2IDEuMjc5bC0zLjA0NiAyLjk3LjcxOSA0LjE5MmEuNzUxLjc1MSAwIDAgMS0xLjA4OC43OTFMOCAxMi4zNDdsLTMuNzY2IDEuOThhLjc1Ljc1IDAgMCAxLTEuMDg4LS43OWwuNzItNC4xOTRMLjgxOCA2LjM3NGEuNzUuNzUgMCAwIDEgLjQxNi0xLjI4bDQuMjEtLjYxMUw3LjMyNy42NjhBLjc1Ljc1IDAgMCAxIDggLjI1Wm0wIDIuNDQ1TDYuNjE1IDUuNWEuNzUuNzUgMCAwIDEtLjU2NC40MWwtMy4wOTcuNDUgMi4yNCAyLjE4NGEuNzUuNzUgMCAwIDEgLjIxNi42NjRsLS41MjggMy4wODQgMi43NjktMS40NTZhLjc1Ljc1IDAgMCAxIC42OTggMGwyLjc3IDEuNDU2LS41My0zLjA4NGEuNzUuNzUgMCAwIDEgLjIxNi0uNjY0bDIuMjQtMi4xODMtMy4wOTYtLjQ1YS43NS43NSAwIDAgMS0uNTY0LS40MUw4IDIuNjk0WiIgZmlsbD0iIzg0OEQ5NyIvPjwvc3ZnPg==" alt="GitHub Stars"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/watchers"><img src="https://img.shields.io/github/watchers/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFRhZ3M8L3RpdGxlPjxwYXRoIGQ9Ik04IDJjMS45ODEgMCAzLjY3MS45OTIgNC45MzMgMi4wNzggMS4yNyAxLjA5MSAyLjE4NyAyLjM0NSAyLjYzNyAzLjAyM2ExLjYyIDEuNjIgMCAwIDEgMCAxLjc5OGMtLjQ1LjY3OC0xLjM2NyAxLjkzMi0yLjYzNyAzLjAyM0MxMS42NyAxMy4wMDggOS45ODEgMTQgOCAxNGMtMS45ODEgMC0zLjY3MS0uOTkyLTQuOTMzLTIuMDc4QzEuNzk3IDEwLjgzLjg4IDkuNTc2LjQzIDguODk4YTEuNjIgMS42MiAwIDAgMSAwLTEuNzk4Yy40NS0uNjc3IDEuMzY3LTEuOTMxIDIuNjM3LTMuMDIyQzQuMzMgMi45OTIgNi4wMTkgMiA4IDJaTTEuNjc5IDcuOTMyYS4xMi4xMiAwIDAgMCAwIC4xMzZjLjQxMS42MjIgMS4yNDEgMS43NSAyLjM2NiAyLjcxN0M1LjE3NiAxMS43NTggNi41MjcgMTIuNSA4IDEyLjVjMS40NzMgMCAyLjgyNS0uNzQyIDMuOTU1LTEuNzE1IDEuMTI0LS45NjcgMS45NTQtMi4wOTYgMi4zNjYtMi43MTdhLjEyLjEyIDAgMCAwIDAtLjEzNmMtLjQxMi0uNjIxLTEuMjQyLTEuNzUtMi4zNjYtMi43MTdDMTAuODI0IDQuMjQyIDkuNDczIDMuNSA4IDMuNWMtMS40NzMgMC0yLjgyNS43NDItMy45NTUgMS43MTUtMS4xMjQuOTY3LTEuOTU0IDIuMDk2LTIuMzY2IDIuNzE3Wk04IDEwYTIgMiAwIDEgMS0uMDAxLTMuOTk5QTIgMiAwIDAgMSA4IDEwWiIgZmlsbD0iIzg0OEQ5NyIvPjwvc3ZnPg==" alt="GitHub Watchers"></a>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/forks"><img src="https://img.shields.io/github/forks/{{ OWNER }}/{{ NAME }}?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIEZvcmtzPC90aXRsZT48cGF0aCBkPSJNNSA1LjM3MnYuODc4YzAgLjQxNC4zMzYuNzUuNzUuNzVoNC41YS43NS43NSAwIDAgMCAuNzUtLjc1di0uODc4YTIuMjUgMi4yNSAwIDEgMSAxLjUgMHYuODc4YTIuMjUgMi4yNSAwIDAgMS0yLjI1IDIuMjVoLTEuNXYyLjEyOGEyLjI1MSAyLjI1MSAwIDEgMS0xLjUgMFY4LjVoLTEuNUEyLjI1IDIuMjUgMCAwIDEgMy41IDYuMjV2LS44NzhhMi4yNSAyLjI1IDAgMSAxIDEuNSAwWk01IDMuMjVhLjc1Ljc1IDAgMSAwLTEuNSAwIC43NS43NSAwIDAgMCAxLjUgMFptNi43NS43NWEuNzUuNzUgMCAxIDAgMC0xLjUuNzUuNzUgMCAwIDAgMCAxLjVabS0zIDguNzVhLjc1Ljc1IDAgMSAwLTEuNSAwIC43NS43NSAwIDAgMCAxLjUgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4=" alt="GitHub Forks"></a>
        </td>
        <td>
            <a href="https://github.com/{{ OWNER }}/{{ NAME }}/releases/latest"><img src="https://img.shields.io/github/v/release/{{ OWNER }}/{{ NAME }}?style=flat-square&logo=github&logoColor=a0a0a0&label=&labelColor=505050&color=blue" alt="GitHub release (with filter)"></a>
        </td>
    </tr>
'@
    $functionAppTableRows = ''
    $repos | Where-Object { $_.Type -eq 'FunctionApp' } | ForEach-Object {
        $name_hyphened = ($_.Name).Replace('-', '&#8209;')
        $functionAppTableRow = $functionAppTableRowTemplate.replace('{{ OWNER }}', $_.Owner)
        $functionAppTableRow = $functionAppTableRow.replace('{{ NAME }}', $_.Name)
        $functionAppTableRow = $functionAppTableRow.replace('{{ NAME_HYPHENED }}', $name_hyphened)
        $functionAppTableRow = $functionAppTableRow.replace('{{ DESCRIPTION }}', $_.Description)
        $functionAppTableRow = $functionAppTableRow.TrimEnd()
        $functionAppTableRow += [Environment]::NewLine
        $functionAppTableRows += $functionAppTableRow
    }
    $functionAppTable = @"

<table>
    <tr>
        <th width="10%">Name</th>
        <th width="80%">Description</th>
        <th width="10%">Version</th>
    </tr>
$functionAppTableRows</table>

"@

    Update-MDSection -Path '.\src\docs\PowerShell\FunctionApps\index.md' -Name 'FUNCTIONAPP_LIST' -Content $functionAppTable
}
