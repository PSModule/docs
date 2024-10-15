---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepository

## SYNOPSIS
Gets a specific repository or list of repositories.

## SYNTAX

### MyRepos_Type (Default)
```powershell
Get-GitHubRepository [-Since <DateTime>] [-Before <DateTime>] [-Sort <String>]
 [-ProgressAction <ActionPreference>] [-Type <String>] [<CommonParameters>]
```

### MyRepos_Aff-Vis
```powershell
Get-GitHubRepository [-Visibility <String>] [-Affiliation <String[]>] [-Since <DateTime>] [-Before <DateTime>]
 [-Sort <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ListByID
```powershell
Get-GitHubRepository [-SinceID <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ListByOrg
```powershell
Get-GitHubRepository [-Owner <String>] [-Sort <String>] [-Direction <String>] [-PerPage <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ByName
```powershell
Get-GitHubRepository [-Owner <String>] -Repo <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ListByUser
```powershell
Get-GitHubRepository -Username <String> [-Sort <String>] [-Direction <String>] [-PerPage <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### MyRepos
```powershell
Get-GitHubRepository [-Direction <String>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets a specific repository or list of repositories based on parameter sets.
If no parameters are specified, the authenticated user's repositories are returned.
If a Username parameter is specified, the specified user's public repositories are returned.
If the SinceId parameter is specified, the repositories with an ID greater than the specified ID are returned.
If an Owner and Repo parameters are specified, the specified repository is returned.
If the Owner and Repo parameters are specified, the specified repository is returned.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepository
```

Gets the repositories for the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubRepository -Type 'owner'
```

Gets the repositories owned by the authenticated user.

### EXAMPLE 3
```powershell
Get-GitHubRepository -Username 'octocat'
```

Gets the repositories for the specified user.

### EXAMPLE 4
```powershell
Get-GitHubRepository -SinceID 123456789
```

Gets the repositories with an ID equals and greater than 123456789.

### EXAMPLE 5
```powershell
Get-GitHubRepository -Owner 'github' -Repo 'octocat'
```

Gets the specified repository.

## PARAMETERS

### -Visibility
Limit results to repositories with the specified visibility.

```yaml
Type: String
Parameter Sets: MyRepos_Aff-Vis
Aliases:

Required: False
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### -Affiliation
Comma-separated list of values.
Can include:
- owner: Repositories that are owned by the authenticated user.
- collaborator: Repositories that the user has been added to as a collaborator.
- organization_member: Repositories that the user has access to through being a member of an organization.
  This includes every repository on every team that the user is on.
Default: owner, collaborator, organization_member

```yaml
Type: String[]
Parameter Sets: MyRepos_Aff-Vis
Aliases:

Required: False
Position: Named
Default value: @('owner', 'collaborator', 'organization_member')
Accept pipeline input: False
Accept wildcard characters: False
```

### -SinceID
A repository ID.
Only return repositories with an ID greater than this ID.

```yaml
Type: Int32
Parameter Sets: ListByID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Since
Only show repositories updated after the given time.

```yaml
Type: DateTime
Parameter Sets: MyRepos_Type, MyRepos_Aff-Vis
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Before
Only show repositories updated before the given time.

```yaml
Type: DateTime
Parameter Sets: MyRepos_Type, MyRepos_Aff-Vis
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: ListByOrg, ByName
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name Owner)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repo
The name of the repository without the .git extension.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: Named
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username
The handle for the GitHub user account.

```yaml
Type: String
Parameter Sets: ListByUser
Aliases: login

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Sort
The property to sort the results by.

```yaml
Type: String
Parameter Sets: MyRepos_Type, MyRepos_Aff-Vis, ListByOrg, ListByUser
Aliases:

Required: False
Position: Named
Default value: Created
Accept pipeline input: False
Accept wildcard characters: False
```

### -Direction
The order to sort by.
Default: asc when using full_name, otherwise desc.

```yaml
Type: String
Parameter Sets: ListByOrg, ListByUser, MyRepos
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: ListByOrg, ListByUser, MyRepos
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

### -Type
{{ Fill Type Description }}

```yaml
Type: String
Parameter Sets: MyRepos_Type
Aliases:

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
[List repositories for the authenticated user](https://docs.github.com/rest/repos/repos#list-repositories-for-the-authenticated-user)
[Get a repository](https://docs.github.com/rest/repos/repos#get-a-repository)
[List public repositories](https://docs.github.com/rest/repos/repos#list-public-repositories)
[List organization repositories](https://docs.github.com/rest/repos/repos#list-organization-repositories)
[List repositories for a user](https://docs.github.com/rest/repos/repos#list-repositories-for-a-user)

## RELATED LINKS

