---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryTeam

## SYNOPSIS
List repository teams

## SYNTAX

```powershell
Get-GitHubRepositoryTeam [[-Owner] <String>] [[-Repo] <String>] [[-PerPage] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists the teams that have access to the specified repository and that are also visible to the authenticated user.

For a public repository, a team is listed only if that team added the public repository explicitly.

Personal access tokens require the following scopes:
* `public_repo` to call this endpoint on a public repository
* `repo` to call this endpoint on a private repository (this scope also includes public repositories)

This endpoint is not compatible with fine-grained personal access tokens.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepositoryTeam -Owner 'PSModule' -Repo 'GitHub'
```

Lists the teams that have access to the specified repository and that are also visible to the authenticated user.

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
[List repository teams](https://docs.github.com/rest/repos/repos#list-repository-teams)

## RELATED LINKS

