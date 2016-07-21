---
external help file: PasswordState-help.xml
online version: 
schema: 2.0.0
---

# Export-PasswordStateApiKey
## SYNOPSIS
Exports a PowerShell credential object to the PasswordState key repository.

## SYNTAX

```
Export-PasswordStateApiKey [-ApiKey] <PSCredential[]> [[-Repository] <String>]
```

## DESCRIPTION
Exports a PowerShell credential object to the PasswordState key repository.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Export-PasswordStateApiKey -ApiKey $cred
```

Export an API key to the default PasswordState repository

### -------------------------- EXAMPLE 2 --------------------------
```
Export-PasswordStateApiKey -ApiKey $cred -Repository c:\users\joe\data\.customrepo
```

Export an API key to the 'c:\users\joe\data\.customrepo' PasswordState repository

## PARAMETERS

### -ApiKey
PowerShell credential object to export.

```yaml
Type: PSCredential[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Repository
Path to repository.
Default is $env:USERPROFILE\.passwordstate

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: (_GetDefault -Option 'credential_repository')
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

