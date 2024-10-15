---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubLicense

## SYNOPSIS
Get a license template, list of all popular license templates or a license for a repository

## SYNTAX

### List (Default)
```powershell
Get-GitHubLicense [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Repository
```powershell
Get-GitHubLicense [-Owner <String>] [-Repo <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Name
```powershell
Get-GitHubLicense [-ProgressAction <ActionPreference>] -Name <String> [<CommonParameters>]
```

## DESCRIPTION
If no parameters are specified, the function will return a list of all license templates.
If the Name parameter is specified, the function will return the license template for the specified name.
If the Owner and Repo parameters are specified, the function will return the license for the specified repository.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubLicense
```

Get all license templates

### EXAMPLE 2
```powershell
Get-GitHubLicense -Name mit
```

Get the mit license template

### EXAMPLE 3
```powershell
Get-GitHubLicense -Owner 'octocat' -Repo 'Hello-World'
```

Get the license for the Hello-World repository from the octocat account.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: Repository
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
Parameter Sets: Repository
Aliases:

Required: False
Position: Named
Default value: (Get-GitHubConfig -Name Repo)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: Name
Aliases:

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
[Get a license](https://docs.github.com/rest/licenses/licenses#get-a-license)
[Get all commonly used licenses](https://docs.github.com/rest/licenses/licenses#get-all-commonly-used-licenses)
[Get the license for a repository](https://docs.github.com/rest/licenses/licenses#get-the-license-for-a-repository)

## RELATED LINKS

