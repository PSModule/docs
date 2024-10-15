---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Start-GitHubRepositoryEvent

## SYNOPSIS
Create a repository dispatch event

## SYNTAX

```powershell
Start-GitHubRepositoryEvent [[-Owner] <String>] [[-Repo] <String>] [-EventType] <String>
 [[-ClientPayload] <Object>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
You can use this endpoint to trigger a webhook event called `repository_dispatch` when you want activity
that happens outside of GitHub to trigger a GitHub Actions workflow or GitHub App webhook.
You must configure
your GitHub Actions workflow or GitHub App to run when the `repository_dispatch`
event occurs.
For an example `repository_dispatch` webhook payload, see
"[RepositoryDispatchEvent](https://docs.github.com/webhooks/event-payloads/#repository_dispatch)."

The `client_payload` parameter is available for any extra information that your workflow might need.
This parameter is a JSON payload that will be passed on when the webhook event is dispatched.
For example,
the `client_payload` can include a message that a user would like to send using a GitHub Actions workflow.
Or the `client_payload` can be used as a test to debug your workflow.

This endpoint requires write access to the repository by providing either:

- Personal access tokens with `repo` scope.
For more information, see
"[Creating a personal access token for the command line](https://docs.github.com/articles/creating-a-personal-access-token-for-the-command-line)"
in the GitHub Help documentation.
- GitHub Apps with both `metadata:read` and `contents:read&write` permissions.

This input example shows how you can use the `client_payload` as a test to debug your workflow.

## EXAMPLES

### EXAMPLE 1
```powershell
$params = @{
    EventType = 'on-demand-test'
    ClientPayload = @{
        unit = false
        integration = true
    }
}
Start-GitHubRepositoryEvent @params
```

Starts a repository event with the name `on-demand-test` and a `client_payload` that includes `unit` and `integration`.

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

### -EventType
A custom webhook event name.
Must be 100 characters or fewer.

```yaml
Type: String
Parameter Sets: (All)
Aliases: event_type

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientPayload
JSON payload with extra information about the webhook event that your action or workflow may use.
The maximum number of top-level properties is 10.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: client_payload

Required: False
Position: 4
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
[Create a repository dispatch event](https://docs.github.com/rest/repos/repos#create-a-repository-dispatch-event)

## RELATED LINKS

