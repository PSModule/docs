---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryFork

## SYNOPSIS
List forks

## SYNTAX

```powershell
Get-GitHubRepositoryFork [[-Owner] <String>] [[-Repo] <String>] [[-Sort] <String>] [[-PerPage] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
List forks of a named repository.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepositoryFork -Owner 'octocat' -Repo 'Hello-World'
```

List forks of the 'Hello-World' repository owned by 'octocat'.

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

### -Sort
The direction to sort the results by.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Newest
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: per_page

Required: False
Position: 4
Default value: 30
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
[List forks](https://docs.github.com/rest/repos/forks#list-forks)

## RELATED LINKS

