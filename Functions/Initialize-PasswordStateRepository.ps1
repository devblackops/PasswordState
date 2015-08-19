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
        .EXAMPLE
            Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -ConfigurationRepository 'C:\PasswordStateCreds'
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [string]$ApiEndpoint,

        [string]$CredentialRepository = (Join-Path -path $env:USERPROFILE -ChildPath '.passwordstate' -Verbose:$false)
    )

    # If necessary, create our repository under $env:USERNAME\.passwordstate
    $repo = (Join-Path -path $env:USERPROFILE -ChildPath '.passwordstate')
    if (-not (Test-Path -Path $repo -Verbose:$false)) {
        Write-Debug "Creating PasswordState configuration repository: $repo"
        New-Item -ItemType Directory -Path $repo -Verbose:$false | out-null
    } else {
        Write-Debug "PasswordState configuration repository appears to already be created at [$repo]"
    }

    $options = @{
        api_endpoint = $ApiEndpoint
        credential_repository = $CredentialRepository
    }

    $json = $options | ConvertTo-Json -Verbose:$false
    Write-Debug -message $json
    $json | Out-File -FilePath (Join-Path -Path $repo -ChildPath 'options.json') -Force -Confirm:$false -Verbose:$false    
}