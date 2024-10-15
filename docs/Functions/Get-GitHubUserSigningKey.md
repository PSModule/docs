---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUserSigningKey

## SYNOPSIS
List SSH signing keys for a given user or the authenticated user.

## SYNTAX

### Username
```powershell
Get-GitHubUserSigningKey -Username <String> [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Me
```powershell
Get-GitHubUserSigningKey [-ID <String>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists a given user's or the current user's SSH signing keys.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubUserSigningKey
```

Gets all SSH signing keys for the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubUserSigningKey -ID '1234567'
```

Gets the SSH signing key with the ID '1234567' for the authenticated user.

### EXAMPLE 3
```powershell
Get-GitHubUserSigningKey -Username 'octocat'
```

Gets all SSH signing keys for the 'octocat' user.

## PARAMETERS

### -Username
The handle for the GitHub user account.

```yaml
Type: String
Parameter Sets: Username
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ID
The unique identifier of the SSH signing key.

```yaml
Type: String
Parameter Sets: Me
Aliases: gpg_key_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerPage
The number of results per page (max 100).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 30
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
[List SSH signing keys for the authenticated user](https://docs.github.com/rest/users/ssh-signing-keys#list-ssh-signing-keys-for-the-authenticated-user)
[Get an SSH signing key for the authenticated user](https://docs.github.com/rest/users/ssh-signing-keys#get-an-ssh-signing-key-for-the-authenticated-user)
[List SSH signing keys for a user](https://docs.github.com/rest/users/ssh-signing-keys#list-ssh-signing-keys-for-a-user)

## RELATED LINKS

