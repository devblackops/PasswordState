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

function Find-PasswordStatePassword {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '')]
    [cmdletbinding(DefaultParameterSetName='ListSearch')]
    param(
        [Parameter(ParameterSetName='ListSearch', Mandatory=$true)]
        #[Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [pscredential]$ApiKey,

        [Parameter(ParameterSetName='GlobalSearch', Mandatory=$true)]
        #[Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [pscredential]$SystemApiKey,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [Parameter(ParameterSetName='ListSearch', Mandatory=$true)]
        [Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [int]$PasswordListId,

        [Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$SearchString,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Title,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Username,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Description,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField1,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField2,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField3,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField4,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField5,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField6,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField7,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField8,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField9,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField10,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Notes,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Url,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [datetime]$ExpireBefore,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [datetime]$ExpireAfter,
   
        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [switch]$UseV6Api
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    $params = "?format=$Format"

    if ($PSBoundParameters.ContainsKey('Title')) {
        $params += "&Title=$Title"
    }
    if ($PSBoundParameters.ContainsKey('Description')) {
        $params += "&Description=$Description"
    }
    if ($PSBoundParameters.ContainsKey('Username')) {
        $params += "&Username=$Username"
    }
    if ($PSBoundParameters.ContainsKey('GenericField1')) {
        $params += "&GenericField1=$GenericField1"
    }
    if ($PSBoundParameters.ContainsKey('GenericField2')) {
        $params += "&GenericField2=$GenericField2"
    }
    if ($PSBoundParameters.ContainsKey('GenericField3')) {
        $params += "&GenericField3=$GenericField3"
    }
    if ($PSBoundParameters.ContainsKey('GenericField4')) {
        $params += "&GenericField4=$GenericField4"
    }
    if ($PSBoundParameters.ContainsKey('GenericField5')) {
        $params += "&GenericField5=$GenericField5"
    }
    if ($PSBoundParameters.ContainsKey('GenericField6')) {
        $params += "&GenericField6=$GenericField6"
    }
    if ($PSBoundParameters.ContainsKey('GenericField7')) {
        $params += "&GenericField7=$GenericField7"
    }
    if ($PSBoundParameters.ContainsKey('GenericField8')) {
        $params += "&GenericField8=$GenericField8"
    }
    if ($PSBoundParameters.ContainsKey('GenericField9')) {
        $params += "&GenericField9=$GenericField9"
    }
    if ($PSBoundParameters.ContainsKey('GenericField10')) {
        $params += "&GenericField10=$GenericField10"
    }
    if ($PSBoundParameters.ContainsKey('Notes')) {
        $params += "&Notes=$Notes"
    }
    if ($PSBoundParameters.ContainsKey('Url')) {
        $params += "&Url=$Url"
    }      
    if ($PSBoundParameters.ContainsKey('SystemApiKey')) {     
        if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
            $headers['APIKey'] = $SystemApiKey.GetNetworkCredential().password
            $uri = "$Endpoint/searchpasswords" + "$params"
        } else {
            $uri = "$Endpoint/searchpasswords" + "$params&apikey=$($SystemApiKey.GetNetworkCredential().password)"
        }
    } else {
        if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
            $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
            $uri = "$Endpoint/searchpasswords/$PasswordListId" + "$params"
        } else {
            $uri = "$Endpoint/searchpasswords/$PasswordListId" + "$params&apikey=$($ApiKey.GetNetworkCredential().password)"
        }  
    }

    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}