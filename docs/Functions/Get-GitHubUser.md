---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUser

## SYNOPSIS
List user(s)

## SYNTAX

### __DefaultSet (Default)
```powershell
Get-GitHubUser [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### NamedUser
```powershell
Get-GitHubUser -Username <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### AllUsers
```powershell
Get-GitHubUser [-All] [-Since <Int32>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Get the authenticated user - if no parameters are provided.
Get a given user - if a username is provided.
Lists all users, in the order that they signed up on GitHub - if '-All' is provided.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubUser
```

Get the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubUser -Username 'octocat'
```

Get the 'octocat' user.

### EXAMPLE 3
```powershell
Get-GitHubUser -All -Since 17722253
```

Get a list of users, starting with the user 'MariusStorhaug'.

## PARAMETERS

### -Username
The handle for the GitHub user account.

```yaml
Type: String
Parameter Sets: NamedUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -All
List all users.
Use '-Since' to start at a specific user ID.

```yaml
Type: SwitchParameter
Parameter Sets: AllUsers
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Since
A user ID.
Only return users with an ID greater than this ID.

```yaml
Type: Int32
Parameter Sets: AllUsers
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: AllUsers
Aliases:

Required: False
Position: Named
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
[Get the authenticated user](https://docs.github.com/rest/users/users)

## RELATED LINKS

