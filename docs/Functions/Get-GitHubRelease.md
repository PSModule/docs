---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRelease

## SYNOPSIS
List releases

## SYNTAX

### All (Default)
```powershell
Get-GitHubRelease [-Owner <String>] [-Repo <String>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Latest
```powershell
Get-GitHubRelease [-Owner <String>] [-Repo <String>] [-Latest] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Tag
```powershell
Get-GitHubRelease [-Owner <String>] [-Repo <String>] -Tag <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ID
```powershell
Get-GitHubRelease [-Owner <String>] [-Repo <String>] -ID <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This returns a list of releases, which does not include regular Git tags that have not been associated with a release.
To get a list of Git tags, use the [Repository Tags API](https://docs.github.com/rest/repos/repos#list-repository-tags).
Information about published releases are available to everyone.
Only users with push access will receive listings for draft releases.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRelease -Owner 'octocat' -Repo 'hello-world'
```

Gets the releases for the repository 'hello-world' owned by 'octocat'.

### EXAMPLE 2
```powershell
Get-GitHubRelease -Owner 'octocat' -Repo 'hello-world' -Latest
```

Gets the latest releases for the repository 'hello-world' owned by 'octocat'.

### EXAMPLE 3
```powershell
Get-GitHubRelease -Owner 'octocat' -Repo 'hello-world' -Tag 'v1.0.0'
```

Gets the release with the tag 'v1.0.0' for the repository 'hello-world' owned by 'octocat'.

### EXAMPLE 4
```powershell
Get-GitHubRelease -Owner 'octocat' -Repo 'hello-world' -ID '1234567'
```

Gets the release with the ID '1234567' for the repository 'hello-world' owned by 'octocat'.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -Latest
Get the latest release only

```yaml
Type: SwitchParameter
Parameter Sets: Latest
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
The name of the tag to get a release from.

```yaml
Type: String
Parameter Sets: Tag
Aliases: tag_name

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
The unique identifier of the release.

```yaml
Type: String
Parameter Sets: ID
Aliases: release_id

Required: True
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

## NOTES
[List releases](https://docs.github.com/rest/releases/releases#list-releases)
[Get the latest release](https://docs.github.com/rest/releases/releases#get-the-latest-release)

## RELATED LINKS

