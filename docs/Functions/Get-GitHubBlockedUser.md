---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubBlockedUser

## SYNOPSIS
List blocked users.

## SYNTAX

```powershell
Get-GitHubBlockedUser [[-OrganizationName] <String>] [[-PerPage] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
List the users that are blocked on your personal account or a given organization.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubBlockedUser
```

Returns a list of users blocked by the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubBlockedUser -OrganizationName 'github'
```

Lists all users blocked by the organization `github`.

## PARAMETERS

### -OrganizationName
The organization name.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: login, owner, org

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
[List users blocked by the authenticated user](https://docs.github.com/rest/users/blocking#list-users-blocked-by-the-authenticated-user)
[List users blocked by an organization](https://docs.github.com/rest/orgs/blocking#list-users-blocked-by-an-organization)

## RELATED LINKS

