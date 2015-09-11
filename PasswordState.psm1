# Not playing slop
Set-StrictMode -Version 3

# Load public functions
$functions = Get-ChildItem -Recurse "$PSScriptRoot\Functions" -Include *.ps1
foreach ($function in $functions) {
    . $function.FullName
}

# Load internal functions
$internals = Get-ChildItem -Recurse "$PSScriptRoot\Internal" -Include *.ps1
foreach ($internal in $internals) {
    . $internal.FullName
}

$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path

"$moduleRoot\Functions\*.ps1", "$moduleRoot\Internal\*.ps1" |
    Resolve-Path |
    ForEach-Object { . $_.ProviderPath }

# Allow untrusted SSL
_SetCertPolicy

Export-ModuleMember -Function *PasswordState*