---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubEmoji

## SYNOPSIS
Get emojis

## SYNTAX

```powershell
Get-GitHubEmoji [[-Destination] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists all the emojis available to use on GitHub.
If you pass the `Destination` parameter, the emojis will be downloaded to the specified destination.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubEmoji
```

Gets all the emojis available to use on GitHub.

### EXAMPLE 2
```powershell
Get-GitHubEmoji -Destination 'C:\Users\user\Documents\GitHub\Emojis'
```

Downloads all the emojis available to use on GitHub to the specified destination.

## PARAMETERS

### -Destination
The path to the directory where the emojis will be downloaded.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
[Get emojis](https://docs.github.com/rest/reference/emojis#get-emojis)

## RELATED LINKS

