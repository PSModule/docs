---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Disable-GitHubRepositorySecurityFix

## SYNOPSIS
Disable automated security fixes

## SYNTAX

```powershell
Disable-GitHubRepositorySecurityFix [[-Owner] <String>] [[-Repo] <String>] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disables automated security fixes for a repository.
The authenticated user must have admin access to the repository.
For more information, see
"[Configuring automated security fixes](https://docs.github.com/articles/configuring-automated-security-fixes)".

## EXAMPLES

### EXAMPLE 1
```powershell
Disable-GitHubRepositorySecurityFix -Owner 'PSModule' -Repo 'GitHub'
```

Disables automated security fixes for the repository.

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

## NOTES
[Disable automated security fixes](https://docs.github.com/rest/repos/repos#disable-automated-security-fixes)

## RELATED LINKS
