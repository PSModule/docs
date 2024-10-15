---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# New-GitHubReleaseNote

## SYNOPSIS
List releases

## SYNTAX

```powershell
New-GitHubReleaseNote [[-Owner] <String>] [[-Repo] <String>] [-TagName] <String> [[-TargetCommitish] <String>]
 [[-PreviousTagName] <String>] [[-ConfigurationFilePath] <String>] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generate a name and body describing a [release](https://docs.github.com/en/rest/releases/releases#get-a-release).
The body content will be Markdown formatted and contain information like
the changes since last release and users who contributed.
The generated release notes are not saved anywhere.
They are
intended to be generated and used when creating a new release.

## EXAMPLES

### EXAMPLE 1
```powershell
$params = @{
    Owner                 = 'octocat'
    Repo                  = 'hello-world'
    TagName               = 'v1.0.0'
}
New-GitHubReleaseNote @params
```

Creates a new release notes draft for the repository 'hello-world' owned by 'octocat' with the tag name 'v1.0.0'.
In this example the tag 'v1.0.0' has to exist in the repository.
The configuration file '.github/release.yml' or '.github/release.yaml' will be used.

### EXAMPLE 2
```powershell
$params = @{
    Owner                 = 'octocat'
    Repo                  = 'hello-world'
    TagName               = 'v1.0.0'
    TargetCommitish       = 'main'
}
New-GitHubReleaseNote @params
```

Creates a new release notes draft for the repository 'hello-world' owned by 'octocat' with the tag name 'v1.0.0'.
In this example the tag 'v1.0.0' has to exist in the repository.

### EXAMPLE 3
```powershell
$params = @{
    Owner                 = 'octocat'
    Repo                  = 'hello-world'
    TagName               = 'v1.0.0'
    TargetCommitish       = 'main'
    PreviousTagName       = 'v0.9.2'
    ConfigurationFilePath = '.github/custom_release_config.yml'
}
New-GitHubReleaseNote @params
```

Creates a new release notes draft for the repository 'hello-world' owned by 'octocat' with the tag name 'v1.0.0'.
The release notes will be based on the changes between the tags 'v0.9.2' and 'v1.0.0' and generated based on the
configuration file located in the repository at '.github/custom_release_config.yml'.

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

### -TagName
The tag name for the release.
This can be an existing tag or a new one.

```yaml
Type: String
Parameter Sets: (All)
Aliases: tag_name

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetCommitish
Specifies the commitish value that will be the target for the release's tag.
Required if the supplied tag_name does not reference an existing tag.
Ignored if the tag_name already exists.

```yaml
Type: String
Parameter Sets: (All)
Aliases: target_commitish

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreviousTagName
The name of the previous tag to use as the starting point for the release notes.
Use to manually specify the range for the set of changes considered as part this release.

```yaml
Type: String
Parameter Sets: (All)
Aliases: previous_tag_name

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigurationFilePath
Specifies a path to a file in the repository containing configuration settings used for generating the release notes.
If unspecified, the configuration file located in the repository at '.github/release.yml' or '.github/release.yaml' will be used.
If that is not present, the default configuration will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: configuration_file_path

Required: False
Position: 6
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
[Generate release notes content for a release](https://docs.github.com/rest/releases/releases#list-releases)

## RELATED LINKS

