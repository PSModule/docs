---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Invoke-GitHubAPI

## SYNOPSIS
Calls the GitHub API using the provided parameters.

## SYNTAX

### ApiEndpoint (Default)
```powershell
Invoke-GitHubAPI [-Method <WebRequestMethod>] [-ApiBaseUri <String>] -ApiEndpoint <String> [-Body <Object>]
 [-Accept <String>] [-HttpVersion <Version>] [-FollowRelLink <Boolean>] [-UploadFilePath <String>]
 [-DownloadFilePath <String>] [-AccessToken <SecureString>] [-ContentType <String>] [-Version <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Uri
```powershell
Invoke-GitHubAPI [-Method <WebRequestMethod>] [-Body <Object>] [-Accept <String>] [-HttpVersion <Version>]
 [-FollowRelLink <Boolean>] [-UploadFilePath <String>] [-DownloadFilePath <String>] -URI <String>
 [-AccessToken <SecureString>] [-ContentType <String>] [-Version <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This function is a wrapper around Invoke-RestMethod tailored for calling GitHub's API.
It automatically handles the endpoint URI construction, headers, and token authentication.

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-GitHubAPI -ApiEndpoint '/repos/user/repo/pulls' -Method GET
```

Gets all open pull requests for the specified repository.

### EXAMPLE 2
```powershell
Invoke-GitHubAPI -ApiEndpoint '/repos/user/repo/pulls' -Method GET -Body @{ state = 'open' }
```

Gets all open pull requests for the specified repository, filtered by the 'state' parameter.

### EXAMPLE 3
```powershell
Invoke-GitHubAPI -ApiEndpoint '/repos/user/repo/pulls' -Method GET -Body @{ state = 'open' } -Accept 'application/vnd.github.v3+json'
```

Gets all open pull requests for the specified repository, filtered by the 'state' parameter, and using the specified 'Accept' header.

## PARAMETERS

### -Method
The HTTP method to be used for the API request.
It can be one of the following: GET, POST, PUT, DELETE, or PATCH.

```yaml
Type: WebRequestMethod
Parameter Sets: (All)
Aliases:
Accepted values: Default, Get, Head, Post, Put, Delete, Trace, Options, Merge, Patch

Required: False
Position: Named
Default value: GET
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiBaseUri
The base URI for the GitHub API.
This is usually `https://api.github.com`, but can be adjusted if necessary.

```yaml
Type: String
Parameter Sets: ApiEndpoint
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name ApiBaseUri)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiEndpoint
The specific endpoint for the API call, e.g., '/repos/user/repo/pulls'.

```yaml
Type: String
Parameter Sets: ApiEndpoint
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
The body of the API request.
This can be a hashtable or a string.
If a hashtable is provided, it will be converted to JSON.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Accept
The 'Accept' header for the API request.
If not provided, the default will be used by GitHub's API.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Application/vnd.github+json; charset=utf-8
Accept pipeline input: False
Accept wildcard characters: False
```

### -HttpVersion
Specifies the HTTP version used for the request.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2.0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FollowRelLink
Support Pagination Relation Links per RFC5988.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -UploadFilePath
The file path to be used for the API request.
This is used for uploading files.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadFilePath
The file path to be used for the API response.
This is used for downloading files.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URI
The full URI for the API request.
This is used for custom API calls.

```yaml
Type: String
Parameter Sets: Uri
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken
The secure token used for authentication in the GitHub API.
It should be stored as a SecureString to ensure it's kept safe in memory.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name AccessToken)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType
The 'Content-Type' header for the API request.
The default is 'application/vnd.github+json'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Application/vnd.github+json; charset=utf-8
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
The GitHub API version to be used.
By default, it pulls from a configuration script variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name ApiVersion)
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

## NOTES

## RELATED LINKS

