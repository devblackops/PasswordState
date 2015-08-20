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

        [string]$Name
    )

    if (-not (Test-Path -Path $Repository -Verbose:$false)) {
        Write-Error 'PasswordState key repository does not exist!'
        break
    }

    if ([string]::IsNullOrEmpty($Name)) {
        $items = Get-ChildItem -Path $Repository -Filter '*.cred'
    } else {
        $items = Get-ChildItem -Path $Repository -Filter "*$Name*.cred"
    }

    return $items
}