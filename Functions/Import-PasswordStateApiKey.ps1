function Import-PasswordStateApiKey {
    <#
        .SYNOPSIS
            Imports a PasswordState API key.
        .DESCRIPTION
            Imports a given PasswordState API key from the repository.
        .PARAMETER Name
            Name of the key to retrieve. Do not include the file extension.
        .PARAMETER Repository
            Path to repository. Default is $env:USERPROFILE\.passwordstate
        .EXAMPLE
            $cred = Import-PasswordStateApiKey -Name personal
        .EXAMPLE
            $cred = Import-PasswordStateApiKey -Name personal -Repository c:\users\joe\data\.customrepo
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName)]
        [string[]]$Name,

        [string]$Repository = (_GetDefault -Option 'credential_repository')
    )

    begin {
        if (-not (Test-Path -Path $Repository -Verbose:$false)) {
            write-error "PasswordState key repository does not exist!"
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
                write-error "Key file $keyPath not found!"
                break
            }

            $secPass = Get-Content -Path $keyPath | convertto-securestring
            $cred = New-Object System.Management.Automation.PSCredential($Name, $secPass)

            return $cred
        }
    }        
}