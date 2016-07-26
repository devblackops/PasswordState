---
external help file: PasswordState-help.xml
online version: 
schema: 2.0.0
---

# Get-PasswordStateListPasswords
## SYNOPSIS
Get all passwords in a PasswordState list.
## SYNTAX

```
Get-PasswordStateListPasswords [-ApiKey] <PSCredential> [-PasswordListId] <Int32> [[-Endpoint] <String>]
 [[-Format] <String>] [-UseV6Api] [<CommonParameters>]
```

## DESCRIPTION
Get all passwords in a PasswordState list.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local'
```

Get all password entries from list ID 1234
### -------------------------- EXAMPLE 2 --------------------------
```
$passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId $id -Endpoint 'https://passwordstate.local' -format xml
```

Get all password entries from list ID 1234 in XML format
### -------------------------- EXAMPLE 3 --------------------------
```
Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local' | fl
```

Get all password entries from list ID 1234 and pipe to Format-List
## PARAMETERS

### -ApiKey
The API key for the password list

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordListId
The Id of the password list in PasswordState.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The Uri of your PasswordState site.
(i.e.
https://passwordstate.local)

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: (_GetDefault -Option 'api_endpoint')
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format
The response format from PasswordState.
Choose either json or xml.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: Json
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseV6Api
PasswordState versions prior to v7 did not support passing the API key in a HTTP header
but instead expected the API key to be passed as a query parameter.
This switch is used for 
backwards compatibility with older PasswordState versions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

