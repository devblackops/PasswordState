function Get-PasswordStateAllPasswords {
    <#
        .SYNOPSIS
            Get all passwords in all shared password lists in PasswordState.
        .DESCRIPTION
            Get all passwords in all shared password lists in PasswordState.
        .PARAMETER SystemApiKey
            The system API key for PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .PARAMETER UseV6Api
            PasswordState versions prior to v7 did not support passing the API key in a HTTP header
            but instead expected the API key to be passed as a query parameter. This switch is used for 
            backwards compatibility with older PasswordState versions.
        .EXAMPLE
            $allPasswords = Get-PasswordStateAllPasswords -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
        .EXAMPLE
            $allPasswords = Get-PasswordStateAllPasswords -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local' -format xml
        .EXAMPLE
            Get-PasswordStateAllPasswords -SystemApiKey $key -Endpoint 'https://passwordstate.local' | fl
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$SystemApiKey,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [switch]$PreventAuditing,

        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [switch]$UseV6Api
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
        $headers['APIKey'] = $SystemApiKey.GetNetworkCredential().password    
        $uri = "$Endpoint/passwords/?format=$Format&QueryAll"
    } else {
        $uri = "$Endpoint/passwords/?apikey=$($SystemApiKey.GetNetworkCredential().password)&format=$Format&QueryAll"
    }  

    if ($PSBoundParameters.ContainsKey('PreventAuditing')) {
        $uri += '&PreventAuditing=true'
    }
    
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}