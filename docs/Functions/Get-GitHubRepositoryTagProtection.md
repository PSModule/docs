---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryTagProtection

## SYNOPSIS
List tag protection states for a repository

## SYNTAX

```powershell
Get-GitHubRepositoryTagProtection [[-Owner] <String>] [[-Repo] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This returns the tag protection states of a repository.

This information is only available to repository administrators.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepositoryTagProtection -Owner 'octocat' -Repo 'hello-world'
```

Gets the tag protection states of the 'hello-world' repository.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: org

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
[List tag protection states for a repository](https://docs.github.com/rest/repos/tags#list-tag-protection-states-for-a-repository)

## RELATED LINKS

