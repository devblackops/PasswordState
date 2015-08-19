function Export-PasswordStateApiKey {
    <#
        .SYNOPSIS
            Exports a PowerShell credential object to the PasswordState key repository.
        .DESCRIPTION
            Exports a PowerShell credential object to the PasswordState key repository.
        .PARAMETER ApiKey
            PowerShell credential object to export.
        .PARAMETER Repository
            Path to repository. Default is $env:USERPROFILE\.passwordstate
        .EXAMPLE
            Export-PasswordStateApiKey -ApiKey $cred
        .EXAMPLE
            Export-PasswordStateApiKey -ApiKey $cred -Repository c:\users\joe\data\.customrepo
        .EXAMPLE
            $cred | Export-PasswordStateApiKey -Repository c:\users\joe\data\.customrepo
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [pscredential[]]$ApiKey,

        [string]$Repository = (_GetDefault -Option 'credential_repository')
    )

    begin {
        if (-not (Test-Path -Path $Repository -Verbose:$false)) {
            Write-Verbose "Creating PasswordState key repository: $Repository"
            New-Item -ItemType Directory -Path $Repository -Verbose:$false | Out-Null
        }
    }

    process {
        foreach ($item in $ApiKey) {
            $exportPath = Join-Path -path $Repository -ChildPath "$($item.Username).cred" -Verbose:$false
            Write-Verbose "Exporting key [$($item.Username)] to $exportPath"
            $item.Password | convertfrom-securestring -Verbose:$false | Out-File $exportPath -Verbose:$false
        }
    }
}