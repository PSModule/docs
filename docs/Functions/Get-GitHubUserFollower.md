---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUserFollower

## SYNOPSIS
List followers of a given user or the authenticated user

## SYNTAX

```powershell
Get-GitHubUserFollower [[-Username] <String>] [[-PerPage] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the people following a given user or the authenticated user.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubUserFollower
```

Gets all followers of the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubUserFollower -Username 'octocat'
```

Gets all followers of the user 'octocat'.

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
[List followers of the authenticated user](https://docs.github.com/rest/users/followers#list-followers-of-the-authenticated-user)

## RELATED LINKS

