---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Block-GitHubUser

## SYNOPSIS
Block a user from user or an organization.

## SYNTAX

```powershell
Block-GitHubUser [-Username] <String> [[-OrganizationName] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Blocks the given user and returns true.
If the user cannot be blocked false is returned.

## EXAMPLES

### EXAMPLE 1
```powershell
Block-GitHubUser -Username 'octocat'
```

Blocks the user 'octocat' for the authenticated user.
Returns $true if successful, $false if not.

### EXAMPLE 2
```powershell
Block-GitHubUser -OrganizationName 'GitHub' -Username 'octocat'
```

Blocks the user 'octocat' from the organization 'GitHub'.
Returns $true if successful, $false if not.

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
[Block a user](https://docs.github.com/rest/users/blocking#block-a-user)
[Block a user from an organization](https://docs.github.com/rest/orgs/blocking#block-a-user-from-an-organization)

## RELATED LINKS

