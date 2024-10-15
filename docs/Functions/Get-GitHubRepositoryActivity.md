---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryActivity

## SYNOPSIS
List repository activities

## SYNTAX

```powershell
Get-GitHubRepositoryActivity [-Owner <String>] [-Repo <String>] [-Direction <String>] [-PerPage <Int32>]
 [-Before <String>] [-After <String>] [-Ref <String>] [-Actor <String>] [-TimePeriod <String>]
 [-ActivityType <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists a detailed history of changes to a repository, such as pushes, merges, force pushes, and branch changes,
and associates these changes with commits and users.

For more information about viewing repository activity,
see "[Viewing activity and data for your repository](https://docs.github.com/repositories/viewing-activity-and-data-for-your-repository)."

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub'
```

### EXAMPLE 2
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -Direction 'asc'
```

### EXAMPLE 3
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -PerPage 100
```

### EXAMPLE 4
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -Before '2021-01-01T00:00:00Z'
```

### EXAMPLE 5
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -After '2021-01-01T00:00:00Z'
```

### EXAMPLE 6
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -Ref 'refs/heads/main'
```

### EXAMPLE 7
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -Actor 'octocat'
```

### EXAMPLE 8
```powershell
$params = @{
    Owner       = 'PSModule'
    Repo        = 'GitHub'
    TimePeriod  = 'day'
}
Get-GitHubRepositoryActivity @params |
    Select-Object -Property @{n='actor';e={$_.actor.login}},activity_type,ref,timestamp
```

Gets the activity for the past 24 hours and selects the actor, activity type, ref, and timestamp.

### EXAMPLE 9
```powershell
Get-GitHubRepositoryActivity -Owner 'PSModule' -Repo 'GitHub' -ActivityType 'push','force_push'
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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Direction
The direction to sort the results by.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Desc
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).
Default: 30

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: per_page

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -Before
A cursor, as given in the Link header.
If specified, the query only searches for results before this cursor.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -After
A cursor, as given in the Link header.
If specified, the query only searches for results after this cursor.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ref
The Git reference for the activities you want to list.
The ref for a branch can be formatted either as refs/heads/BRANCH_NAME or BRANCH_NAME, where BRANCH_NAME is the name of your branch.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Actor
The GitHub username to use to filter by the actor who performed the activity.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimePeriod
The time period to filter by.
For example,day will filter for activity that occurred in the past 24 hours,
and week will filter for activity that occurred in the past 7 days (168 hours).

```yaml
Type: String
Parameter Sets: (All)
Aliases: time_period

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActivityType
The activity type to filter by.
For example,you can choose to filter by 'force_push', to see all force pushes to the repository.

```yaml
Type: String
Parameter Sets: (All)
Aliases: activity_type

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
[List repository activities](https://docs.github.com/rest/repos/repos#list-repository-activities)

## RELATED LINKS

