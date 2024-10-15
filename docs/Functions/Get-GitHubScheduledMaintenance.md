---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubScheduledMaintenance

## SYNOPSIS
Gets the status of GitHub scheduled maintenance

## SYNTAX

```powershell
Get-GitHubScheduledMaintenance [-Active] [-Upcoming] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Scheduled maintenances are planned outages, upgrades, or general notices that you're working
on infrastructure and disruptions may occurr.
A close sibling of Incidents, each usually goes
through a progression of statuses listed below, with an impact calculated from a blend of
component statuses (or an optional override).

Status: Scheduled, In Progress, Verifying, or Completed
Impact: None (black), Minor (yellow), Major (orange), or Critical (red)

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubScheduledMaintenance
```

Get a list of the 50 most recent scheduled maintenances.
This includes scheduled maintenances as described in the above two endpoints, as well as those in the Completed state.

### EXAMPLE 2
```powershell
Get-GitHubScheduledMaintenance -Active
```

Get a list of any active maintenances.

### EXAMPLE 3
```powershell
Get-GitHubScheduledMaintenance -Upcoming
```

Get a list of any upcoming maintenances.

## PARAMETERS

### -Active
Get a list of any active maintenances.
This endpoint will only return scheduled maintenances in the In Progress or Verifying state.

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

### -Upcoming
Get a list of any upcoming maintenances.
This endpoint will only return scheduled maintenances still in the Scheduled state.

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

## NOTES
[Scheduled maintenances](https://www.githubstatus.com/api#scheduled-maintenances)

## RELATED LINKS

