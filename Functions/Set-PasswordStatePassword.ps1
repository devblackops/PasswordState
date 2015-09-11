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
    <#
        .SYNOPSIS
            Updates an existing password in PasswordState.
        .DESCRIPTION
            Updates an existing password in PasswordState.
        .PARAMETER ApiKey
            The API key for the password list in PasswordState.
        .PARAMETER PasswordId
            The Id of the password in PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .PARAMETER Title
            The title field for the password entry.
        .PARAMETER Password
            The password field for the password entry.
        .PARAMETER Username
            The username field for the password entry.
        .PARAMETER Description
            The description field for the password entry.
        .PARAMETER GenericField1
            The generic field 1 for the password entry.
        .PARAMETER GenericField2
            The generic field 2 for the password entry.
        .PARAMETER GenericField3
            The generic field 3 for the password entry.
        .PARAMETER GenericField4
            The generic field 4 for the password entry.
        .PARAMETER GenericField5
            The generic field 5 for the password entry.
        .PARAMETER GenericField6
            The generic field 6 for the password entry.
        .PARAMETER GenericField7
            The generic field 7 for the password entry.
        .PARAMETER GenericField8
            The generic field 8 for the password entry.
        .PARAMETER GenericField9
            The generic field 9 for the password entry.
        .PARAMETER GenericField10
            The generic field 10 for the password entry.
        .PARAMETER Notes
            The notes field for the password entry.
        .PARAMETER Url
            The url field for the password entry.
        .PARAMETER ExpiryDate
            The expire field for the password entry.
        .PARAMETER AllowExport
            Allow the password to be expored
        .PARAMETER GeneratePassword
            If set to true, a newly generated random password will be created based on the Password Generator options associated with the Password List. If the Password List is set to use the user's Password Generator options, the Default Password Generator options will be used instead.
        .PARAMETER GenerateGenFieldPassword
            If set to true, any 'Generic Fields' which you have set to be of type 'Password' will have a newly generated random password assigned to it. If the Password List or Generic Field is set to use the user's Password Generator options, the Default Password Generator options will be used instead.
        .EXAMPLE
            Set-PasswordStatePassword -ApiKey $key -PasswordId 1234 -GeneratePassword

            Change the password for entry 1234 to a new randomly generated one.
        .EXAMPLE
            Set-PasswordStatePassword -ApiKey $key -PasswordId 1234 -Username 'mypassword'

            Change the username for entry 1234 to mypassword

    #>
    [cmdletbinding()]
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
        [string]$Password,

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
        $request = "" | select PasswordId, apikey  
        $request.PasswordId = $PasswordId
        $request.apikey = $ApiKey.GetNetworkCredential().Password

        if ($PSBoundParameters.ContainsKey('Title')) {
            $request | Add-Member -MemberType NoteProperty -Name Title -Value $Title
        }
        if ($PSBoundParameters.ContainsKey('Password')) {
            $request | Add-Member -MemberType NoteProperty -Name Password -Value $Password
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

        $result = Invoke-RestMethod -Uri $uri -Method Put -ContentType "application/$Format" -Headers $headers -Body $json
        return $result
    }
}