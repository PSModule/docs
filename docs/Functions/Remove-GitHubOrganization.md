---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Remove-GitHubOrganization

## SYNOPSIS
Delete an organization

## SYNTAX

```powershell
Remove-GitHubOrganization [-OrganizationName] <String> [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an organization and all its repositories.
The organization login will be unavailable for 90 days after deletion.
Please review the [GitHub Terms of Service](https://docs.github.com/site-policy/github-terms/github-terms-of-service)
regarding account deletion before using this endpoint.

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-GitHubOrganization -OrganizationName 'GitHub'
```

Deletes the organization 'GitHub' and all its repositories.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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

### System.Management.Automation.PSObject
## NOTES
[Delete an organization](https://docs.github.com/rest/orgs/orgs#delete-an-organization)

## RELATED LINKS

