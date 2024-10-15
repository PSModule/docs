---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# New-GitHubRepositoryAutolink

## SYNOPSIS
Create an autolink reference for a repository

## SYNTAX

```powershell
New-GitHubRepositoryAutolink [-Owner] <String> [-Repo] <String> [-KeyPrefix] <String> [-UrlTemplate] <String>
 [[-IsAlphanumeric] <Boolean>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Users with admin access to the repository can create an autolink.

## EXAMPLES

### EXAMPLE 1
```powershell
'
```

Creates an autolink for the repository 'Hello-World' owned by 'octocat' that links to <https://www.example.com/issue/123>
when the prefix 'GH-' is found in an issue, pull request, or commit.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyPrefix
This prefix appended by certain characters will generate a link any time it is found in an issue, pull request, or commit.

```yaml
Type: String
Parameter Sets: (All)
Aliases: key_prefix

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UrlTemplate
The URL must contain <num> for the reference number.
<num> matches different characters depending on the value of is_alphanumeric.

```yaml
Type: String
Parameter Sets: (All)
Aliases: url_template

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsAlphanumeric
Whether this autolink reference matches alphanumeric characters.
If true, the <num> parameter of the url_template matches alphanumeric
characters A-Z (case insensitive), 0-9, and -.
If false, this autolink reference only matches numeric characters.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: is_alphanumeric

Required: False
Position: 5
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
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

### System.Management.Automation.PSObject
## NOTES
[Create an autolink reference for a repository](https://docs.github.com/rest/repos/autolinks#create-an-autolink-reference-for-a-repository)

## RELATED LINKS

