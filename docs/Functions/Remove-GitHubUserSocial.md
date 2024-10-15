---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Remove-GitHubUserSocial

## SYNOPSIS
Delete social accounts for the authenticated user

## SYNTAX

```powershell
Remove-GitHubUserSocial [-AccountUrls] <String[]> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes one or more social accounts from the authenticated user's profile.
This endpoint is accessible with the `user` scope.

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-GitHubUserSocial -AccountUrls 'https://twitter.com/MyTwitterAccount'
```

## PARAMETERS

### -AccountUrls
Parameter description

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: account_urls

Required: True
Position: 1
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
[Delete social accounts for the authenticated user](https://docs.github.com/rest/users/social-accounts#delete-social-accounts-for-the-authenticated-user)

## RELATED LINKS

