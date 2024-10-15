---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Test-GitHubBlockedUser

## SYNOPSIS
Check if a user is blocked by the authenticated user or an organization.

## SYNTAX

```powershell
Test-GitHubBlockedUser [-Username] <String> [[-OrganizationName] <String>] [[-PerPage] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns a 204 if the given user is blocked by the authenticated user or organization.
Returns a 404 if the given user is not blocked, or if the given user account has been identified as spam by GitHub.

## EXAMPLES

### EXAMPLE 1
```powershell
Test-GitHubBlockedUser -Username 'octocat'
```

Checks if the user `octocat` is blocked by the authenticated user.
Returns true if the user is blocked, false if not.

### EXAMPLE 2
```powershell
Test-GitHubBlockedUser -OrganizationName 'github' -Username 'octocat'
```

Checks if the user `octocat` is blocked by the organization `github`.
Returns true if the user is blocked, false if not.

## PARAMETERS

### -Username
The handle for the GitHub user account.

```yaml
Type: String
Parameter Sets: (All)
Aliases: login

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OrganizationName
The organization name.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: owner, org

Required: False
Position: 2
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

### System.Boolean
## NOTES
[Check if a user is blocked by the authenticated user](https://docs.github.com/rest/users/blocking#check-if-a-user-is-blocked-by-the-authenticated-user)
[Check if a user is blocked by an organization](https://docs.github.com/rest/orgs/blocking#check-if-a-user-is-blocked-by-an-organization)

## RELATED LINKS

