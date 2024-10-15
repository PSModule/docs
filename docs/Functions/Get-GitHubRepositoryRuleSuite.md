---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryRuleSuite

## SYNOPSIS
List repository rule suites or a rule suite by ID.

## SYNTAX

### Default (Default)
```powershell
Get-GitHubRepositoryRuleSuite [-Owner <String>] [-Repo <String>] [-Ref <String>] [-TimePeriod <String>]
 [-ActorName <String>] [-RuleSuiteResult <String>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ById
```powershell
Get-GitHubRepositoryRuleSuite [-Owner <String>] [-Repo <String>] [-Ref <String>] [-TimePeriod <String>]
 [-ActorName <String>] [-RuleSuiteResult <String>] [-PerPage <Int32>] -RuleSuiteId <Int32>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists suites of rule evaluations at the repository level.
If an ID is specified, gets information about a suite of rule evaluations from within a repository.
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
Get-GitHubRepositoryRuleSuite @params
```

Gets a list of rule suites for the main branch of the hello-world repository owned by octocat.

### EXAMPLE 2
```powershell
Get-GitHubRepositoryRuleSuite -Owner 'octocat' -Repo 'hello-world' -RuleSuiteId 123456789
```

Gets information about a suite of rule evaluations with ID 123456789 from within the octocat/hello-world repository.

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

### -Ref
The name of the ref.
Cannot contain wildcard characters.
When specified, only rule evaluations triggered for this ref will be returned.

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
For example,day will filter for rule suites that occurred in the past 24 hours,
and week will filter for insights that occurred in the past 7 days (168 hours).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -RuleSuiteId
The unique identifier of the rule suite result.
To get this ID, you can use GET /repos/ { owner }/ { repo }/rulesets/rule-suites for repositories and GET /orgs/ { org }/rulesets/rule-suites for organizations.

```yaml
Type: Int32
Parameter Sets: ById
Aliases:

Required: True
Position: Named
Default value: 0
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
[Get a repository rule suite](https://docs.github.com/rest/repos/rule-suites#get-a-repository-rule-suite)

## RELATED LINKS

