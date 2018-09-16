<#
Copyright 2018 Juan C. Herrera

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

function Get-PasswordStatePasswordWinAPI {
    [cmdletbinding()]
    param(

        [parameter(mandatory = $true)]
        [int]$PasswordID,

        [parameter(mandatory = $true)]
        [string]$Endpoint,

        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $Credential,

        [switch]$DisplayPassword
    )

        try {
            $PasswordstateUrl = "https://$Endpoint/winapi/passwords/$PasswordID"

            if ($Credential -eq $null) {

                $c = Invoke-Restmethod -Method GET -Uri $PasswordstateUrl -UseDefaultCredentials

            } else {

                $c = Invoke-Restmethod -Method GET -Uri $PasswordstateUrl -Credential $Credential
            }

            if ($DisplayPassword.IsPresent) {
                $Creds = $c.Password
            } else {
                $Creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $c.UserName,($c.Password | ConvertTo-SecureString -AsPlainText -Force)
            }

            return [PSCustomObject][ordered] @{
                'PasswordID' = $c.PasswordID
                'Title' = $c.Title
                'Domain' = $c.Domain
                'Hostname' = $c.HostName
                'UserName' = $c.UserName
                'Description' = $c.Description
                'GenericField1' = $c.GenericField1
                'GenericField2' = $c.GenericField2
                'GenericField3' = $c.GenericField3
                'GenericField4' = $c.GenericField4
                'GenericField5' = $c.GenericField5
                'GenericField6' = $c.GenericField6
                'GenericField7' = $c.GenericField7
                'GenericField8' = $c.GenericField8
                'GenericField9' = $c.GenericField9
                'GenericField10' = $c.GenericField10
                'AccountTypeID' = $c.AccountTypeID
                'Notes' = $c.Notes
                'URL' = $c.URL
                'ExpiryDate' = $c.ExpiryDate
                'AllowExport' = $c.AllowExport
                'AccountType' = $c.AccountType
                'Credentials' = $Creds
            }
        } catch {
            Write-Output "The command failed, please type the correct PasswordID OR ensure that you have access to the PasswordList"
        }
}