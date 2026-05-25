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
        [string] $Path = 'docs\index.md',

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

function Invoke-GitCommit {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Message = 'Auto-generated changes'
    )
    git add .
    git commit -m $Message
    git push
}
