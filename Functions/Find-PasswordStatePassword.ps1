function Find-PasswordStatePassword {
    <#
        .SYNOPSIS
            Get all passwords in all shared password lists in PasswordState.
        .DESCRIPTION
            Get all passwords in all shared password lists in PasswordState.
        .PARAMETER ApiKey
            The API key for the password list
        .PARAMETER SystemApiKey
            The system API key for PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .EXAMPLE
            $allPasswords = Get-PasswordStateAllPasswords -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
        .EXAMPLE
            $allPasswords = Get-PasswordStateAllPasswords -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local' -format xml
        .EXAMPLE
            Get-PasswordStateAllPasswords -SystemApiKey $key -Endpoint 'https://passwordstate.local' | fl
    #>
    [cmdletbinding()]
    param(
        [Parameter(ParameterSetName='ListSearch', Mandatory=$true)]
        #[Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [pscredential]$ApiKey,

        [Parameter(ParameterSetName='GlobalSearch', Mandatory=$true)]
        #[Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [pscredential]$SystemApiKey,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [Parameter(ParameterSetName='ListSearch', Mandatory=$true)]
        [Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [int]$PasswordListId,

        [Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$SearchString,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Title,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Username,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Description,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField1,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField2,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField3,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField4,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField5,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField6,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField7,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField8,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField9,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField10,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Notes,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Url,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [datetime]$ExpireBefore,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [datetime]$ExpireAfter,
   
        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [ValidateSet('json','xml')]
        [string]$Format = 'json'
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    $params = "?format=$Format"

    if ($PSBoundParameters.ContainsKey('Title')) {
        $params += "&Title=$Title"
    }
    if ($PSBoundParameters.ContainsKey('Description')) {
        $params += "&Description=$Description"
    }
    if ($PSBoundParameters.ContainsKey('GenericField1')) {
        $params += "&GenericField1=$GenericField1"
    }
    if ($PSBoundParameters.ContainsKey('GenericField2')) {
        $params += "&GenericField2=$GenericField2"
    }
    if ($PSBoundParameters.ContainsKey('GenericField3')) {
        $params += "&GenericField3=$GenericField3"
    }
    if ($PSBoundParameters.ContainsKey('GenericField4')) {
        $params += "&GenericField4=$GenericField4"
    }
    if ($PSBoundParameters.ContainsKey('GenericField5')) {
        $params += "&GenericField5=$GenericField5"
    }
    if ($PSBoundParameters.ContainsKey('GenericField6')) {
        $params += "&GenericField6=$GenericField6"
    }
    if ($PSBoundParameters.ContainsKey('GenericField7')) {
        $params += "&GenericField7=$GenericField7"
    }
    if ($PSBoundParameters.ContainsKey('GenericField8')) {
        $params += "&GenericField8=$GenericField8"
    }
    if ($PSBoundParameters.ContainsKey('GenericField9')) {
        $params += "&GenericField9=$GenericField9"
    }
    if ($PSBoundParameters.ContainsKey('GenericField10')) {
        $params += "&GenericField10=$GenericField10"
    }
    if ($PSBoundParameters.ContainsKey('Notes')) {
        $params += "&Notes=$Notes"
    }
    if ($PSBoundParameters.ContainsKey('Url')) {
        $params += "&Url=$Url"
    }      
    if ($PSBoundParameters.ContainsKey('SystemApiKey')) {        
        $uri = "$Endpoint/searchpasswords" + "$params&apikey=$($SystemApiKey.GetNetworkCredential().password)"
    } else {
        $uri = "$Endpoint/searchpasswords/$PasswordListId" + "$params&apikey=$($ApiKey.GetNetworkCredential().password)"
    }
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result    
}