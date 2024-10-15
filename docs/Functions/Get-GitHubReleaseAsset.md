---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubReleaseAsset

## SYNOPSIS
List release assets based on a release ID or asset ID

## SYNTAX

### ID
```powershell
Get-GitHubReleaseAsset [-Owner <String>] [-Repo <String>] -ID <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ReleaseID
```powershell
Get-GitHubReleaseAsset [-Owner <String>] [-Repo <String>] -ReleaseID <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
If an asset ID is provided, the asset is returned.
If a release ID is provided, all assets for the release are returned.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubReleaseAsset -Owner 'octocat' -Repo 'hello-world' -ID '1234567'
```

Gets the release asset with the ID '1234567' for the repository 'octocat/hello-world'.

### EXAMPLE 2
```powershell
Get-GitHubReleaseAsset -Owner 'octocat' -Repo 'hello-world' -ReleaseID '7654321'
```

Gets the release assets for the release with the ID '7654321' for the repository 'octocat/hello-world'.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
The unique identifier of the asset.

```yaml
Type: String
Parameter Sets: ID
Aliases: asset_id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseID
The unique identifier of the release.

```yaml
Type: String
Parameter Sets: ReleaseID
Aliases: release_id

Required: True
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

## NOTES
[Get a release asset](https://docs.github.com/rest/releases/assets#get-a-release-asset)

## RELATED LINKS

