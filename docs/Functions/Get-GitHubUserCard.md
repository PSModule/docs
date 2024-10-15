---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUserCard

## SYNOPSIS
Get contextual information for a user

## SYNTAX

```powershell
Get-GitHubUserCard [-Username] <String> [[-SubjectType] <String>] [[-SubjectID] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Provides hovercard information when authenticated through basic auth or OAuth with the `repo` scope.
You can find out more about someone in relation to their pull requests, issues, repositories, and organizations.

The `subject_type` and `subject_id` parameters provide context for the person's hovercard, which returns
more information than without the parameters.
For example, if you wanted to find out more about `octocat`
who owns the `Spoon-Knife` repository via cURL, it would look like this:

```shell
curl -u username:token
https://api.github.com/users/octocat/hovercard?subject_type=repository&subject_id=1300192
```

## EXAMPLES

### EXAMPLE 1
```powershell

```

## PARAMETERS

### -Username
{{ Fill Username Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SubjectType
{{ Fill SubjectType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubjectID
{{ Fill SubjectID Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
[Get contextual information for a user](https://docs.github.com/rest/users/users#get-contextual-information-for-a-user)

## RELATED LINKS

