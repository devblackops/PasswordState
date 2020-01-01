if (!(get-module Passwordstate)) {
    Remove-Module -Name 'PasswordState' -Force
    Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
}
if (!($global:TestJson) -or (!($global:TestXML))) {
    . .\Testdata.ps1
}
InModuleScope 'PasswordState' {
    Describe "Function Import-PasswordStateApiKey" {
        BeforeAll {
            $ParameterTests = @(
                @{param='Name';mandatory='True'}
                ,@{param='Repository';mandatory='False'}
            )
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Import-PasswordStateApiKey').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'Import-PasswordStateApiKey').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
        }
        Context 'Unit Tests with nonexisting repository path' {
            BeforeAll {
                Mock -CommandName '_GetDefault' -MockWith {
                    "Testdrive:\NonexistentFolder"
                } -ParameterFilter { $Option -and $Option -eq 'credential_repository'}
            }
            It 'Should throw' {
                { Import-PasswordStateApiKey -Name 'filename' -ErrorAction Stop } | should throw
            }
            it 'Should call _GetDefault exactly 1 time' {
                Assert-MockCalled -CommandName '_GetDefault' -Exactly 1
            }
        }
        Context 'Unit Tests with existing repository Path' {
            BeforeAll {
                New-Item -Path TestDrive: -Name 'ExistentFolder' -ItemType 'Directory' | Out-Null
                (ConvertTo-SecureString -String 'password' -AsPlainText -Force) | ConvertFrom-SecureString | Out-File -FilePath 'TestDrive:\ExistentFolder\filename.cred'
                (ConvertTo-SecureString -String 'password' -AsPlainText -Force) | ConvertFrom-SecureString | Out-File -FilePath 'TestDrive:\ExistentFolder\file.cred'
                Mock -CommandName '_GetDefault' -MockWith {
                    "Testdrive:\ExistentFolder"
                } -ParameterFilter { $Option -and $Option -eq 'credential_repository'}
            }
            It 'Should not throw' {
                { Import-PasswordStateApiKey -name 'filename' -ErrorAction Stop } | Should not throw
            }
            It 'Should return 1 object that is a File' {
                (Import-PasswordStateApiKey -Name 'filename'| Measure-Object).Count | should be 1
            }
            It 'Should return a pscredential Object' {
                (Import-PasswordStateApiKey -Name 'filename').gettype().fullname | should be 'System.Management.Automation.PSCredential'
            }
            It 'Should return 2 objects' {
                (Import-PasswordStateApiKey -Name '*.cred'| Measure-Object).Count | should be 2
            }
            It 'Should return only pscredential Objects' {
                Foreach ($Type in (Import-PasswordStateApiKey -Name '*.Cred' | ForEach-Object { $_.gettype().fullname})) {
                    $Type | should be 'System.Management.Automation.PSCredential'
                }
            }
            it 'Should call _GetDefault exactly 5 times' {
                Assert-MockCalled -CommandName '_GetDefault' -Exactly 5
            }
        }
    }
}