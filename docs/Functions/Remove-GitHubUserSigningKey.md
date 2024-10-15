---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Remove-GitHubUserSigningKey

## SYNOPSIS
Delete an SSH signing key for the authenticated user

## SYNTAX

```powershell
Remove-GitHubUserSigningKey [-ID] <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes an SSH signing key from the authenticated user's GitHub account.
You must authenticate with Basic Authentication, or you must authenticate with OAuth with at least
`admin:ssh_signing_key` scope.
For more information, see
"[Understanding scopes for OAuth apps](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/)."

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-GitHubUserSigningKey -ID '1234567'
```

Removes the SSH signing key with the ID of `1234567` from the authenticated user's GitHub account.

## PARAMETERS

### -ID
The unique identifier of the SSH signing key.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ssh_signing_key_id

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
[Delete an SSH signing key for the authenticated user](https://docs.github.com/rest/users/ssh-signing-keys#delete-an-ssh-signing-key-for-the-authenticated-user)

## RELATED LINKS

