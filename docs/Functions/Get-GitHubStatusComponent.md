---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubStatusComponent

## SYNOPSIS
Gets the status of GitHub components

## SYNTAX

```powershell
Get-GitHubStatusComponent [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get the components for the page.
Each component is listed along with its status - one of operational,
degraded_performance, partial_outage, or major_outage.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubStatusComponent
```

Gets the status of GitHub components

## PARAMETERS

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
[Components](https://www.githubstatus.com/api#components)

## RELATED LINKS

