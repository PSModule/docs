---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Test-GitHubUserFollowing

## SYNOPSIS
Check if a given user or the authenticated user follows a person

## SYNTAX

```powershell
Test-GitHubUserFollowing [-Follows] <String> [-Username] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a 204 if the given user or the authenticated user follows another user.
Returns a 404 if the user is not followed by a given user or the authenticated user.

## EXAMPLES

### EXAMPLE 1
```powershell
Test-GitHubUserFollowing -Follows 'octocat'
Test-GitHubUserFollowing 'octocat'
```

Checks if the authenticated user follows the user 'octocat'.

### EXAMPLE 2
```powershell
Test-GitHubUserFollowing -Username 'octocat' -Follows 'ratstallion'
```

Checks if the user 'octocat' follows the user 'ratstallion'.

## PARAMETERS

### -Follows
The handle for the GitHub user account we want to check if is being followed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Username
The handle for the GitHub user account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Boolean
## NOTES
[Check if a person is followed by the authenticated user](https://docs.github.com/rest/users/followers#check-if-a-person-is-followed-by-the-authenticated-user)
[Check if a user follows another user](https://docs.github.com/rest/users/followers#check-if-a-user-follows-another-user)

## RELATED LINKS

