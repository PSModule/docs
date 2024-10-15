---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Set-GitHubOrganization

## SYNOPSIS
Update an organization

## SYNTAX

```powershell
Set-GitHubOrganization [-OrganizationName] <String> [[-BillingEmail] <String>] [[-Company] <String>]
 [[-Email] <String>] [[-TwitterUsername] <String>] [[-Location] <String>] [[-Name] <String>]
 [[-Description] <String>] [[-HasOrganizationProjects] <Boolean>] [[-HasRepositoryProjects] <Boolean>]
 [[-DefaultRepositoryPermission] <String>] [[-MembersCanCreateRepositories] <Boolean>]
 [[-MembersCanCreateInternalRepositories] <Boolean>] [[-MembersCanCreatePrivateRepositories] <Boolean>]
 [[-MembersCanCreatePublicRepositories] <Boolean>] [[-MembersAllowedRepositoryCreationType] <String>]
 [[-MembersCanCreatePages] <Boolean>] [[-MembersCanCreatePublicPages] <Boolean>]
 [[-MembersCanCreatePrivatePages] <Boolean>] [[-MembersCanForkPrivateRepositories] <Boolean>]
 [[-WebCommitSignoffRequired] <Boolean>] [[-Blog] <String>]
 [[-AdvancedSecurityEnabledForNewRepositories] <Boolean>]
 [[-DependabotAlertsEnabledForNewRepositories] <Boolean>]
 [[-DependabotSecurityUpdatesEnabledForNewRepositories] <Boolean>]
 [[-DependencyGraphEnabledForNewRepositories] <Boolean>] [[-SecretScanningEnabledForNewRepositories] <Boolean>]
 [[-SecretScanningPushProtectionEnabledForNewRepositories] <Boolean>]
 [[-SecretScanningPushProtectionCustomLinkEnabled] <Boolean>]
 [[-SecretScanningPushProtectionCustomLink] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
**Parameter Deprecation Notice:** GitHub will replace and discontinue `members_allowed_repository_creation_type`
in favor of more granular permissions.
The new input parameters are `members_can_create_public_repositories`,
`members_can_create_private_repositories` for all organizations and `members_can_create_internal_repositories`
for organizations associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server
2.20+.
For more information, see the [blog post](https://developer.github.com/changes/2019-12-03-internal-visibility-changes).

Enables an authenticated organization owner with the `admin:org` scope or the `repo` scope to update the organization's
profile and member privileges.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-GitHubOrganization -OrganizationName 'GitHub' -Blog 'https://github.blog'
```

Sets the blog URL for the organization 'GitHub' to '<https://github.blog>'.

### EXAMPLE 2
```powershell
$param = @{
    OrganizationName = 'GitHub'
    MembersCanCreatePublicRepositories = $true
    MembersCanCreatePrivateRepositories = $true
    MembersCanCreateInternalRepositories = $true
}
Set-GitHubOrganization @param
```

Sets the repository creation permissions for the organization 'GitHub' to allow all members to create public, private,
and internal repositories.

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

### -BillingEmail
Billing email address.
This address is not publicized.

```yaml
Type: String
Parameter Sets: (All)
Aliases: billing_email

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Company
The company name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Email
The publicly visible email address.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TwitterUsername
The Twitter username of the company.

```yaml
Type: String
Parameter Sets: (All)
Aliases: twitter_username

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Location
The location.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
The shorthand name of the company.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description
The description of the company.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HasOrganizationProjects
Whether an organization can use organization projects.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: has_organization_projects

Required: False
Position: 9
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HasRepositoryProjects
Whether repositories that belong to the organization can use repository projects.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: has_repository_projects

Required: False
Position: 10
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DefaultRepositoryPermission
Default permission level members have for organization repositories.

