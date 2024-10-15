---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Update-GitHubRepository

## SYNOPSIS
Update a repository

## SYNTAX

```powershell
Update-GitHubRepository [[-Owner] <String>] [[-Repo] <String>] [[-Name] <String>] [[-Description] <String>]
 [[-Homepage] <Uri>] [[-Visibility] <String>] [-EnableAdvancedSecurity] [-EnableSecretScanning]
 [-EnableSecretScanningPushProtection] [-HasIssues] [-HasProjects] [-HasWiki] [-IsTemplate]
 [[-DefaultBranch] <String>] [-AllowSquashMerge] [-AllowMergeCommit] [-AllowRebaseMerge] [-AllowAutoMerge]
 [-DeleteBranchOnMerge] [-AllowUpdateMerge] [[-SquashMergeCommitTitle] <String>]
 [[-SquashMergeCommitMessage] <String>] [[-MergeCommitTitle] <String>] [[-MergeCommitMessage] <String>]
 [-Archived] [-AllowForking] [-WebCommitSignoffRequired] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
**Note**: To edit a repository's topics, use the
[Replace all repository topics](https://docs.github.com/rest/repos/repos#replace-all-repository-topics) endpoint.

## EXAMPLES

### EXAMPLE 1
```powershell
Update-GitHubRepository -Name 'octocat' -Description 'Hello-World' -Homepage 'https://github.com'
```

### EXAMPLE 2
```powershell
$params = @{
    Owner       = 'octocat'
    Repo        = 'Hello-World'
    name        = 'Hello-World-Repo
    description = 'This is your first repository'
    homepage    = 'https://github.com'
}
Update-GitHubRepository @params
```

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: org

Required: False
Position: 1
Default value: (Get-GitHubConfig -Name Owner)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repo
The name of the repository without the .git extension.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
A short description of the repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Homepage
A URL with more information about the repository.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Visibility
The visibility of the repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableAdvancedSecurity
Use the status property to enable or disable GitHub Advanced Security for this repository.
For more information, see "About GitHub Advanced Security."

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableSecretScanning
Use the status property to enable or disable secret scanning for this repository.
For more information, see "About secret scanning."

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableSecretScanningPushProtection
Use the status property to enable or disable secret scanning push protection for this repository.
For more information, see "Protecting pushes with secret scanning."

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HasIssues
Whether issues are enabled.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases: has_wiki

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
Parameter Sets: (All)
Aliases: is_template

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultBranch
Updates the default branch for this repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases: default_branch

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowSquashMerge
Whether to allow squash merges for pull requests.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases: delete_branch_on_merge

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowUpdateMerge
Either true to always allow a pull request head branch that is behind its base branch
to be updated even if it is not required to be up to date before merging, or false otherwise.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: allow_update_branch

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
Parameter Sets: (All)
Aliases: squash_merge_commit_title

Required: False
Position: 8
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
Parameter Sets: (All)
Aliases: squash_merge_commit_message

Required: False
Position: 9
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
Parameter Sets: (All)
Aliases: merge_commit_title

Required: False
Position: 10
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
Parameter Sets: (All)
Aliases: merge_commit_message

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archived
Whether to archive this repository.
false will unarchive a previously archived repository.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowForking
Either true to allow private forks, or false to prevent private forks.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: allow_forking

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebCommitSignoffRequired
Either true to require contributors to sign off on web-based commits,
or false to not require contributors to sign off on web-based commits.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: web_commit_signoff_required

Required: False
Position: Named
Default value: False
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

## NOTES
[Update a repository](https://docs.github.com/rest/repos/repos#update-a-repository)

## RELATED LINKS

