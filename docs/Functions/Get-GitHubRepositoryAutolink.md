---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryAutolink

## SYNOPSIS
List all autolinks of a repository

## SYNTAX

### Default (Default)
```powershell
Get-GitHubRepositoryAutolink [-Owner <String>] [-Repo <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ById
```powershell
Get-GitHubRepositoryAutolink [-Owner <String>] [-Repo <String>] -AutolinkId <Int32>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This returns a list of autolinks configured for the given repository.

Information about autolinks are only available to repository administrators.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepositoryAutolink -Owner 'octocat' -Repo 'Hello-World'
```

Gets all autolinks for the repository 'Hello-World' owned by 'octocat'.

### EXAMPLE 2
```powershell
Get-GitHubRepositoryAutolink -Owner 'octocat' -Repo 'Hello-World' -ID 1
```

Gets the autolink with the ID 1 for the repository 'Hello-World' owned by 'octocat'.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: org

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

### -AutolinkId
The unique identifier of the autolink.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: ID, autolink_id

Required: True
Position: Named
Default value: 0
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
[Get all autolinks of a repository](https://docs.github.com/rest/repos/autolinks#list-all-autolinks-of-a-repository)

## RELATED LINKS

