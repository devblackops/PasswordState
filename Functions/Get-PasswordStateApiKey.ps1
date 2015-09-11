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

function Get-PasswordStateApiKey {
    <#
        .SYNOPSIS
            List available PasswordState API keys in the repository.
        .DESCRIPTION
            List available PasswordState API keys in the repository.
        .PARAMETER Repository
            Path to repository. Default is $env:USERPROFILE\.passwordstate
        .EXAMPLE
            Get-PasswordStateApiKey
        .EXAMPLE
            Get-PasswordStateApiKey | Format-Table
        .EXAMPLE
            Get-PasswordStateApiKey -Repository c:\users\joe\data\.customrepo
    #>
    [cmdletbinding()]
    param(
        [string]$Repository = (_GetDefault -Option 'credential_repository'),

        [string]$Name = [string]::empty
    )

    if (-not (Test-Path -Path $Repository -Verbose:$false)) {
        Write-Error -Message 'PasswordState key repository does not exist!'
        break
    }

    if ([string]::IsNullOrEmpty($Name)) {
        $items = Get-ChildItem -Path $Repository -Filter '*.cred'
    } else {
        $items = Get-ChildItem -Path $Repository -Filter "*$Name*.cred"
    }

    return $items
}