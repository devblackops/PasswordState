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

function Get-PasswordStateAllPassword {
    [CmdletBinding()]
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