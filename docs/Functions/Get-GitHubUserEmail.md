---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUserEmail

## SYNOPSIS
List email addresses for the authenticated user

## SYNTAX

```powershell
Get-GitHubUserEmail [[-PerPage] <Int32>] [-Public] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists all of your email addresses, and specifies which one is visible to the public.
This endpoint is accessible with the `user:email` scope.
Specifying '-Public' will return only the publicly visible email address, which you can set with the [Set primary email visibility for the
authenticated user](https://docs.github.com/rest/users/emails#set-primary-email-visibility-for-the-authenticated-user) endpoint.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubUserEmail
```

Gets all email addresses for the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubUserEmail -Public
```

Gets the publicly visible email address for the authenticated user.

## PARAMETERS

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -Public
{{ Fill Public Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
[List email addresses for the authenticated user](https://docs.github.com/rest/users/emails#list-email-addresses-for-the-authenticated-user)
[List public email addresses for the authenticated user](https://docs.github.com/en/rest/users/emails#list-public-email-addresses-for-the-authenticated-user)

## RELATED LINKS

