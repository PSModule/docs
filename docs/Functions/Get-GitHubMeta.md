---
external help file: GitHub-help.xml
Module Name: GitHub
online version:
schema: 2.0.0
---

# Get-GitHubMeta

## SYNOPSIS
Get GitHub meta information.

## SYNTAX

```powershell
Get-GitHubMeta [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns meta information about GitHub, including a list of GitHub's IP addresses.
For more information, see
"[About GitHub's IP addresses](https://docs.github.com/articles/about-github-s-ip-addresses/)."

The API's response also includes a list of GitHub's domain names.

The values shown in the documentation's response are example values.
You must always query the API directly to get the latest values.

**Note:** This endpoint returns both IPv4 and IPv6 addresses.
However, not all features support IPv6.
You should refer to the specific
documentation for each feature to determine if IPv6 is supported.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GitHubMeta
```

Returns meta information about GitHub, including a list of GitHub's IP addresses.

## PARAMETERS

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

### System.Object
## NOTES
[Get GitHub meta information](https://docs.github.com/rest/meta/meta#get-apiname-meta-information)

## RELATED LINKS

