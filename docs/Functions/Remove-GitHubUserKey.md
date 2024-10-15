---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Remove-GitHubUserKey

## SYNOPSIS
Delete a public SSH key for the authenticated user

## SYNTAX

```powershell
Remove-GitHubUserKey [-ID] <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes a public SSH key from the authenticated user's GitHub account.
Requires that you are authenticated via Basic Auth or via OAuth with at least `admin:public_key`
[scope](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/).

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-GitHubUserKey -ID '1234567'
```

Deletes the public SSH key with ID '1234567' from the authenticated user's GitHub account.

## PARAMETERS

### -ID
The unique identifier of the key.

```yaml
Type: String
Parameter Sets: (All)
Aliases: key_id

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

### System.Management.Automation.PSObject
## NOTES
[Delete a public SSH key for the authenticated user](https://docs.github.com/rest/users/keys#delete-a-public-ssh-key-for-the-authenticated-user)

## RELATED LINKS

