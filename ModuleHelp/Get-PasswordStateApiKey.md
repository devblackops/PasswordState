---
external help file: PasswordState-help.xml
online version: 
schema: 2.0.0
---

# Get-PasswordStateApiKey
## SYNOPSIS
List available PasswordState API keys in the repository.
## SYNTAX

```
Get-PasswordStateApiKey [[-Repository] <String>] [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
List available PasswordState API keys in the repository.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-PasswordStateApiKey
```

List all API keys from default repository
### -------------------------- EXAMPLE 2 --------------------------
```
Get-PasswordStateApiKey -Repository c:\users\joe\data\.customrepo
```

List all API keys from 'c:\users\joe\data\.customrepo' repository
## PARAMETERS

### -Repository
Path to repository.
Default is $env:USERPROFILE\.passwordstate

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: (_GetDefault -Option 'credential_repository')
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of API key (without .cred extension) to get.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: [string]::empty
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

