<#
Copyright 2015 Brandon Olin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

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

# Allow untrusted SSL
_SetCertPolicy

Export-ModuleMember -Function *PasswordState*