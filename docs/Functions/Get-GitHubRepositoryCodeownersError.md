---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubRepositoryCodeownersError

## SYNOPSIS
List CODEOWNERS errors

## SYNTAX

```powershell
Get-GitHubRepositoryCodeownersError [[-Owner] <String>] [[-Repo] <String>] [[-Ref] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
List any syntax errors that are detected in the CODEOWNERS file.

For more information about the correct CODEOWNERS syntax,
see "[About code owners](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)."

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubRepositoryCodeownersError -Owner 'PSModule' -Repo 'GitHub'
```

Gets the CODEOWNERS errors for the repository.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: org

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

### -Ref
A branch, tag or commit name used to determine which version of the CODEOWNERS file to use.
Default: the repository's default branch (e.g.
main)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
[List CODEOWNERS errors](https://docs.github.com/rest/repos/repos#list-codeowners-errors)

## RELATED LINKS

