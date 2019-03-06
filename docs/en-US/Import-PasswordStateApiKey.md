---
external help file: PasswordState-help.xml
Module Name: PasswordState
online version:
schema: 2.0.0
---

# Import-PasswordStateApiKey

## SYNOPSIS
Imports a PasswordState API key.

## SYNTAX

```
Import-PasswordStateApiKey [-Name] <String[]> [[-Repository] <String>] [<CommonParameters>]
```

## DESCRIPTION
Imports a given PasswordState API key from the repository.

## EXAMPLES

### EXAMPLE 1
```
$cred = Import-PasswordStateApiKey -Name personal
```

Import the 'personal' API key from the default repository location.

### EXAMPLE 2
```
$cred = Import-PasswordStateApiKey -Name personal -Repository c:\users\joe\data\.customrepo
```

Import the 'personal' API key from the 'c:\users\joe\data\.customrepo' repository.

## PARAMETERS

### -Name
Name of the key to retrieve.
Do not include the file extension.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Repository
Path to repository.
Default is $env:HOME\.passwordstate

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
