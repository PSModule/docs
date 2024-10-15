---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Add-GitHubUserKey

## SYNOPSIS
Create a public SSH key for the authenticated user

## SYNTAX

```powershell
Add-GitHubUserKey [[-Title] <String>] [-Key] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Adds a public SSH key to the authenticated user's GitHub account.
Requires that you are authenticated via Basic Auth, or OAuth with at least `write:public_key`
[scope](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/).

## EXAMPLES

### EXAMPLE 1
```powershell
Add-GitHubUserKey -Title 'ssh-rsa AAAAB3NzaC1yc2EAAA' -Key '2Sg8iYjAxxmI2LvUXpJjkYrMxURPc8r+dB7TJyvv1234'
```

Adds a new public SSH key to the authenticated user's GitHub account.

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
[Create a public SSH key for the authenticated user](https://docs.github.com/rest/users/keys#create-a-public-ssh-key-for-the-authenticated-user)

## RELATED LINKS

