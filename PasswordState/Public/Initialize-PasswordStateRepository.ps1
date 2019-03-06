function Initialize-PasswordStateRepository {
    <#
    .SYNOPSIS
        Creates PasswordState configuration repository under $env:HOME\.passwordstate.
    .DESCRIPTION
        Creates PasswordState configuration repository under $env:HOME\.passwordstate and options.json file to store default values used by other PasswordState cmdlets.
    .PARAMETER Name
        Name of the key to retrieve.
        Do not include the file extension.
    .PARAMETER ApiEndpoint
        The Uri of your PasswordState site.
        (i.e. https://passwordstate.local/api)
    .PARAMETER CredentialRepository
        Path to credential repository.
        Default is $env:HOME\.passwordstate
    .EXAMPLE
        PS C:\> Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api'

        Initialize the PasswordState repository with default value of 'https://passwordstate.local/api' for endpoint.
    .EXAMPLE
        PS C:\> Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -ConfigurationRepository 'C:\PasswordStateCreds'

        Initialize the PasswordState repository with default value of 'https://passwordstate.local/api' for endpoint and 'C:\PasswordStateCreds'
        for the repository location.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [string]$ApiEndpoint,

        [string]$CredentialRepository = (Join-Path -path $env:HOME -ChildPath '.passwordstate' -Verbose:$false)
    )

    # If necessary, create our repository under $env:HOME\.passwordstate
    $repo = (Join-Path -Path $env:HOME -ChildPath '.passwordstate')
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