```yaml
Type: String
Parameter Sets: (All)
Aliases: default_repository_permission

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreateRepositories
Whether of non-admin organization members can create repositories.
Note: A parameter can override this parameter.
See members_allowed_repository_creation_type in this table for details.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_repositories

Required: False
Position: 12
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreateInternalRepositories
Whether organization members can create internal repositories, which are visible to all enterprise members.
You can only allow members to create internal repositories if your organization is associated with an enterprise
account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+.
For more information, see
"Restricting repository creation in your organization" in the GitHub Help documentation.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_internal_repositories

Required: False
Position: 13
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreatePrivateRepositories
Whether organization members can create private repositories, which are visible to organization members with permission.
For more information, see "Restricting repository creation in your organization" in the GitHub Help documentation.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_private_repositories

Required: False
Position: 14
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreatePublicRepositories
Whether organization members can create public repositories, which are visible to anyone.
For more information,
see 'Restricting repository creation in your organization' in the GitHub Help documentation.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_public_repositories

Required: False
Position: 15
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersAllowedRepositoryCreationType
Specifies which types of repositories non-admin organization members can create.
private is only available to
repositories that are part of an organization on GitHub Enterprise Cloud.
Note: This parameter is deprecated and
will be removed in the future.
Its return value ignores internal repositories.
Using this parameter overrides values
set in members_can_create_repositories.
See the parameter deprecation notice in the operation description for details.

```yaml
Type: String
Parameter Sets: (All)
Aliases: members_allowed_repository_creation_type

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreatePages
Whether organization members can create GitHub Pages sites.
Existing published sites will not be impacted.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_pages

Required: False
Position: 17
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreatePublicPages
Whether organization members can create public GitHub Pages sites.
Existing published sites will not be impacted.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_public_pages

Required: False
Position: 18
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanCreatePrivatePages
Whether organization members can create private GitHub Pages sites.
Existing published sites will not be impacted.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_create_private_pages

Required: False
Position: 19
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MembersCanForkPrivateRepositories
Whether organization members can fork private organization repositories.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: members_can_fork_private_repositories

Required: False
Position: 20
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WebCommitSignoffRequired
Whether contributors to organization repositories are required to sign off on commits they make through GitHub's web interface.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: web_commit_signoff_required

Required: False
Position: 21
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Blog
Path to the organization's blog.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AdvancedSecurityEnabledForNewRepositories
Whether GitHub Advanced Security is automatically enabled for new repositories.
To use this parameter, you must have admin permissions for the repository or be an owner or security manager for
the organization that owns the repository.
For more information, see "Managing security managers in your organization."
You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: advanced_security_enabled_for_new_repositories

Required: False
Position: 23
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DependabotAlertsEnabledForNewRepositories
Whether Dependabot alerts is automatically enabled for new repositories.
To use this parameter, you must have admin permissions for the repository or be an owner or security manager for
the organization that owns the repository.
For more information, see "Managing security managers in your organization."
You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: dependabot_alerts_enabled_for_new_repositories

Required: False
Position: 24
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DependabotSecurityUpdatesEnabledForNewRepositories
Whether Dependabot security updates is automatically enabled for new repositories.
To use this parameter, you must have admin permissions for the repository or be an owner or security manager for
the organization that owns the repository.
For more information, see "Managing security managers in your organization."
You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: dependabot_security_updates_enabled_for_new_repositories

Required: False
Position: 25
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DependencyGraphEnabledForNewRepositories
Whether dependency graph is automatically enabled for new repositories.
To use this parameter, you must have admin permissions for the repository or be an owner or security manager for
the organization that owns the repository.
For more information, see "Managing security managers in your organization."
You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: dependency_graph_enabled_for_new_repositories

Required: False
Position: 26
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretScanningEnabledForNewRepositories
Whether secret scanning is automatically enabled for new repositories.
To use this parameter, you must have admin permissions for the repository or be an owner or security manager for
the organization that owns the repository.
For more information, see "Managing security managers in your organization."
You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: secret_scanning_enabled_for_new_repositories

Required: False
Position: 27
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretScanningPushProtectionEnabledForNewRepositories
Whether secret scanning push protection is automatically enabled for new repositories.
To use this parameter, you must have admin permissions for the repository or be an owner or security manager for
the organization that owns the repository.
For more information, see "Managing security managers in your organization."
You can check which security and analysis features are currently enabled by using a GET /orgs/{org} request.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: secret_scanning_push_protection_enabled_for_new_repositories

Required: False
Position: 28
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretScanningPushProtectionCustomLinkEnabled
Whether a custom link is shown to contributors who are blocked from pushing a secret by push protection.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: secret_scanning_push_protection_custom_link_enabled

Required: False
Position: 29
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretScanningPushProtectionCustomLink
If secret_scanning_push_protection_custom_link_enabled is true, the URL that will be displayed to contributors who
are blocked from pushing a secret.

```yaml
Type: String
Parameter Sets: (All)
Aliases: secret_scanning_push_protection_custom_link

Required: False
Position: 30
Default value: None
Accept pipeline input: True (ByPropertyName)
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
[Update an organization](https://docs.github.com/rest/orgs/orgs#update-an-organization)

## RELATED LINKS

