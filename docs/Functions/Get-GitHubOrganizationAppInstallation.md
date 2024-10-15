---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubOrganizationAppInstallation

## SYNOPSIS
List app installations for an organization

## SYNTAX

```powershell
Get-GitHubOrganizationAppInstallation [-OrganizationName] <String> [[-PerPage] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists all GitHub Apps in an organization.
The installation count includes all GitHub Apps installed on repositories in the organization.
You must be an organization owner with `admin:read` scope to use this endpoint.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubOrganizationAppInstallation -OrganizationName 'github'
```

Gets all GitHub Apps in the organization `github`.

## PARAMETERS

### -OrganizationName
The organization name.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: login, owner, org

Required: True
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
[List app installations for an organization](https://docs.github.com/rest/orgs/orgs#list-app-installations-for-an-organization)

## RELATED LINKS

