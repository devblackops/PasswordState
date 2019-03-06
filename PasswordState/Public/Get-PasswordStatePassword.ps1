function Get-PasswordStatePassword {
        <#
    .SYNOPSIS
        Get a password object from PasswordState.
    .DESCRIPTION
        Get a password object from PasswordState.
    .PARAMETER Credential
        The API key for the Password list.
    .PARAMETER PasswordId
        The Id of the password in PasswordState.
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
    .PARAMETER UseWinApi
        Use Windows authentication instead of an API key.
    .PARAMETER ReturnAsCredential
        Exclude the password from return results.
    .EXAMPLE
        PS C:\> $password = Get-PasswordStatePassword -ApiKey $key -PasswordId 1234 -Endpoint 'https://passwordstate.local'

        Get a password object from PasswordState.
    .EXAMPLE
        PS C:\> $password = Get-PasswordStatePassword -ApiKey $key -PasswordId $id -Endpoint 'https://passwordstate.local' -format json

        Get password entry with ID 1234 and JSON format.
    .EXAMPLE
        PS C:\> Get-PasswordStatePassword -PasswordId $id -Endpoint 'https://passwordstate.local' -UseWinApi

        Get a password object from PasswordState using integrated Windows authentication.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Scope='Function', Target='*')]
    [cmdletbinding(DefaultParameterSetName = 'Api')]
    param(
        [parameter(Mandatory = $false,ParameterSetName = 'WinApi')]
        [parameter(Mandatory = $true, ParameterSetName = 'Api')]
        [Alias('ApiKey')]
        [pscredential]$Credential,

        [parameter(Mandatory = $true)]
        [int]$PasswordId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [switch]$UseV6Api,

        [parameter(ParameterSetName = 'WinApi')]
        [switch]$UseWinApi,

        [switch]$ReturnAsCredential
    )

    $irmParams = @{
        Method = 'Get'
        ContentType = "application/$Format"
        Uri         =  "$Endpoint/passwords/$PasswordId"
        Headers     = @{
            Accept = "application/$Format"
        }
        Verbose     = $false
    }

    if ($PSCmdlet.ParameterSetName -eq 'WinApi') {
        $irmParams.Uri = "https://$Endpoint/winapi/passwords/$PasswordID"
        if ($Credential) {
            $irmParams.Credential = $Credential
        } else {
            $irmParams.UseDefaultCredentials = $true
        }
    } else {
        if (-not $UseV6Api.IsPresent) {
            $irmParams.Headers.ApiKey = $Credential.GetNetworkCredential().password
            $irmParams.Uri += "?format=$Format"
        } else {
            $irmParams.Uri += "?apikey=$($Credential.GetNetworkCredential().password)&format=$Format"
        }
    }

    $result = Invoke-RestMethod @irmParams

    if ($ReturnAsCredential.IsPresent) {
        if (-not [string]::IsNullOrEmpty($result.Username)) {
            $u = $result.username
        } else {
            $u = 'blank'
        }
        $secPass = $result.Password | ConvertTo-SecureString -AsPlainText -Force
        $cred = [pscredential]::new($u, $secPass)
        $result | Add-Member -MemberType NoteProperty -Name Credential -Value $cred
        $result = $result | Select-Object -Property * -ExcludeProperty Password
    }

    return $result
}
