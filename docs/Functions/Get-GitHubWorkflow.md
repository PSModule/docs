---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubWorkflow

## SYNOPSIS
Lists the workflows in a repository.

## SYNTAX

```powershell
Get-GitHubWorkflow [[-Owner] <String>] [[-Repo] <String>] [[-PerPage] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Anyone with read access to the repository can use this endpoint.
If the repository is private you must use an access token with the repo scope.
GitHub Apps must have the actions:read permission to use this endpoint.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubWorkflow -Owner 'octocat' -Repo 'hello-world'
```

Gets all workflows in the 'octocat/hello-world' repository.

### EXAMPLE 2
```powershell
Get-GitHubWorkflow -Owner 'octocat' -Repo 'hello-world' -Name 'hello-world.yml'
```

Gets the 'hello-world.yml' workflow in the 'octocat/hello-world' repository.

## PARAMETERS

### -Owner
{{ Fill Owner Description }}

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
{{ Fill Repo Description }}

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

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
[List repository workflows](https://docs.github.com/rest/actions/workflows?apiVersion=2022-11-28#list-repository-workflows)

## RELATED LINKS

