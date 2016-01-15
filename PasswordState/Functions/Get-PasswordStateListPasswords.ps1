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
        .PARAMETER UseV6Api
            PasswordState versions prior to v7 did not support passing the API key in a HTTP header
            but instead expected the API key to be passed as a query parameter. This switch is used for 
            backwards compatibility with older PasswordState versions.
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
        [string]$Format = 'json',

        [switch]$UseV6Api
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
        $headers['APIKey'] = $ApiKey.GetNetworkCredential().password    
        $uri = "$Endpoint/passwords/$PasswordListId" + "?format=$Format&QueryAll"
    } else {
        $uri = "$Endpoint/passwords/$PasswordListId" + "?apikey=$($ApiKey.GetNetworkCredential().password)&format=$Format&QueryAll"
    }  

    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}