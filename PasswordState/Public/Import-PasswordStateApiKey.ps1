function Import-PasswordStateApiKey {
    <#
    .SYNOPSIS
        Imports a PasswordState API key.
    .DESCRIPTION
        Imports a given PasswordState API key from the repository.
    .PARAMETER Name
        Name of the key to retrieve.
        Do not include the file extension.
    .PARAMETER Repository
        Path to repository.
        Default is $env:HOME\.passwordstate
    .EXAMPLE
        PS C:\> $cred = Import-PasswordStateApiKey -Name personal

        Import the 'personal' API key from the default repository location.
    .EXAMPLE
        PS C:\> $cred = Import-PasswordStateApiKey -Name personal -Repository c:\users\joe\data\.customrepo

        Import the 'personal' API key from the 'c:\users\joe\data\.customrepo' repository.
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$Name,

        [string]$Repository = (_GetDefault -Option 'credential_repository')
    )

    begin {
        if (-not (Test-Path -Path $Repository -Verbose:$false)) {
            Write-Error -Message "PasswordState key repository does not exist!"
            break
        }
    }

    process {
        foreach ($item in $Name) {
            if ($Name -like "*.cred") {
                $keyPath = Join-Path -Path $Repository -ChildPath "$Name"
            } else {
                $keyPath = Join-Path -Path $Repository -ChildPath "$Name.cred"
            }

            if (-not (Test-Path -Path $keyPath)) {
                Write-Error -Message "Key file $keyPath not found!"
                break
            }

            $secPass = Get-Content -Path $keyPath | ConvertTo-SecureString
            $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Name, $secPass

            return $cred
        }
    }
}
