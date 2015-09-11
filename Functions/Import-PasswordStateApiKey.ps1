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

function Import-PasswordStateApiKey {
    <#
        .SYNOPSIS
            Imports a PasswordState API key.
        .DESCRIPTION
            Imports a given PasswordState API key from the repository.
        .PARAMETER Name
            Name of the key to retrieve. Do not include the file extension.
        .PARAMETER Repository
            Path to repository. Default is $env:USERPROFILE\.passwordstate
        .EXAMPLE
            $cred = Import-PasswordStateApiKey -Name personal
        .EXAMPLE
            $cred = Import-PasswordStateApiKey -Name personal -Repository c:\users\joe\data\.customrepo
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$Name,

        [string]$Repository = (_GetDefault -Option 'credential_repository')
    )

    begin {
        if (-not (Test-Path -Path $Repository -Verbose:$false)) {
            Write-Error -Message "PasswordState key repository does not exist!"
            break
        }
    }

    process {
        foreach ($item in $Name) {
            if ($Name -like "*.cred") {
                $keyPath = Join-Path -Path $Repository -ChildPath "$Name"
            } else {
                $keyPath = Join-Path -Path $Repository -ChildPath "$Name.cred"
            }
            
            if (-not (Test-Path -Path $keyPath)) {
                Write-Error -Message "Key file $keyPath not found!"
                break
            }

            $secPass = Get-Content -Path $keyPath | ConvertTo-SecureString
            $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Name, $secPass

            return $cred
        }
    }
}