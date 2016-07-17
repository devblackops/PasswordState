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

function Initialize-PasswordStateRepository {
    <#
        .SYNOPSIS
            Creates PasswordState configuration repository under $env:USERNAME\.passwordstate
        .DESCRIPTION
            Creates PasswordState configuration repository under $env:USERNAME\.passwordstate and options.json file to store default values used by other PasswordState cmdlets.
        .PARAMETER ApiEndpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local/api)
        .PARAMETER CredentialRepository
            Path to credential repository. Default is $env:USERPROFILE\.passwordstate
        .EXAMPLE
            Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api'

            Initialize the PasswordState repository with default value of 'https://passwordstate.local/api' for endpoint.
        .EXAMPLE
            Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -ConfigurationRepository 'C:\PasswordStateCreds'

            Initialize the PasswordState repository with default value of 'https://passwordstate.local/api' for endpoint and 'C:\PasswordStateCreds'
            for the repository location.
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [string]$ApiEndpoint,

        [string]$CredentialRepository = (Join-Path -path $env:USERPROFILE -ChildPath '.passwordstate' -Verbose:$false)
    )

    # If necessary, create our repository under $env:USERNAME\.passwordstate
    $repo = (Join-Path -Path $env:USERPROFILE -ChildPath '.passwordstate')
    if (-not (Test-Path -Path $repo -Verbose:$false)) {
        Write-Debug -Message "Creating PasswordState configuration repository: $repo"
        New-Item -ItemType Directory -Path $repo -Verbose:$false | Out-Null
    } else {
        Write-Debug -Message "PasswordState configuration repository appears to already be created at [$repo]"
    }

    $options = @{
        api_endpoint = $ApiEndpoint
        credential_repository = $CredentialRepository
    }

    $json = $options | ConvertTo-Json -Verbose:$false
    Write-Debug -Message $json
    $json | Out-File -FilePath (Join-Path -Path $repo -ChildPath 'options.json') -Force -Confirm:$false -Verbose:$false
}