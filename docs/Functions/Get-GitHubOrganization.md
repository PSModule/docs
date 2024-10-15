---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubOrganization

## SYNOPSIS
List organization

## SYNTAX

### __DefaultSet (Default)
```powershell
Get-GitHubOrganization [-PerPage <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### NamedOrg
```powershell
Get-GitHubOrganization -OrganizationName <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### NamedUser
```powershell
Get-GitHubOrganization -Username <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### AllOrg
```powershell
Get-GitHubOrganization [-All] [-Since <Int32>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### UserOrg
```powershell
Get-GitHubOrganization [-PerPage <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
List organizations for the authenticated user - if no parameters are provided.
List organizations for a user - if a username is provided.
Lists all organizations, in the order that they were created on GitHub - if '-All' is provided.
Get an organization - if a organization name is provided.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubOrganization
```

List organizations for the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubOrganization -Username 'octocat'
```

List public organizations for the user 'octocat'.

### EXAMPLE 3
```powershell
Get-GitHubOrganization -All -Since 142951047
```

List organizations, starting with PSModule.

### EXAMPLE 4
```powershell
Get-GitHubOrganization -Name 'PSModule'
```

Get the organization 'PSModule'.

## PARAMETERS

### -OrganizationName
The organization name.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: NamedOrg
Aliases: owner, org, login

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

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
List all organizations.
Use '-Since' to start at a specific organization ID.

```yaml
Type: SwitchParameter
Parameter Sets: AllOrg
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Since
A organization ID.
Only return organizations with an ID greater than this ID.

```yaml
Type: Int32
Parameter Sets: AllOrg
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
Parameter Sets: __DefaultSet, AllOrg, UserOrg
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
[List organizations](https://docs.github.com/rest/orgs/orgs)

## RELATED LINKS

