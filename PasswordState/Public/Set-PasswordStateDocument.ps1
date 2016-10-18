#requires -Version 3
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

function Set-PasswordStateDocument {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [int]$PasswordId,
        
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [int]$PasswordListId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [String]$DocumentPath,

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [String]$DocumentName,
            
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [String]$DocumentDescription
    )

    begin {
        $headers = @{}
        $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
    }

    process {          
        if ($PasswordId) {
            $uri = "$Endpoint/document/password/$($PasswordID)?DocumentName=$([System.Web.HttpUtility]::UrlEncode($DocumentName))&DocumentDescription=$([System.Web.HttpUtility]::UrlEncode($DocumentDescription))"
            $id = "PasswordID [$PasswordId]"
        } else {
            $uri = "$Endpoint/document/passwordlist/$($PasswordListID)?DocumentName=$([System.Web.HttpUtility]::UrlEncode($DocumentName))&DocumentDescription=$([System.Web.HttpUtility]::UrlEncode($DocumentDescription))"
            $id = "PasswordListID [$PasswordListId]"
        }
        
        Write-Verbose -Message $uri
        Write-Verbose -Message $id
              

        if ($PSCmdlet.ShouldProcess("Uploading document `nUpload Document.`nDocumentPath : $DocumentPath`nDocumentName : $DocumentName`nDocument Description : $DocumentDescription to $ID")) {
            $result = Invoke-RestMethod -Uri $uri -Method Post -InFile $DocumentPath -ContentType 'multipart/form-data' -Headers $headers 
            return $result
        }
    }
}
