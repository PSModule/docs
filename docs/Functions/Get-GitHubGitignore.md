---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubGitignore

## SYNOPSIS
Get a gitignore template or list of all gitignore templates names

## SYNTAX

### List (Default)
```powershell
Get-GitHubGitignore [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Name
```powershell
Get-GitHubGitignore [-ProgressAction <ActionPreference>] -Name <String> [<CommonParameters>]
```

## DESCRIPTION
If no parameters are specified, the function will return a list of all gitignore templates names.
If the Name parameter is specified, the function will return the gitignore template for the specified name.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubGitignoreList
```

Get all gitignore templates

### EXAMPLE 2
```powershell
Get-GitHubGitignore -Name 'VisualStudio'
```

Get a gitignore template for VisualStudio

## PARAMETERS

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: True
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
[Get a gitignore template](https://docs.github.com/rest/gitignore/gitignore#get-a-gitignore-template)
[Get all gitignore templates](https://docs.github.com/rest/gitignore/gitignore#get-all-gitignore-templates)

## RELATED LINKS

