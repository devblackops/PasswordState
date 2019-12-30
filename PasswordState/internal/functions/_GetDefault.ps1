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

function _GetDefault {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [string]$Option
    )

    $repo = (Join-Path -Path $env:USERPROFILE -ChildPath '.passwordstate')

    if (Test-Path -Path $repo -Verbose:$false) {

        $options = (Join-Path -Path $repo -ChildPath 'options.json')
        
        if (Test-Path -Path $options ) {
            $obj = Get-Content -Path $options | ConvertFrom-Json
            if ($options -ne [string]::empty) {
                return $obj.$Option
            } else {
                return $obj
            }
        } else {
            Write-Error -Message "Unable to find [$options]"
        }
    } else {
        Write-Error -Message "Undable to find PasswordState configuration folder at [$repo]"
    }
}