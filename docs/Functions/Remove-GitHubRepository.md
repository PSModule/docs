---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Remove-GitHubRepository

## SYNOPSIS
Delete a repository

## SYNTAX

```powershell
Remove-GitHubRepository [-Owner] <String> [-Repo] <String> [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deleting a repository requires admin access.
If OAuth is used, the `delete_repo` scope is required.

If an organization owner has configured the organization to prevent members from deleting organization-owned
repositories, you will get a `403 Forbidden` response.

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-GitHubRepository -Owner 'PSModule' -Repo 'Hello-World'
```

Deletes the repository `Hello-World` in the `PSModule` organization.

## PARAMETERS

### -Owner
The account owner of the repository.
The name is not case sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: login, org

Required: True
Position: 1
Default value: None
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

Required: True
Position: 2
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

## NOTES
[Delete a repository](https://docs.github.com/rest/repos/repos#delete-a-repository)

## RELATED LINKS

