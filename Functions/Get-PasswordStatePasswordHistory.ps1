function Get-PasswordStatePasswordHistory {
    <#
        .SYNOPSIS
            Get the history for a given password in PasswordState.
        .DESCRIPTION
            Get the history for a given password in PasswordState.
        .PARAMETER ApiKey
            The API key for the password list
        .PARAMETER PasswordId
            The Id of the password in PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .EXAMPLE
            $history = Get-PasswordStatePasswordHistory -ApiKey $key -PasswordId 1234 -Endpoint 'https://passwordstate.local'
        .EXAMPLE
            $history = Get-PasswordStatePasswordHistory -ApiKey $key -PasswordId $id -Endpoint 'https://passwordstate.local' -format xml
        .EXAMPLE
            Get-PasswordStatePasswordHistory -ApiKey $key -PasswordId 1234 -Endpoint 'https://passwordstate.local' | fl
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
    $uri = ("$Endpoint/passwordhistory/$PasswordId" + "?apikey=$($ApiKey.GetNetworkCredential().password)&format=$Format")
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}