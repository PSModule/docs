---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryRuleSuiteList

## SYNOPSIS
List repository rule suites

## SYNTAX

```powershell
Get-GitHubRepositoryRuleSuiteList [[-Owner] <String>] [[-Repo] <String>] [[-Ref] <String>]
 [[-TimePeriod] <String>] [[-ActorName] <String>] [[-RuleSuiteResult] <String>] [[-PerPage] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists suites of rule evaluations at the repository level.
For more information, see"[Managing rulesets for a repository](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/managing-rulesets-for-a-repository#viewing-insights-for-rulesets)."

## EXAMPLES

### EXAMPLE 1
```powershell
$params = @{
    Owner           = 'octocat'
    Repo            = 'hello-world'
    Ref             = 'main'
    TimePeriod      = 'day'
    ActorName       = 'octocat'
    RuleSuiteResult = 'all'
}
Get-GitHubRepositoryRuleSuiteList @params
```

Gets a list of rule suites for the main branch of the hello-world repository owned by octocat.

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

### -Ref
The name of the ref.
Cannot contain wildcard characters.
When specified, only rule evaluations triggered for this ref will be returned.

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

### -TimePeriod
The time period to filter by.
For example,day will filter for rule suites that occurred in the past 24 hours,
and week will filter for insights that occurred in the past 7 days (168 hours).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Day
Accept pipeline input: False
Accept wildcard characters: False
```

### -ActorName
The handle for the GitHub user account to filter on.
When specified, only rule evaluations triggered by this actor will be returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RuleSuiteResult
The rule results to filter on.
When specified, only suites with this result will be returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
[List repository rule suites](https://docs.github.com/rest/repos/rule-suites#list-repository-rule-suites)

## RELATED LINKS

