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

function Export-PasswordStateApiKey {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline = $true)]
        [pscredential[]]$ApiKey,

        [Parameter()]
        [string]$Repository = (_GetDefault -Option 'credential_repository')
    )

    Begin {
        if (-not (Test-Path -Path $Repository -Verbose:$false)) {
            Write-PSFMessage -Message "Creating PasswordState key repository: $Repository"
            New-Item -ItemType Directory -Path $Repository -Verbose:$false | Out-Null
        }
    }

    Process {
        foreach ($item in $ApiKey) {
            $exportPath = Join-Path -path $Repository -ChildPath "$($item.Username).cred" -Verbose:$false
            Write-PSFMessage -Message "Exporting key [$($item.Username)] to $exportPath"
            $item.Password | ConvertFrom-SecureString -Verbose:$false | Out-File $exportPath -Verbose:$false
        }
    }
}