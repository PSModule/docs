---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Move-GitHubRepository

## SYNOPSIS
Transfer a repository

## SYNTAX

```powershell
Move-GitHubRepository [[-Owner] <String>] [[-Repo] <String>] [-NewOwner] <String> [[-NewName] <String>]
 [[-TeamIds] <Int32[]>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A transfer request will need to be accepted by the new owner when transferring a personal repository to another user.
The response will contain the original `owner`, and the transfer will continue asynchronously.
For more details on
the requirements to transfer personal and organization-owned repositories, see
[about repository transfers](https://docs.github.com/articles/about-repository-transfers/).
You must use a personal access token (classic) or an OAuth token for this endpoint.
An installation access token or
a fine-grained personal access token cannot be used because they are only granted access to a single account.

## EXAMPLES

### EXAMPLE 1
```powershell
Move-GitHubRepository -Owner 'PSModule' -Repo 'GitHub' -NewOwner 'GitHub' -NewName 'PowerShell'
```

Moves the GitHub repository to the PSModule organization and renames it to GitHub.

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

### -NewOwner
The username or organization name the repository will be transferred to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: new_owner

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewName
The new name to be given to the repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases: new_name

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TeamIds
ID of the team or teams to add to the repository.
Teams can only be added to organization-owned repositories.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: team_ids

Required: False
Position: 5
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
[Transfer a repository](https://docs.github.com/rest/repos/repos#transfer-a-repository)

## RELATED LINKS

