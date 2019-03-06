function Export-PasswordStateApiKey {
    <#
    .SYNOPSIS
        Exports a PowerShell credential object to the PasswordState key repository.
    .DESCRIPTION
        Exports a PowerShell credential object to the PasswordState key repository.
     .PARAMETER ApiKey
        PowerShell credential object to export.
     .PARAMETER Repository
        Path to repository.
        Default is $env:HOME\.passwordstate
    .EXAMPLE
        PS> Export-PasswordStateApiKey -ApiKey $cred

        Export an API key to the default PasswordState repository
    .EXAMPLE
        PS> Export-PasswordStateApiKey -ApiKey $cred -Repository c:\users\joe\data\.customrepo

        Export an API key to the 'c:\users\joe\data\.customrepo' PasswordState repository
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [pscredential[]]$ApiKey,

        [string]$Repository = (_GetDefault -Option 'credential_repository')
    )

    begin {
        if (-not (Test-Path -Path $Repository -Verbose:$false)) {
            Write-Verbose -Message "Creating PasswordState key repository: $Repository"
            New-Item -ItemType Directory -Path $Repository -Verbose:$false | Out-Null
        }
    }

    process {
        foreach ($item in $ApiKey) {
            $exportPath = Join-Path -path $Repository -ChildPath "$($item.Username).cred" -Verbose:$false
            Write-Verbose -Message "Exporting key [$($item.Username)] to $exportPath"
            $item.Password | ConvertFrom-SecureString -Verbose:$false | Out-File $exportPath -Verbose:$false
        }
    }
}
