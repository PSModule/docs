---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubStatus

## SYNOPSIS
Gets the status of GitHub services

## SYNTAX

```powershell
Get-GitHubStatus [-Summary] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get a summary of the status page, including a status indicator, component statuses, unresolved incidents,
and any upcoming or in-progress scheduled maintenances.
Get the status rollup for the whole page.
This endpoint
includes an indicator - one of none, minor, major, or critical, as well as a human description of the blended
component status.
Examples of the blended status include "All Systems Operational", "Partial System Outage",
and "Major Service Outage".

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubStatus
```

Gets the status of GitHub services

### EXAMPLE 2
```powershell
Get-GitHubStatus -Summary
```

Gets a summary of the status page, including a status indicator, component statuses, unresolved incidents,
and any upcoming or in-progress scheduled maintenances.

## PARAMETERS

### -Summary
Gets a summary of the status page, including a status indicator, component statuses, unresolved incidents,
and any upcoming or in-progress scheduled maintenances.

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

### System.Management.Automation.PSObject
## NOTES
[Summary](https://www.githubstatus.com/api#summary)
[Status](https://www.githubstatus.com/api#status)

## RELATED LINKS

