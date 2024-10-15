---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubOctocat

## SYNOPSIS
Get Octocat.

## SYNTAX

```powershell
Get-GitHubOctocat [[-S] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get the octocat as ASCII art.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubOctocat
```

Get the octocat as ASCII art

### EXAMPLE 2
```powershell
Get-GitHubOctocat -S "Hello world"
```

Get the octocat as ASCII art with a custom saying

## PARAMETERS

### -S
The words to show in Octocat's speech bubble

```yaml
Type: String
Parameter Sets: (All)
Aliases: Saying, Say

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

### System.String
## NOTES
[Get Octocat](https://docs.github.com/rest/meta/meta#get-octocat)

## RELATED LINKS

