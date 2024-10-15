---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Start-GitHubWorkflow

## SYNOPSIS
Start a workflow run using the workflow's ID.

## SYNTAX

```powershell
Start-GitHubWorkflow [[-Owner] <String>] [[-Repo] <String>] [-ID] <String> [[-Ref] <String>]
 [[-Inputs] <Hashtable>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Start a workflow run using the workflow's ID.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubWorkflow | Where-Object name -NotLike '.*' | Start-GitHubWorkflow -Inputs @{
    staticValidation = $true
    deploymentValidation = $false
    removeDeployment = $true
    prerelease = $false
}
```

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
The ID of the workflow.

```yaml
Type: String
Parameter Sets: (All)
Aliases: workflow_id

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Ref
The reference of the workflow run.
The reference can be a branch, tag, or a commit SHA.

```yaml
Type: String
Parameter Sets: (All)
Aliases: branch, tag

Required: False
Position: 4
Default value: Main
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Inputs
Input parameters for the workflow run.
You can use the inputs and payload keys to pass custom data to your workflow.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: @{}
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
[Create a workflow dispatch event](https://docs.github.com/en/rest/actions/workflows#create-a-workflow-dispatch-event)

## RELATED LINKS

