---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Add-GitHubUserGpgKey

## SYNOPSIS
Create a GPG key for the authenticated user

## SYNTAX

```powershell
Add-GitHubUserGpgKey [-Name] <String> [-ArmoredPublicKey] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Adds a GPG key to the authenticated user's GitHub account.
Requires that you are authenticated via Basic Auth, or OAuth with at least `write:gpg_key`
[scope](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/).

## EXAMPLES

### EXAMPLE 1
```powershell
Add-GitHubUserGpgKey -Name 'GPG key for GitHub' -ArmoredPublicKey @'
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1
```

mQINBFnZ2ZIBEADQ2Z7Z7
-----END PGP PUBLIC KEY BLOCK-----
'@

Adds a GPG key to the authenticated user's GitHub account.

## PARAMETERS

### -Name
A descriptive name for the new key.

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

### -ArmoredPublicKey
A GPG key in ASCII-armored format.

```yaml
Type: String
Parameter Sets: (All)
Aliases: armored_public_key

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
[Create a GPG key for the authenticated user](https://docs.github.com/rest/users/gpg-keys#create-a-gpg-key-for-the-authenticated-user)

## RELATED LINKS

