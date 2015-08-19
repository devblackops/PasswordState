function Get-PasswordStateListPasswords {
    <#
        .SYNOPSIS
            Get all passwords in a PasswordState list.
        .DESCRIPTION
            Get all passwords in a PasswordState list.
        .PARAMETER ApiKey
            The API key for the password list
        .PARAMETER PasswordListId
            The Id of the password list in PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .EXAMPLE
            $passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local'
        .EXAMPLE
            $passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId $id -Endpoint 'https://passwordstate.local' -format xml
        .EXAMPLE
            Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local' | fl
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true)]
        [int]$PasswordListId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

		[ValidateSet('json','xml')]
        [string]$Format = 'json'
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"
    $uri = ("$Endpoint/passwords/$PasswordListId" + "?apikey=$($ApiKey.GetNetworkCredential().password)&format=$Format&QueryAll")
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}