function New-PasswordStateRandomPassword {
    <#
    .SYNOPSIS
        Generate a random password from PasswordState.
    .DESCRIPTION
        Generate a random password from PasswordState.
    .PARAMETER ApiKey
        The password generator API key.
    .PARAMETER UseV6Api
        PasswordState versions prior to v7 did not support passing the API key in a HTTP header
        but instead expected the API key to be passed as a query parameter. This switch is used for
        backwards compatibility with older PasswordState versions.
    .PARAMETER Endpoint
        The Uri of your PasswordState site.
        (i.e. https://passwordstate.local)
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
        List of brackets - such as \[\](){}\<\>.
    .PARAMETER NumberOfWords
        The number of words to include.
    .PARAMETER MaxWordLength
        Maximum word length to generate.
    .PARAMETER PrefexAppend
        P to Prefix the Word, A to Append and I to Insert.
    .PARAMETER SeperateWords
        Separate the generated Words with S for Spaces, D for Dashes and N for No Separation.
    .PARAMETER GeneratorId
        Password generate policy Id from PasswordState.
    .EXAMPLE
        PS C:\> New-PasswordStateRandomPassword

        Generate a new random password with defaults
    .EXAMPLE
        PS C:\> New-PasswordStateRandomPassword -Quantity 10

        Generate 10 random passwords
    .EXAMPLE
        PS C:\> New-PasswordStateRandomPassword -Quantity 10 -WordPhrases $false -MinLength 20

        Generate 10 random passwords without word phrases and a minimum length of 20 characters.
    .EXAMPLE
        PS C:\> New-PasswordStateRandomPassword -WordPhrases $false -MinLength 20 -UpperCase $true -LowerCase $false

        Generate a random password without word phrases, a minimum length of 20 characters and only uppercase characters.
    .EXAMPLE
        PS C:\> New-PasswordStateRandomPassword -MinLength 20 -NumberOfWords 2

        Generate a new random password that is at least 20 characters longs and uses two words.
    #>
    [cmdletbinding(SupportsShouldProcess = $true)]
    param (
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [switch]$UseV6Api,

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
    #$headers['Accept'] = "application/$Format"
    $params = "?Qty=$Quantity"
    if (-not $PsBoundParameters.ContainsKey('GeneratorId')) {
        $params += "&IncludeAlphaSpecial=$AlphaSpecial&IncludeWordPhrases=$WordPhrases&minLength=$MinLength&maxLength=$MaxLength"
        $params += "&lowerCaseChars=$LowerCase&upperCaseChars=$UpperCase&numericChars=$Numeric&higherAlphaRatio=$HigherAlphaRatio"
        $params += "&ambiguousChars=$AmbiguousChars&specialChars=$SpecialChars&specialCharsText=$SpecialCharList&bracketChars=$BracketChars"
        $params += "&bracketCharsText=$BracketCharsList&NumberOfWords=$NumberOfWords&MaxWordLength=$MaxWordLength&PrefixAppend=$PrefexAppend&SeparateWords=$SeperateWords"
    } else {
        $params += "&PasswordGeneratorID=$GeneratorId"
    }

    if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
        $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
        $uri = "$Endpoint/generatepassword/$params"
    } else {
        $uri = "$Endpoint/generatepassword/$params" + "&apikey=$($ApiKey.GetNetworkCredential().password)"
    }

    If ($PSCmdlet.ShouldProcess("Creating new random password using params:`n$($params | ConvertTo-Json)")) {
        $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers $headers
        return $result
    }
}
