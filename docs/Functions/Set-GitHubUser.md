---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Set-GitHubUser

## SYNOPSIS
Update the authenticated user

## SYNTAX

```powershell
Set-GitHubUser [[-Name] <String>] [[-Email] <String>] [[-Blog] <String>] [[-TwitterUsername] <String>]
 [[-Company] <String>] [[-Location] <String>] [[-Hireable] <Boolean>] [[-Bio] <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
**Note:** If your email is set to private and you send an `email` parameter as part of this request
to update your profile, your privacy settings are still enforced: the email address will not be
displayed on your public profile or via the API.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-GitHubUser -Name 'octocat'
```

Update the authenticated user's name to 'octocat'

### EXAMPLE 2
```powershell
Set-GitHubUser -Location 'San Francisco'
```

Update the authenticated user's location to 'San Francisco'

### EXAMPLE 3
```powershell
Set-GitHubUser -Hireable $true -Bio 'I love programming'
```

Update the authenticated user's hiring availability to 'true' and their biography to 'I love programming'

## PARAMETERS

### -Name
The new name of the user.

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

### -Email
The publicly visible email address of the user.

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

### -Blog
The new blog URL of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TwitterUsername
The new Twitter username of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Company
The new company of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
The new location of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hireable
The new hiring availability of the user.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bio
The new short biography of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
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

### System.Void
## NOTES
[Update the authenticated user](https://docs.github.com/rest/users/users#update-the-authenticated-user)

## RELATED LINKS

