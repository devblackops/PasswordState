---
external help file: PasswordState-help.xml
online version: 
schema: 2.0.0
---

# New-PasswordStateRandomPassword
## SYNOPSIS
Generate a random password from PasswordState.

## SYNTAX

### UseGenerator
```
New-PasswordStateRandomPassword -ApiKey <PSCredential> [-UseV6Api] [-Endpoint <String>] [-Quantity <Int32>]
 -GeneratorId <Int32> [-WhatIf] [-Confirm]
```

### NoGenerator
```
New-PasswordStateRandomPassword -ApiKey <PSCredential> [-UseV6Api] [-Endpoint <String>] [-Quantity <Int32>]
 [-AlphaSpecial <Boolean>] [-WordPhrases <Boolean>] [-MinLength <Int32>] [-MaxLength <Int32>]
 [-LowerCase <Boolean>] [-UpperCase <Boolean>] [-Numeric <Boolean>] [-HigherAlphaRatio <Boolean>]
 [-AmbiguousChars <Boolean>] [-SpecialChars <Boolean>] [-SpecialCharList <String>] [-BracketChars <Boolean>]
 [-BracketCharsList <String>] [-NumberOfWords <Int32>] [-MaxWordLength <Int32>] [-PrefexAppend <String>]
 [-SeperateWords <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Generate a random password from PasswordState.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-PasswordStateRandomPassword
```

Generate a new random password with defaults

### -------------------------- EXAMPLE 2 --------------------------
```
New-PasswordStateRandomPassword -Quantity 10
```

Generate 10 random passwords

### -------------------------- EXAMPLE 3 --------------------------
```
New-PasswordStateRandomPassword -Quantity 10 -WordPhrases $false -MinLength 20
```

Generate 10 random passwords without word phrases and a minimum length of 20 characters.

### -------------------------- EXAMPLE 4 --------------------------
```
New-PasswordStateRandomPassword -WordPhrases $false -MinLength 20 -UpperCase $true -LowerCase $false
```

Generate a random password without word phrases, a minimum length of 20 characters and only uppercase characters.

### -------------------------- EXAMPLE 5 --------------------------
```
New-PasswordStateRandomPassword -MinLength 20 -NumberOfWords 2
```

Generate a new random password that is at least 20 characters longs and uses two words.

## PARAMETERS

### -ApiKey
The password generator API key.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: 
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

### -Quantity
The quantity of passwords to generate.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlphaSpecial
Include Alphanumerics and special characters.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -WordPhrases
Include word phrases - a random word will be generated.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinLength
Minimum length for alphanumercis and special characters.

```yaml
Type: Int32
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: 8
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxLength
Maximum length for alphanumercis and special characters.

```yaml
Type: Int32
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LowerCase
Include lowercase characters.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpperCase
Include uppercase characters.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -Numeric
Include numeric characters.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -HigherAlphaRatio
Include higher ratio of alphanumerics vs special characters.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -AmbiguousChars
Include ambiguous characters - such as I, l, and 1.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SpecialChars
Include special characters.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -SpecialCharList
List of special characters - such as !#$%^&*+/=_-.

```yaml
Type: String
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -BracketChars
Include brackets.

```yaml
Type: Boolean
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BracketCharsList
List of brackets - such as \[\](){}\<\>.

```yaml
Type: String
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -NumberOfWords
The number of words to include.

```yaml
Type: Int32
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxWordLength
Maximum word length to generate.

```yaml
Type: Int32
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: 8
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrefexAppend
P to Prefix the Word, A to Append and I to Insert.

```yaml
Type: String
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: P
Accept pipeline input: False
Accept wildcard characters: False
```

### -SeperateWords
Separate the generated Words with S for Spaces, D for Dashes and N for No Separation.

```yaml
Type: String
Parameter Sets: NoGenerator
Aliases: 

Required: False
Position: Named
Default value: D
Accept pipeline input: False
Accept wildcard characters: False
```

### -GeneratorId
Password generate policy Id from PasswordState.

```yaml
Type: Int32
Parameter Sets: UseGenerator
Aliases: 

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Do not generate a random password, just show -WhatIf message.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: 
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
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

