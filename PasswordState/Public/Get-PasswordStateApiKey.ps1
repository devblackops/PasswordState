function Get-PasswordStateApiKey {
    <#
    .SYNOPSIS
        List available PasswordState API keys in the repository.
    .DESCRIPTION
        List available PasswordState API keys in the repository.
    .PARAMETER Repository
        Path to repository.
        Default is $env:HOME\.passwordstate
    .PARAMETER Name
        Name of API key (without .cred extension) to get.
    .EXAMPLE
        PS C:\> Get-PasswordStateApiKey

        List all API keys from default repository.
    .EXAMPLE
        PS C:\> Get-PasswordStateApiKey -Repository c:\users\joe\data\.customrepo

        List all API keys from 'c:\users\joe\data\.customrepo' repository.
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
