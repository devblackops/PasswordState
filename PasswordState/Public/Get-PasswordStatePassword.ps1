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

function Get-PasswordStatePassword {
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
        Uri         =  "https://$Endpoint/passwords/$PasswordId"
        # Uri         =  "$Endpoint/passwords/$PasswordId"
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
