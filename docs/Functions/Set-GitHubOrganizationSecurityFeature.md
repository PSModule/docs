---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Set-GitHubOrganizationSecurityFeature

## SYNOPSIS
Enable or disable a security feature for an organization

## SYNTAX

```powershell
Set-GitHubOrganizationSecurityFeature [-OrganizationName] <String> [-SecurityProduct] <String>
 [-Enablement] <String> [[-QuerySuite] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Enables or disables the specified security feature for all eligible repositories in an organization.

To use this endpoint, you must be an organization owner or be member of a team with the security manager role.
A token with the 'write:org' scope is also required.

GitHub Apps must have the `organization_administration:write` permission to use this endpoint.

For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."

## EXAMPLES

### EXAMPLE 1
```powershell
Set-GitHubOrganizationSecurityFeature -OrganizationName 'github' -SecurityProduct 'dependency_graph' -Enablement 'enable_all'
```

Enable the dependency graph for all repositories in the organization `github`.

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
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityProduct
The security feature to enable or disable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: security_product

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Enablement
The action to take.
enable_all means to enable the specified security feature for all repositories in the organization.
disable_all
means to disable the specified security feature for all repositories in the organization.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuerySuite
CodeQL query suite to be used.
If you specify the query_suite parameter, the default setup will be configured with
this query suite only on all repositories that didn't have default setup already configured.
It will not change the
query suite on repositories that already have default setup configured.
If you don't specify any query_suite in your
request, the preferred query suite of the organization will be applied.

```yaml
Type: String
Parameter Sets: (All)
Aliases: query_suite

Required: False
Position: 4
Default value: None
Accept pipeline input: False
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
[Enable or disable a security feature for an organization](https://docs.github.com/rest/orgs/orgs#enable-or-disable-a-security-feature-for-an-organization)

## RELATED LINKS

