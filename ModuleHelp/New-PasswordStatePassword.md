---
external help file: PasswordState-help.xml
Module Name: PasswordState
online version:
schema: 2.0.0
---

# New-PasswordStatePassword

## SYNOPSIS
Create a new password in PasswordState.

## SYNTAX

### UsePasswordWithFile
```
New-PasswordStatePassword -ApiKey <PSCredential> -PasswordListId <Int32> [-Endpoint <String>]
 [-Format <String>] -Title <String> -Password <SecureString> [-Username <String>] [-Description <String>]
 [-GenericField1 <String>] [-GenericField2 <String>] [-GenericField3 <String>] [-GenericField4 <String>]
 [-GenericField5 <String>] [-GenericField6 <String>] [-GenericField7 <String>] [-GenericField8 <String>]
 [-GenericField9 <String>] [-GenericField10 <String>] [-Notes <String>] [-AccountTypeID <Int32>]
 [-Url <String>] [-ExpiryDate <String>] [-AllowExport <Boolean>] [-GenerateGenFieldPassword] [-UseV6Api]
 -DocumentPath <String> -DocumentName <String> -DocumentDescription <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### UsePassword
```
New-PasswordStatePassword -ApiKey <PSCredential> -PasswordListId <Int32> [-Endpoint <String>]
 [-Format <String>] -Title <String> -Password <SecureString> [-Username <String>] [-Description <String>]
 [-GenericField1 <String>] [-GenericField2 <String>] [-GenericField3 <String>] [-GenericField4 <String>]
 [-GenericField5 <String>] [-GenericField6 <String>] [-GenericField7 <String>] [-GenericField8 <String>]
 [-GenericField9 <String>] [-GenericField10 <String>] [-Notes <String>] [-AccountTypeID <Int32>]
 [-Url <String>] [-ExpiryDate <String>] [-AllowExport <Boolean>] [-GenerateGenFieldPassword] [-UseV6Api]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GenPasswordWithFile
```
New-PasswordStatePassword -ApiKey <PSCredential> -PasswordListId <Int32> [-Endpoint <String>]
 [-Format <String>] -Title <String> [-Username <String>] [-Description <String>] [-GenericField1 <String>]
 [-GenericField2 <String>] [-GenericField3 <String>] [-GenericField4 <String>] [-GenericField5 <String>]
 [-GenericField6 <String>] [-GenericField7 <String>] [-GenericField8 <String>] [-GenericField9 <String>]
 [-GenericField10 <String>] [-Notes <String>] [-AccountTypeID <Int32>] [-Url <String>] [-ExpiryDate <String>]
 [-AllowExport <Boolean>] [-GeneratePassword] [-GenerateGenFieldPassword] [-UseV6Api] -DocumentPath <String>
 -DocumentName <String> -DocumentDescription <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GenPassword
```
New-PasswordStatePassword -ApiKey <PSCredential> -PasswordListId <Int32> [-Endpoint <String>]
 [-Format <String>] -Title <String> [-Username <String>] [-Description <String>] [-GenericField1 <String>]
 [-GenericField2 <String>] [-GenericField3 <String>] [-GenericField4 <String>] [-GenericField5 <String>]
 [-GenericField6 <String>] [-GenericField7 <String>] [-GenericField8 <String>] [-GenericField9 <String>]
 [-GenericField10 <String>] [-Notes <String>] [-AccountTypeID <Int32>] [-Url <String>] [-ExpiryDate <String>]
 [-AllowExport <Boolean>] [-GeneratePassword] [-GenerateGenFieldPassword] [-UseV6Api] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new password in PasswordState.

## EXAMPLES

### EXAMPLE 1
```
New-PasswordStatePassword -ApiKey $key -PasswordListId 1 -Title 'testPassword' -Username 'testPassword' -Description 'this is a test' -GeneratePassword
```

Create a new password entry with an auto-generated password in list with ID 1 and tile of 'testPassword'

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

### -PasswordListId
The Id of the password list in PasswordState.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
Position: Named
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
Position: Named
Default value: Json
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
The title field for the password entry.

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

### -Password
The password field for the password entry.

```yaml
Type: SecureString
Parameter Sets: UsePasswordWithFile, UsePassword
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username
The username field for the password entry.

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

### -Description
The description field for the password entry.

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

### -GenericField1
The generic field 1 for the password entry.

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

### -GenericField2
The generic field 2 for the password entry.

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

### -GenericField3
The generic field 3 for the password entry.

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

### -GenericField4
The generic field 4 for the password entry.

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

### -GenericField5
The generic field 5 for the password entry.

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

### -GenericField6
The generic field 6 for the password entry.

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

### -GenericField7
The generic field 7 for the password entry.

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

### -GenericField8
The generic field 8 for the password entry.

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

### -GenericField9
The generic field 9 for the password entry.

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

### -GenericField10
The generic field 10 for the password entry.

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

### -Notes
The notes field for the password entry.

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

### -AccountTypeID
The account type id number for the password entry.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
The url field for the password entry.

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

### -ExpiryDate
The expire field for the password entry.

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

### -AllowExport
Allow the password to be exported

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GeneratePassword
If set to true, a newly generated random password will be created based on the Password Generator options associated with the Password List.
If the Password List is set to use the user's Password Generator options, the Default Password Generator options will be used instead.

```yaml
Type: SwitchParameter
Parameter Sets: GenPasswordWithFile, GenPassword
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateGenFieldPassword
If set to true, any 'Generic Fields' which you have set to be of type 'Password' will have a newly generated random password assigned to it.
If the Password List or Generic Field is set to use the user's Password Generator options, the Default Password Generator options will be used instead.

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

### -UseV6Api
PasswordState versions prior to v7 did not support passing the API key in a HTTP header but instead expected the API key to be passed as a query parameter.
This switch is used for  backwards compatibility with older PasswordState versions.

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

### -WhatIf
Do not create a new password entry, just show -WhatIf message.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DocumentDescription
The description of the document shown in PasswordState

```yaml
Type: String
Parameter Sets: UsePasswordWithFile, GenPasswordWithFile
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
Parameter Sets: UsePasswordWithFile, GenPasswordWithFile
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
Parameter Sets: UsePasswordWithFile, GenPasswordWithFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
