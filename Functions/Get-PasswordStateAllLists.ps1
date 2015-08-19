function Get-PasswordStateAllLists {
    <#
        .SYNOPSIS
            Get all shared password lists in a PasswordState.
        .DESCRIPTION
            Get all shared password lists in a PasswordState.
        .PARAMETER SystemApiKey
            The system API key for PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .EXAMPLE
            $lists = Get-PasswordStateList -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
        .EXAMPLE
            $lists = Get-PasswordStateList -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local' -Format xml
        .EXAMPLE
            Get-PasswordStateList -SystemApiKey $key -Endpoint 'https://passwordstate.local' | fl
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$SystemApiKey,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

		[ValidateSet('json','xml')]
        [string]$Format = 'json'
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"
    $uri = ("$Endpoint/passwordlists?apikey=$($SystemApiKey.GetNetworkCredential().password)&format=$Format")
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}