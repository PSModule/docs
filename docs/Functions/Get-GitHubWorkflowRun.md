---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubWorkflowRun

## SYNOPSIS

## SYNTAX

### Repo (Default)
```powershell
Get-GitHubWorkflowRun [-Owner <String>] [-Repo <String>] [-PerPage <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ByName
```powershell
Get-GitHubWorkflowRun [-Owner <String>] [-Repo <String>] [-Name <String>] [-PerPage <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ByID
```powershell
Get-GitHubWorkflowRun [-Owner <String>] [-Repo <String>] [-ID <String>] [-PerPage <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Owner
{{ Fill Owner Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name Owner)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repo
{{ Fill Repo Description }}

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

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
{{ Fill ID Description }}

```yaml
Type: String
Parameter Sets: ByID
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
Parameter Sets: (All)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
[List workflow runs for a workflow](https://docs.github.com/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-workflow)
[List workflow runs for a repository](https://docs.github.com/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-repository)

## RELATED LINKS

