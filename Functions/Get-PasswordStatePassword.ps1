function Get-PasswordStatePassword {
    <#
        .SYNOPSIS
            Get a password object from PasswordState.
        .DESCRIPTION
            Get a password object from PasswordState.
        .PARAMETER ApiKey
            The API key for the Password list
        .PARAMETER PasswordId
            The Id of the password in PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .EXAMPLE
            $password = Get-PasswordStatePassword -ApiKey $key -PasswordId 1234 -Endpoint 'https://passwordstate.local'
        .EXAMPLE
            $password = Get-PasswordStatePassword -ApiKey $key -PasswordId $id -Endpoint 'https://passwordstate.local' -format json
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true)]
        [int]$PasswordId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

		[ValidateSet('json','xml')]
        [string]$Format = 'json'
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"
    $uri = ("$Endpoint/passwords/$PasswordId" + "?apikey=$($ApiKey.GetNetworkCredential().password)&format=$Format")
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}