Set-StrictMode -Version 3

# Load functions
$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path
"$moduleRoot\Functions\*.ps1", "$moduleRoot\Internal\*.ps1" |
Resolve-Path |
ForEach-Object { . $_.ProviderPath }

# Allow untrusted SSL
_SetCertPolicy

Export-ModuleMember -Cmdlet *PasswordState*