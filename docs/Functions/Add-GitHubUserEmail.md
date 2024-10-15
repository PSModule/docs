---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Add-GitHubUserEmail

## SYNOPSIS
Add an email address for the authenticated user

## SYNTAX

```powershell
Add-GitHubUserEmail [-Emails] <String[]> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This endpoint is accessible with the `user` scope.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-GitHubUserEmail -Emails 'octocat@github.com','firstname.lastname@work.com'
```

Adds the email addresses `octocat@github.com` and `firstname.lastname@work.com` to the authenticated user's account.

## PARAMETERS

### -Emails
Adds one or more email addresses to your GitHub account.
Must contain at least one email address.
Note: Alternatively, you can pass a single email address or an array of emails addresses directly,
but we recommend that you pass an object using the emails key.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
[Add an email address for the authenticated user](https://docs.github.com/rest/users/emails#add-an-email-address-for-the-authenticated-user)

## RELATED LINKS

