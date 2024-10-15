---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Add-GitHubReleaseAsset

## SYNOPSIS
Upload a release asset

## SYNTAX

```powershell
Add-GitHubReleaseAsset [[-Owner] <String>] [[-Repo] <String>] [-ID] <String> [[-Name] <String>]
 [[-Label] <String>] [[-ContentType] <String>] [-FilePath] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This endpoint makes use of [a Hypermedia relation](https://docs.github.com/rest/overview/resources-in-the-rest-api#hypermedia)
to determine which URL to access.
The endpoint you call to upload release assets is specific to your release.
Use the
`upload_url` returned in
the response of the [Create a release endpoint](https://docs.github.com/rest/releases/releases#create-a-release) to upload
a release asset.

You need to use an HTTP client which supports [SNI](http://en.wikipedia.org/wiki/Server_Name_Indication) to make calls to
this endpoint.

Most libraries will set the required `Content-Length` header automatically.
Use the required `Content-Type` header to provide
the media type of the asset.
For a list of media types, see
[Media Types](https://www.iana.org/assignments/media-types/media-types.xhtml).
For example:

`application/zip`

GitHub expects the asset data in its raw binary form, rather than JSON.
You will send the raw binary content of the asset
as the request body.
Everything else about the endpoint is the same as the rest of the API.
For example,
you'll still need to pass your authentication to be able to upload an asset.

When an upstream failure occurs, you will receive a `502 Bad Gateway` status.
This may leave an empty asset with a state
of `starter`.
It can be safely deleted.

**Notes:**
* GitHub renames asset filenames that have special characters, non-alphanumeric characters, and leading or trailing periods.
The "[List release assets](https://docs.github.com/rest/releases/assets#list-release-assets)"
endpoint lists the renamed filenames.
For more information and help, contact
[GitHub Support](https://support.github.com/contact?tags=dotcom-rest-api).
* To find the `release_id` query the
[`GET /repos/{owner}/{repo}/releases/latest` endpoint](https://docs.github.com/rest/releases/releases#get-the-latest-release).
* If you upload an asset with the same filename as another uploaded asset, you'll receive an error and must delete
the old file before you can re-upload the new asset.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-GitHubReleaseAsset -Owner 'octocat' -Repo 'hello-world' -ID '7654321' -FilePath 'C:\Users\octocat\Downloads\hello-world.zip'
```

Gets the release assets for the release with the ID '1234567' for the repository 'octocat/hello-world'.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-GitHubConfig -Name Owner)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repo
The name of the repository without the .git extension.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
The unique identifier of the release.

```yaml
Type: String
Parameter Sets: (All)
Aliases: release_id

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the file asset.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
An alternate short description of the asset.
Used in place of the filename.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType
The content type of the asset.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
The path to the asset file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: fullname

Required: True
Position: 7
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

## NOTES
[Upload a release asset](https://docs.github.com/rest/releases/assets#upload-a-release-asset)

## RELATED LINKS

