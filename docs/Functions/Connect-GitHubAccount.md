---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Connect-GitHubAccount

## SYNOPSIS
Connects to GitHub using a personal access token or device code login.

## SYNTAX

### DeviceFlow (Default)
```powershell
Connect-GitHubAccount [-Mode <String>] [-Scope <String>] [-Owner <String>] [-Repo <String>] [-Silent]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### PAT
```powershell
Connect-GitHubAccount [-AccessToken] [-Owner <String>] [-Repo <String>] [-Silent]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Connects to GitHub using a personal access token or device code login.

For device flow / device code login:
PowerShell requests device and user verification codes and gets the authorization URL where you will enter the user verification code.
In GitHub you will be asked to enter a user verification code at <https://github.com/login/device>.
PowerShell will keep polling GitHub for the user authentication status.
Once you have authorized the device,
the app will be able to make API calls with a new access token.

## EXAMPLES

### EXAMPLE 1
```powershell
Connect-GitHubAccount
```

Connects to GitHub using a device flow login.
If the user has already logged in, the access token will be refreshed.

### EXAMPLE 2
```powershell
$env:GH_TOKEN = '***'
Connect-GitHubAccount
```

Connects to GitHub using the access token from environment variable, assuming unattended mode.

### EXAMPLE 3
```powershell
Connect-GitHubAccount -AccessToken
! Enter your personal access token: *************
```

User gets prompted for the access token and stores it in the secret store.
The token is used when connecting to GitHub.

### EXAMPLE 4
```powershell
Connect-GitHubAccount -Mode 'OAuthApp' -Scope 'gist read:org repo workflow'
```

Connects to GitHub using a device flow login and sets the scope of the access token.

## PARAMETERS

### -Mode
Choose between authentication methods, either OAuthApp or GitHubApp.
For more info about the types of authentication visit:
[Differences between GitHub Apps and OAuth apps](https://docs.github.com/apps/oauth-apps/building-oauth-apps/differences-between-github-apps-and-oauth-apps)

```yaml
Type: String
Parameter Sets: DeviceFlow
Aliases:

Required: False
Position: Named
Default value: GitHubApp
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
The scope of the access token, when using OAuth authentication.
Provide the list of scopes as space-separated values.
For more information on scopes visit:
[Scopes for OAuth apps](https://docs.github.com/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps)

```yaml
Type: String
Parameter Sets: DeviceFlow
Aliases:

Required: False
Position: Named
Default value: Gist read:org repo workflow
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken
The personal access token to use for authentication.

```yaml
Type: SwitchParameter
Parameter Sets: PAT
Aliases: PAT, Token

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Owner
Set the default owner to use in commands.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Org, Organization

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repo
Set the default repository to use in commands.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Repository

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Silent
Suppresses the output of the function.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: s, q, Quiet

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

### System.Void
## NOTES
[Authenticating to the REST API](https://docs.github.com/rest/overview/other-authentication-methods#authenticating-for-saml-sso)

## RELATED LINKS

