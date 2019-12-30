<#
Copyright 2015 Brandon Olin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

function New-PasswordStateRandomPassword {
    [CmdletBinding(SupportsShouldProcess = $true)]
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