---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUserFollowing

## SYNOPSIS
List the people a given user or the authenticated user follows

## SYNTAX

```powershell
Get-GitHubUserFollowing [[-Username] <String>] [[-PerPage] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the people who a given user or the authenticated user follows.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubUserFollowing
```

Gets all people the authenticated user follows.

### EXAMPLE 2
```powershell
Get-GitHubUserFollowing -Username 'octocat'
```

Gets all people that 'octocat' follows.

## PARAMETERS

### -Username
The handle for the GitHub user account.

```yaml
Type: String
Parameter Sets: (All)
Aliases: login

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

### System.Management.Automation.PSObject
## NOTES
[List the people the authenticated user follows](https://docs.github.com/rest/users/followers#list-the-people-the-authenticated-user-follows)
[List the people a user follows](https://docs.github.com/rest/users/followers#list-the-people-a-user-follows)

## RELATED LINKS

