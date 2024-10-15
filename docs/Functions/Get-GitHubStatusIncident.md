---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubStatusIncident

## SYNOPSIS
Gets the status of GitHub incidents

## SYNTAX

```powershell
Get-GitHubStatusIncident [-Unresolved] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Incidents are the cornerstone of any status page, being composed of many incident updates.
Each incident usually goes through a progression of statuses listed below, with an impact
calculated from a blend of component statuses (or an optional override).

Status: Investigating, Identified, Monitoring, Resolved, or Postmortem
Impact: None (black), Minor (yellow), Major (orange), or Critical (red)

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubStatusIncident
```

Gets the status of GitHub incidents

### EXAMPLE 2
```powershell
Get-GitHubStatusIncident -Unresolved
```

Gets the status of GitHub incidents that are unresolved

## PARAMETERS

### -Unresolved
Gets the status of GitHub incidents that are unresolved

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

### System.Management.Automation.PSObject[]
## NOTES
[Incidents](https://www.githubstatus.com/api#incidents)

## RELATED LINKS

