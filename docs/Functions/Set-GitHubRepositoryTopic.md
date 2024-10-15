---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Set-GitHubRepositoryTopic

## SYNOPSIS
Replace all repository topics

## SYNTAX

```powershell
Set-GitHubRepositoryTopic [[-Owner] <String>] [[-Repo] <String>] [[-Names] <String[]>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replace all repository topics

## EXAMPLES

### EXAMPLE 1
```powershell
Set-GitHubRepositoryTopic -Owner 'octocat' -Repo 'hello-world' -Names 'octocat', 'octo', 'octocat/hello-world'
```

Replaces all topics for the repository 'octocat/hello-world' with the topics 'octocat', 'octo', 'octocat/hello-world'.

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

### -Names
The number of results per page (max 100).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Topics

Required: False
Position: 3
Default value: @()
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

## NOTES
[Replace all repository topics](https://docs.github.com/rest/repos/repos#replace-all-repository-topics)

## RELATED LINKS
