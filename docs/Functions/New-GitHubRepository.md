---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# New-GitHubRepository

## SYNOPSIS
Create a repository for a user or an organization.

## SYNTAX

### user (Default)
```powershell
New-GitHubRepository -Name <String> [-Description <String>] [-Homepage <Uri>] [-Visibility <String>]
 [-HasIssues] [-HasProjects] [-HasWiki] [-HasDiscussions] [-HasDownloads] [-IsTemplate] [-TeamId <Int32>]
 [-AutoInit] [-AllowSquashMerge] [-AllowMergeCommit] [-AllowRebaseMerge] [-AllowAutoMerge]
 [-DeleteBranchOnMerge] [-SquashMergeCommitTitle <String>] [-SquashMergeCommitMessage <String>]
 [-MergeCommitTitle <String>] [-MergeCommitMessage <String>] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [-GitignoreTemplate <String>] [-LicenseTemplate <String>] [<CommonParameters>]
```

### fork
```powershell
New-GitHubRepository [-Owner <String>] [-Name <String>] -ForkOwner <String> -ForkRepo <String>
 [-DefaultBranchOnly] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [-GitignoreTemplate <String>]
 [-LicenseTemplate <String>] [<CommonParameters>]
```

### org
```powershell
New-GitHubRepository [-Owner <String>] -Name <String> [-Description <String>] [-Homepage <Uri>]
 [-Visibility <String>] [-HasIssues] [-HasProjects] [-HasWiki] [-HasDownloads] [-IsTemplate] [-TeamId <Int32>]
 [-AutoInit] [-AllowSquashMerge] [-AllowMergeCommit] [-AllowRebaseMerge] [-AllowAutoMerge]
 [-DeleteBranchOnMerge] [-SquashMergeCommitTitle <String>] [-SquashMergeCommitMessage <String>]
 [-MergeCommitTitle <String>] [-MergeCommitMessage <String>] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [-GitignoreTemplate <String>] [-LicenseTemplate <String>] [<CommonParameters>]
```

### template
```powershell
New-GitHubRepository -Name <String> -TemplateOwner <String> -TemplateRepo <String> [-Description <String>]
 [-IncludeAllBranches] [-Visibility <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [-GitignoreTemplate <String>] [-LicenseTemplate <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new repository for a user or in a specified organization.

**OAuth scope requirements**

When using [OAuth](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/), authorizations must include:

* `public_repo` scope or `repo` scope to create a public repository.
Note: For GitHub AE, use `repo` scope to create an internal repository.
* `repo` scope to create a private repository

## EXAMPLES

### EXAMPLE 1
```powershell
$params = @{
    Name                     = 'Hello-World'
    Description              = 'This is your first repository'
    Homepage                 = 'https://github.com'
    HasIssues                = $true
    HasProjects              = $true
    HasWiki                  = $true
    HasDiscussions           = $true
    HasDownloads             = $true
    IsTemplate               = $true
    AutoInit                 = $true
    AllowSquashMerge         = $true
    AllowAutoMerge           = $true
    DeleteBranchOnMerge      = $true
    SquashMergeCommitTitle   = 'PR_TITLE'
    SquashMergeCommitMessage = 'PR_BODY'
}
New-GitHubRepository @params
```

Creates a new public repository named "Hello-World" owned by the authenticated user.

### EXAMPLE 2
```powershell
$params = @{
    Owner                    = 'PSModule'
    Name                     = 'Hello-World'
    Description              = 'This is your first repository'
    Homepage                 = 'https://github.com'
    HasIssues                = $true
    HasProjects              = $true
    HasWiki                  = $true
    HasDownloads             = $true
    IsTemplate               = $true
    AutoInit                 = $true
    AllowSquashMerge         = $true
    AllowAutoMerge           = $true
    DeleteBranchOnMerge      = $true
    SquashMergeCommitTitle   = 'PR_TITLE'
    SquashMergeCommitMessage = 'PR_BODY'
}
New-GitHubRepository @params
```

Creates a new public repository named "Hello-World" owned by the organization "PSModule".

### EXAMPLE 3
```powershell
$params = @{
    TemplateOwner      = 'GitHub'
    TemplateRepo       = 'octocat'
    Owner              = 'PSModule'
    Name               = 'MyNewRepo'
    IncludeAllBranches = $true
    Description        = 'My new repo'
    Private            = $true
}
New-GitHubRepository @params
```

Creates a new private repository named `MyNewRepo` from the `octocat` template repository owned by `GitHub`.

### EXAMPLE 4
```powershell
$params = @{
    ForkOwner         = 'octocat'
    ForkRepo          = 'Hello-World'
    Owner             = 'PSModule'
    Name              = 'MyNewRepo'
    DefaultBranchOnly = $true
}
New-GitHubRepository @params
```

Creates a new repository named `MyNewRepo` as a fork of `Hello-World` owned by `octocat`.
Only the default branch will be forked.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: fork, org
Aliases: org

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name Owner)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the repository.

```yaml
Type: String
Parameter Sets: user, org, template
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: fork
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateOwner
The account owner of the template repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: template
Aliases: template_owner

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateRepo
The name of the template repository without the .git extension.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: template
Aliases: template_repo

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForkOwner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: fork
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForkRepo
The name of the repository without the .git extension.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: fork
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultBranchOnly
When forking from an existing repository, fork with only the default branch.

