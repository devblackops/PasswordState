---
external help file: PasswordState-help.xml
online version: 
schema: 2.0.0
---

# Find-PasswordStatePassword
## SYNOPSIS
Finds a password entries using criteria

## SYNTAX

### ListSearch (Default)
```
Find-PasswordStatePassword -ApiKey <PSCredential> [-Endpoint <String>] -PasswordListId <Int32>
 [-Title <String>] [-Username <String>] [-Description <String>] [-GenericField1 <String>]
 [-GenericField2 <String>] [-GenericField3 <String>] [-GenericField4 <String>] [-GenericField5 <String>]
 [-GenericField6 <String>] [-GenericField7 <String>] [-GenericField8 <String>] [-GenericField9 <String>]
 [-GenericField10 <String>] [-Notes <String>] [-Url <String>] [-ExpireBefore <DateTime>]
 [-ExpireAfter <DateTime>] [-Format <String>] [-UseV6Api]
```

### GlobalSearch
```
Find-PasswordStatePassword -SystemApiKey <PSCredential> [-Endpoint <String>] [-Title <String>]
 [-Username <String>] [-Description <String>] [-GenericField1 <String>] [-GenericField2 <String>]
 [-GenericField3 <String>] [-GenericField4 <String>] [-GenericField5 <String>] [-GenericField6 <String>]
 [-GenericField7 <String>] [-GenericField8 <String>] [-GenericField9 <String>] [-GenericField10 <String>]
 [-Notes <String>] [-Url <String>] [-ExpireBefore <DateTime>] [-ExpireAfter <DateTime>] [-Format <String>]
 [-UseV6Api]
```

### GeneralSearch
```
Find-PasswordStatePassword [-Endpoint <String>] -PasswordListId <Int32> -SearchString <String> [-UseV6Api]
```

## DESCRIPTION
Finds a password entries using criteria

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Find-PasswordStatePassword -ApiKey $key -PasswordListId 1 -Title 'test'
```

Find password in list ID 1 with 'test' in the title

## PARAMETERS

### -ApiKey
The API key for the password list in PasswordState.

```yaml
Type: PSCredential
Parameter Sets: ListSearch
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SystemApiKey
The system API key for PasswordState.

```yaml
Type: PSCredential
Parameter Sets: GlobalSearch
Aliases: 

Required: True
Position: Named
Default value: 
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

### -PasswordListId
The Id of the password list in PasswordState.

```yaml
Type: Int32
Parameter Sets: ListSearch, GeneralSearch
Aliases: 

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchString
Search text

```yaml
Type: String
Parameter Sets: GeneralSearch
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Search for text in Title field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username
Search for text in Username field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Search for text in Description field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField1
Search for text in GenericField1 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField2
Search for text in GenericField2 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField3
Search for text in GenericField3 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField4
Search for text in GenericField4 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField5
Search for text in GenericField5 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField6
Search for text in GenericField6 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField7
Search for text in GenericField7 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField8
Search for text in GenericField8 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField9
Search for text in GenericField9 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenericField10
Search for text in GenericField10 field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
Search for text in Notes field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
Search for text in Url field

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpireBefore
Search passwords expiring before this date

```yaml
Type: DateTime
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpireAfter
Search passwords expiring after this date

```yaml
Type: DateTime
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format
The response format from PasswordState.
Choose either json or xml.

```yaml
Type: String
Parameter Sets: ListSearch, GlobalSearch
Aliases: 

Required: False
Position: Named
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

