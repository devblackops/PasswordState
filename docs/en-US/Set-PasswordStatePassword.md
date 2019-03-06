---
external help file: PasswordState-help.xml
Module Name: PasswordState
online version:
schema: 2.0.0
---

# Set-PasswordStatePassword

## SYNOPSIS
Updates an existing password in PasswordState.

## SYNTAX

```
Set-PasswordStatePassword -ApiKey <PSCredential> -PasswordId <Int32> [-Endpoint <String>] [-Format <String>]
 [-Title <String>] [-Password <SecureString>] [-Username <String>] [-Description <String>]
 [-GenericField1 <String>] [-GenericField2 <String>] [-GenericField3 <String>] [-GenericField4 <String>]
 [-GenericField5 <String>] [-GenericField6 <String>] [-GenericField7 <String>] [-GenericField8 <String>]
 [-GenericField9 <String>] [-GenericField10 <String>] [-Notes <String>] [-Url <String>] [-ExpiryDate <String>]
 [-AllowExport <Boolean>] [-GeneratePassword] [-GenerateGenFieldPassword] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates an existing password in PasswordState.

## EXAMPLES

### EXAMPLE 1
```
Set-PasswordStatePassword -ApiKey $key -PasswordId 1234 -GeneratePassword
```

Change the password for entry 1234 to a new randomly generated one.

### EXAMPLE 2
```
Set-PasswordStatePassword -ApiKey $key -PasswordId 1234 -Username 'mypassword'
```

Change the username for entry 1234 to mypassword.

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

### -PasswordId
The Id of the password in PasswordState.

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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password field for the password entry.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
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
Allow the password to be expored.

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
Parameter Sets: (All)
Aliases:

Required: False
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
