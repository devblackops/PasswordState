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

function Set-PasswordStatePassword {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '')]
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true)]
        [int]$PasswordId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [Parameter(ParameterSetName='fields')]
        [string]$Title,

        [Parameter(ParameterSetName='fields')]
        [securestring]$Password,

        [Parameter(ParameterSetName='fields')]
        [string]$Username,

        [Parameter(ParameterSetName='fields')]
        [string]$Description,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField1,
        
        [Parameter(ParameterSetName='fields')]
        [string]$GenericField2,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField3,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField4,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField5,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField6,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField7,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField8,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField9,

        [Parameter(ParameterSetName='fields')]
        [string]$GenericField10,

        [Parameter(ParameterSetName='fields')]
        [string]$Notes,

        [Parameter(ParameterSetName='fields')]
        [string]$Url,

        [Parameter(ParameterSetName='fields')]
        [string]$ExpiryDate,

        [Parameter(ParameterSetName='fields')]
        [bool]$AllowExport,

        #[Parameter(ParameterSetName='GenPassword')]
        [switch]$GeneratePassword,

        [switch]$GenerateGenFieldPassword
    )

    begin {
        $headers = @{}
        $headers['Accept'] = "application/$Format"
    }

    process {
        $request = "" | Select-Object -Property PasswordId, apikey
        $request.PasswordId = $PasswordId
        $request.apikey = $ApiKey.GetNetworkCredential().Password

        if ($PSBoundParameters.ContainsKey('Title')) {
            $request | Add-Member -MemberType NoteProperty -Name Title -Value $Title
        }
        if ($PSBoundParameters.ContainsKey('Password')) {
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
            $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
            $request | Add-Member -MemberType NoteProperty -Name Password -Value $UnsecurePassword
        }
        if ($PSBoundParameters.ContainsKey('Username')) {
            $request | Add-Member -MemberType NoteProperty -Name Username -Value $Username
        }
        if ($PSBoundParameters.ContainsKey('Description')) {
            $request | Add-Member -MemberType NoteProperty -Name Description -Value $Description
        }
        if ($PSBoundParameters.ContainsKey('GenericField1')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField1 -Value $GenericField1
        }
        if ($PSBoundParameters.ContainsKey('GenericField2')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField2 -Value $GenericField2
        }
        if ($PSBoundParameters.ContainsKey('GenericField3')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField3 -Value $GenericField3
        }
        if ($PSBoundParameters.ContainsKey('GenericField4')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField4 -Value $GenericField4
        }
        if ($PSBoundParameters.ContainsKey('GenericField5')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField5 -Value $GenericField5
        }
        if ($PSBoundParameters.ContainsKey('GenericField6')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField6 -Value $GenericField6
        }
        if ($PSBoundParameters.ContainsKey('GenericField7')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField7 -Value $GenericField7
        }
        if ($PSBoundParameters.ContainsKey('GenericField8')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField8 -Value $GenericField8
        }
        if ($PSBoundParameters.ContainsKey('GenericField9')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField9 -Value $GenericField9
        }
        if ($PSBoundParameters.ContainsKey('GenericField10')) {
            $request | Add-Member -MemberType NoteProperty -Name GenericField10 -Value $GenericField10
        }
        if ($PSBoundParameters.ContainsKey('Notes')) {
            $request | Add-Member -MemberType NoteProperty -Name Notes -Value $Notes
        }
        if ($PSBoundParameters.ContainsKey('Url')) {
            $request | Add-Member -MemberType NoteProperty -Name Url -Value $Url
        }
        if ($PSBoundParameters.ContainsKey('ExpiryDate')) {
            $request | Add-Member -MemberType NoteProperty -Name ExpiryDate -Value $ExpiryDate
        }
        if ($PSBoundParameters.ContainsKey('AllowExport')) {
            $request | Add-Member -MemberType NoteProperty -Name AllowExport -Value $AllowExport
        }
        if ($PSBoundParameters.ContainsKey('GeneratePassword')) {
            $request | Add-Member -MemberType NoteProperty -Name GeneratePassword -Value $true
        }
        if ($PSBoundParameters.ContainsKey('GenerateGenFieldPassword')) {
            $request | Add-Member -MemberType NoteProperty -Name GenerateGenFieldPassword -Value $true
        }

        $uri = "$Endpoint/passwords"

        $json = ConvertTo-Json -InputObject $request

        If ($PSCmdlet.ShouldProcess("Setting values for password id [$PasswordId] using params:`n$json")) {
            $result = Invoke-RestMethod -Uri $uri -Method Put -ContentType "application/$Format" -Headers $headers -Body $json
            return $result
        }
    }
}