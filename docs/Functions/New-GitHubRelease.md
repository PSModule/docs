---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# New-GitHubRelease

## SYNOPSIS
Create a release

## SYNTAX

```powershell
New-GitHubRelease [[-Owner] <String>] [[-Repo] <String>] [-TagName] <String> [[-TargetCommitish] <String>]
 [[-Name] <String>] [[-Body] <String>] [-Draft] [-Prerelease] [[-DiscussionCategoryName] <String>]
 [-GenerateReleaseNotes] [[-MakeLatest] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Users with push access to the repository can create a release.
This endpoint triggers [notifications](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/about-notifications).
Creating content too quickly using this endpoint may result in secondary rate limiting.
See "[Secondary rate limits](https://docs.github.com/rest/overview/resources-in-the-rest-api#secondary-rate-limits)"
and "[Dealing with secondary rate limits](https://docs.github.com/rest/guides/best-practices-for-integrators#dealing-with-secondary-rate-limits)" for details.

## EXAMPLES

### EXAMPLE 1
```powershell
New-GitHubRelease -Owner 'octocat' -Repo 'hello-world' -TagName 'v1.0.0' -TargetCommitish 'main' -Body 'Release notes'
```

Creates a release for the repository 'octocat/hello-world' with the tag 'v1.0.0' and the target commitish 'main'.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-GitHubConfig -Name Owner)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repo
The name of the repository without the .git extension.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -TagName
The name of the tag.

```yaml
Type: String
Parameter Sets: (All)
Aliases: tag_name

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetCommitish
Specifies the commitish value that determines where the Git tag is created from.
Can be any branch or commit SHA.
Unused if the Git tag already exists.
API Default: the repository's default branch.

```yaml
Type: String
Parameter Sets: (All)
Aliases: target_commitish

Required: False
Position: 4
Default value: Main
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
Text describing the contents of the tag.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Draft
Whether the release is a draft.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prerelease
Whether to identify the release as a prerelease.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiscussionCategoryName
If specified, a discussion of the specified category is created and linked to the release.
The value must be a category that already exists in the repository.
For more information, see [Managing categories for discussions in your repository](https://docs.github.com/discussions/managing-discussions-for-your-community/managing-categories-for-discussions-in-your-repository).

```yaml
Type: String
Parameter Sets: (All)
Aliases: discussion_category_name

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateReleaseNotes
Whether to automatically generate the name and body for this release.
If name is specified, the specified name will be used; otherwise,a name will be automatically generated.
If body is specified, the body will be pre-pended to the automatically generated notes.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: generate_release_notes

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MakeLatest
Specifies whether this release should be set as the latest release for the repository.
Drafts and prereleases cannot be set as latest.
Defaults to true for newly published releases.
legacy specifies that the latest release should be determined based on the release creation date and higher semantic version.

```yaml
Type: String
Parameter Sets: (All)
Aliases: make_latest

Required: False
Position: 8
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject
## NOTES
[Create a release](https://docs.github.com/rest/releases/releases#create-a-release)

## RELATED LINKS

