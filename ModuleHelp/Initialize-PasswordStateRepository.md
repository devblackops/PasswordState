---
external help file: PasswordState-help.xml
online version: 
schema: 2.0.0
---

# Initialize-PasswordStateRepository
## SYNOPSIS
Creates PasswordState configuration repository under $env:USERNAME\.passwordstate
## SYNTAX

```
Initialize-PasswordStateRepository [-ApiEndpoint] <String> [[-CredentialRepository] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates PasswordState configuration repository under $env:USERNAME\.passwordstate and options.json file to store default values used by other PasswordState cmdlets.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api'
```

Initialize the PasswordState repository with default value of 'https://passwordstate.local/api' for endpoint.
### -------------------------- EXAMPLE 2 --------------------------
```
Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -ConfigurationRepository 'C:\PasswordStateCreds'
```

Initialize the PasswordState repository with default value of 'https://passwordstate.local/api' for endpoint and 'C:\PasswordStateCreds'
for the repository location.
## PARAMETERS

### -ApiEndpoint
The Uri of your PasswordState site.
(i.e.
https://passwordstate.local/api)

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CredentialRepository
Path to credential repository.
Default is $env:USERPROFILE\.passwordstate

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: (Join-Path -path $env:USERPROFILE -ChildPath '.passwordstate' -Verbose:$false)
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

