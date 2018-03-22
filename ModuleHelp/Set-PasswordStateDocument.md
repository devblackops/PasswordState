---
external help file: PasswordState-help.xml
Module Name: PasswordState
online version:
schema: 2.0.0
---

# Set-PasswordStateDocument

## SYNOPSIS
Attach a document to an existing Password or PasswordList

## SYNTAX

### PasswordID
```
Set-PasswordStateDocument -ApiKey <PSCredential> -PasswordId <Int32> [-Endpoint <String>]
 -DocumentPath <String> -DocumentName <String> -DocumentDescription <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PasswordListID
```
Set-PasswordStateDocument -ApiKey <PSCredential> -PasswordListId <Int32> [-Endpoint <String>]
 -DocumentPath <String> -DocumentName <String> -DocumentDescription <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Attach a document to an existing Password or PasswordList

## EXAMPLES

### Example 1
```
PS C:\>  Set-PasswordStateDocument -ApiKey $key -PasswordListId 1 -DocumentPath "C:\temp\Secure.txt" -DocumentName SecureDoc.txt -DocumentDescription 'My Very Secure Document'
```

Adds the document c:\temp\Secure.txt to the Password list with ID 1

## PARAMETERS

### -ApiKey
The API key for the password list in PasswordState.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Confirm action before executing.

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

### -DocumentDescription
The description of the document shown in PasswordState

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DocumentName
The name of the file to be displayed in PasswordState, this is also the name used, when the file is downloaded from PasswordState.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DocumentPath
This is the path to the file, that is to be uploaded to PasswordState

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The Uri of your PasswordState site.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordId
The ID of the password that you want to attach a document to.

```yaml
Type: Int32
Parameter Sets: PasswordID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordListId
The ID of the password list that you want to attach a document to.

```yaml
Type: Int32
Parameter Sets: PasswordListID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Do not create a new password entry, just show -WhatIf message.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
