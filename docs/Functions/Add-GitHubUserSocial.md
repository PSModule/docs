---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Add-GitHubUserSocial

## SYNOPSIS
Add social accounts for the authenticated user

## SYNTAX

```powershell
Add-GitHubUserSocial [-AccountUrls] <String[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Add one or more social accounts to the authenticated user's profile.
This endpoint is accessible with the `user` scope.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-GitHubUserSocial -AccountUrls 'https://twitter.com/MyTwitterAccount', 'https://www.linkedin.com/company/MyCompany'
```

Adds the Twitter and LinkedIn accounts to the authenticated user's profile.

## PARAMETERS

### -AccountUrls
Full URLs for the social media profiles to add.

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
[Add social accounts for the authenticated user](https://docs.github.com/rest/users/social-accounts#add-social-accounts-for-the-authenticated-user)

## RELATED LINKS

