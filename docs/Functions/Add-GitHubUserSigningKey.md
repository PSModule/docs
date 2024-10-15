---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Add-GitHubUserSigningKey

## SYNOPSIS
Create a SSH signing key for the authenticated user

## SYNTAX

```powershell
Add-GitHubUserSigningKey [[-Title] <String>] [-Key] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates an SSH signing key for the authenticated user's GitHub account.
You must authenticate with Basic Authentication, or you must authenticate with OAuth with at least `write:ssh_signing_key` scope.
For more information, see
"[Understanding scopes for OAuth apps](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/)."

## EXAMPLES

### EXAMPLE 1
```powershell
Add-GitHubUserSigningKey -Title 'ssh-rsa AAAAB3NzaC1yc2EAAA' -Key '2Sg8iYjAxxmI2LvUXpJjkYrMxURPc8r+dB7TJyvv1234'
```

Creates a new SSH signing key for the authenticated user's GitHub account.

## PARAMETERS

### -Title
A descriptive name for the new key.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Key
The public SSH key to add to your GitHub account.
For more information, see
[Checking for existing SSH keys](https://docs.github.com/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)."

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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
[Create a SSH signing key for the authenticated user](https://docs.github.com/rest/users/ssh-signing-keys#create-a-ssh-signing-key-for-the-authenticated-user)

## RELATED LINKS

