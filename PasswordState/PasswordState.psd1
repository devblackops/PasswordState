#
# Module manifest for module 'PasswordState'
#
# Generated by: Brandon Olin
#
# Generated on: 5/14/2015
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PasswordState.psm1'

# Version number of this module.
ModuleVersion = '1.3.0'

# ID used to uniquely identify this module
GUID = '659695ad-f4eb-4ca4-8359-ae3cf74fe875'

# Author of this module
Author = 'Brandon Olin'

# Copyright statement for this module
Copyright = '(c) 2015 Brandon Olin. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell module for interacting with PasswordState API.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @(
    'Export-PasswordStateApiKey',
    'Find-PasswordStatePassword',
    'Get-PasswordStateAllList',
    'Get-PasswordStateAllPassword',
    'Get-PasswordStateApiKey',
    'Get-PasswordStateList',
    'Get-PasswordStateListPassword',
    'Get-PasswordStatePassword',
    'Get-PasswordStatePasswordHistory',
    'Import-PasswordStateApiKey',
    'Initialize-PasswordStateRepository',
    'New-PasswordStatePassword',
    'New-PasswordStateRandomPassword',
    'Set-PasswordStatePassword',
    'Set-PasswordStateDocument'
)

# Cmdlets to export from this module
#CmdletsToExport = '*'

# Variables to export from this module
#VariablesToExport = '*'

# Aliases to export from this module
#AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'PasswordState', 'Credential', 'Secret'

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/devblackops/PasswordState/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/devblackops/PasswordState'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://raw.githubusercontent.com/devblackops/PasswordState/master/CHANGELOG.md'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}