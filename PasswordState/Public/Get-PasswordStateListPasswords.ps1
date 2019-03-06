function Get-PasswordStateListPasswords {
    <#
    .SYNOPSIS
        Get all passwords in a PasswordState list.
    .DESCRIPTION
        Get all passwords in a PasswordState list.
    .PARAMETER ApiKey
        The API key for the password list.
    .PARAMETER PasswordListId
        The Id of the password list in PasswordState.
    .PARAMETER Endpoint
        The Uri of your PasswordState site.
        (i.e. https://passwordstate.local)
    .PARAMETER Format
        The response format from PasswordState.
        Choose either json or xml.
    .PARAMETER UseV6Api
        PasswordState versions prior to v7 did not support passing the API key in a HTTP header
        but instead expected the API key to be passed as a query parameter.
        This switch is used for backwards compatibility with older PasswordState versions.
    .PARAMETER ExcludePasswords
        Exclude the password from return results.
    .EXAMPLE
        PS C:\> $passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local'

        Get all password entries from list ID 1234.
    .EXAMPLE
        PS C:\> $passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId $id -Endpoint 'https://passwordstate.local' -format xml

        Get all password entries from list ID 1234 in XML format.
    .EXAMPLE
        PS C:\> Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local' | fl

        Get all password entries from list ID 1234 and pipe to Format-List.
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true)]
        [int]$PasswordListId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [switch]$UseV6Api,

        [switch]$ExcludePasswords
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
        $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
        $uri = "$Endpoint/passwords/$PasswordListId" + "?format=$Format&QueryAll"
    } else {
        $uri = "$Endpoint/passwords/$PasswordListId" + "?apikey=$($ApiKey.GetNetworkCredential().password)&format=$Format&QueryAll"
    }

    if ($ExcludePasswords){$uri=$uri+"&ExcludePassword=true"}
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}