```yaml
Type: SwitchParameter
Parameter Sets: fork
Aliases: default_branch_only

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
A short description of the new repository.

```yaml
Type: String
Parameter Sets: user, org, template
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeAllBranches
Set to true to include the directory structure and files from all branches in the template repository,
and not just the default branch.

```yaml
Type: SwitchParameter
Parameter Sets: template
Aliases: include_all_branches

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Homepage
A URL with more information about the repository.

```yaml
Type: Uri
Parameter Sets: user, org
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Visibility
The visibility of the repository.

```yaml
Type: String
Parameter Sets: user, org, template
Aliases:

Required: False
Position: Named
Default value: Public
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasIssues
Whether issues are enabled.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: has_issues

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasProjects
Whether projects are enabled.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: has_projects

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasWiki
Whether the wiki is enabled.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: has_wiki

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasDiscussions
Whether discussions are enabled.

```yaml
Type: SwitchParameter
Parameter Sets: user
Aliases: has_discussions

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasDownloads
Whether downloads are enabled.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: has_downloads

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsTemplate
Whether this repository acts as a template that can be used to generate new repositories.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: is_template

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TeamId
The ID of the team that will be granted access to this repository.
This is only valid when creating a repository in an organization.

```yaml
Type: Int32
Parameter Sets: user, org
Aliases: team_id

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoInit
Pass true to create an initial commit with empty README.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: auto_init

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowSquashMerge
Whether to allow squash merges for pull requests.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: allow_squash_merge

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowMergeCommit
Whether to allow merge commits for pull requests.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: allow_merge_commit

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowRebaseMerge
Whether to allow rebase merges for pull requests.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: allow_rebase_merge

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowAutoMerge
Whether to allow Auto-merge to be used on pull requests.

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: allow_auto_merge

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeleteBranchOnMerge
Whether to delete head branches when pull requests are merged

```yaml
Type: SwitchParameter
Parameter Sets: user, org
Aliases: delete_branch_on_merge

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SquashMergeCommitTitle
The default value for a squash merge commit title:
- PR_TITLE - default to the pull request's title.
- COMMIT_OR_PR_TITLE - default to the commit's title (if only one commit) or the pull request's title (when more than one commit).

```yaml
Type: String
Parameter Sets: user, org
Aliases: squash_merge_commit_title

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SquashMergeCommitMessage
The default value for a squash merge commit message:
- PR_BODY - default to the pull request's body.
- COMMIT_MESSAGES - default to the branch's commit messages.
- BLANK - default to a blank commit message.

```yaml
Type: String
Parameter Sets: user, org
Aliases: squash_merge_commit_message

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MergeCommitTitle
The default value for a merge commit title.
- PR_TITLE - default to the pull request's title.
- MERGE_MESSAGE - default to the classic title for a merge message (e.g.,Merge pull request #123 from branch-name).

```yaml
Type: String
Parameter Sets: user, org
Aliases: merge_commit_title

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MergeCommitMessage
The default value for a merge commit message.
- PR_BODY - default to the pull request's body.
- PR_TITLE - default to the pull request's title.
- BLANK - default to a blank commit message.

```yaml
Type: String
Parameter Sets: user, org
Aliases: merge_commit_message

Required: False
Position: Named
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

### -GitignoreTemplate
{{ Fill GitignoreTemplate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: gitignore_template

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LicenseTemplate
{{ Fill LicenseTemplate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: license_template

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
[Create a repository for the authenticated user](https://docs.github.com/rest/repos/repos#create-a-repository-for-the-authenticated-user)
[Create an organization repository](https://docs.github.com/rest/repos/repos#create-an-organization-repository)

## RELATED LINKS

