function New-PasswordStateRandomPassword {
    <#
        .SYNOPSIS
            Generate a random password from PasswordState.
        .DESCRIPTION
            Generate a random password from PasswordState.
        .PARAMETER Quantity
            The quantity of passwords to generate.
        .PARAMETER AlphaSpecial
            Include Alphanumerics and special characters.
        .PARAMETER WordPhrases
            Include word phrases - a random word will be generated.
        .PARAMETER MinLength
            Minimum length for alphanumercis and special characters.
        .PARAMETER MaxLength
            Maximum length for alphanumercis and special characters.
        .PARAMETER LowerCase
            Include lowercase characters.
        .PARAMETER UpperCase
            Include uppercase characters.
        .PARAMETER Numeric
            Include numeric characters.
        .PARAMETER HigherAlphaRatio
            Include higher ratio of alphanumerics vs special characters.
        .PARAMETER AmbiguousChars
            Include ambiguous characters - such as I, l, and 1.
        .PARAMETER SpecialChars
            Include special characters.
        .PARAMETER SpecialCharList
            List of special characters - such as !#$%^&*+/=_-.
        .PARAMETER BracketChars
            Include brackets.
        .PARAMETER BracketCharsList
            List of brackets - such as [](){}<>.
        .PARAMETER NumberOfWords
            The number of words to include.
        .PARAMETER NumberOfWords
            Maximum word length to generate.
        .PARAMETER MaxWordLength
            Maximum word length to generate.
        .PARAMETER PrefexAppend
            P to Prefix the Word, A to Append and I to Insert.
        .PARAMETER SeperateWords
            Separate the generated Words with S for Spaces, D for Dashes and N for No Separation.
        .PARAMETER GeneratorId
            Password generate policy Id from PasswordState.
        .EXAMPLE
            New-PasswordStateRandomPassword
        .EXAMPLE
            New-PasswordStateRandomPassword -Quantity 10
        .EXAMPLE
            New-PasswordStateRandomPassword -Quantity 10 -WordPhrases $false -MinLength 20
        .EXAMPLE
            New-PasswordStateRandomPassword -WordPhrases $false -MinLength 20 -UpperCase $true -LowerCase $false
        .EXAMPLE
            New-PasswordStateRandomPassword -MinLength 20 -NumberOfWords 2
    #>
    [cmdletbinding()]
    param (
        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [Parameter(ParameterSetName='NoGenerator')]
        [Parameter(ParameterSetName='UseGenerator')]
        [int]$Quantity = 1,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$AlphaSpecial = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$WordPhrases = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [int]$MinLength = 8,

        [Parameter(ParameterSetName='NoGenerator')]
        [int]$MaxLength,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$LowerCase = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$UpperCase = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$Numeric = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$HigherAlphaRatio = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$AmbiguousChars = $false,

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$SpecialChars = $true,

        [Parameter(ParameterSetName='NoGenerator')]
        [string]$SpecialCharList = '',

        [Parameter(ParameterSetName='NoGenerator')]
        [bool]$BracketChars = $false,

        [Parameter(ParameterSetName='NoGenerator')]
        [string]$BracketCharsList = '',

        [Parameter(ParameterSetName='NoGenerator')]
        [int]$NumberOfWords = 3,

        [Parameter(ParameterSetName='NoGenerator')]
        [int]$MaxWordLength = 8,

        [Parameter(ParameterSetName='NoGenerator')]
        [ValidateSet('P','A','I')]
        [string]$PrefexAppend='P',

        [Parameter(ParameterSetName='NoGenerator')]
        [ValidateSet('S','D','N')]
        [string]$SeperateWords = 'D',

        [Parameter(ParameterSetName='UseGenerator', Mandatory = $true)]
        [int]$GeneratorId
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"
    $params = "?Qty=$Quantity"
    if (-not $PsBoundParameters.ContainsKey('GeneratorId')) {
        $params += "&IncludeAlphaSpecial=$AlphaSpecial&IncludeWordPhrases=$WordPhrases&minLength=$MinLength&maxLength=$MaxLength"
        $params += "&lowerCaseChars=$LowerCase&upperCaseChars=$UpperCase&numericChars=$Numeric&higherAlphaRatio=$HigherAlphaRatio"
        $params += "&ambiguousChars=$AmbiguousChars&specialChars=$SpecialChars&specialCharsText=$SpecialCharList&bracketChars=$BracketChars"
        $params += "&bracketCharsText=$BracketCharsList&NumberOfWords=$NumberOfWords&MaxWordLength=$MaxWordLength&PrefixAppend=$PrefexAppend&SeparateWords=$SeperateWords"
    } else {
        $params += "&PasswordGeneratorID=$GeneratorId"
    }

    $uri = "$Endpoint/generatepassword/$params"
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
        
}