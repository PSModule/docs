---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubUserKey

## SYNOPSIS
List public SSH keys for a given user or the authenticated user.

## SYNTAX

### Username
```powershell
Get-GitHubUserKey -Username <String> [-PerPage <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Me
```powershell
Get-GitHubUserKey [-ID <String>] [-PerPage <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Lists a given user's or the current user's public SSH keys.
For the authenticated users keys, it requires that you are authenticated via Basic Auth or via OAuth with
at least `read:public_key` [scope](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/).
Keys from a given user are accessible by anyone.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubUserKey
```

Gets all GPG keys for the authenticated user.

### EXAMPLE 2
```powershell
Get-GitHubUserKey -ID '1234567'
```

Gets the public SSH key with the ID '1234567' for the authenticated user.

### EXAMPLE 3
```powershell
Get-GitHubUserKey -Username 'octocat'
```

Gets all GPG keys for the 'octocat' user.

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
The ID of the GPG key.

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
[List GPG keys for the authenticated user](https://docs.github.com/rest/users/gpg-keys#list-gpg-keys-for-the-authenticated-user)

## RELATED LINKS

