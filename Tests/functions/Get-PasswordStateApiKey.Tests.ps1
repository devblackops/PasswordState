if (!(get-module Passwordstate)) {
    Remove-Module -Name 'PasswordState' -Force
    Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
}
if (!($global:TestJson) -or (!($global:TestXML))) {
    . .\Testdata.ps1
}
InModuleScope 'PasswordState' {
    Describe "Function Get-PasswordStateApiKey" {
        Context 'Analyzing Parameters' {
            BeforeAll {
                $ParameterTests = @(
                    @{param='Repository';mandatory='False'}
                    ,@{param='Name';mandatory='False'}
                )
            }
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Get-PasswordStateApiKey').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'Get-PasswordStateApiKey').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
        }
        Context 'Unit Tests with nonexisting repository path' {
            BeforeAll {
                Mock -CommandName '_GetDefault' -MockWith {
                    "Testdrive:\NonexistentFolder"
                } -ParameterFilter { $Option -and $Option -eq 'credential_repository'}
            }
            It 'Should throw' {
                { Get-PasswordStateApiKey -ErrorAction Stop -ErrorVariable error } | should throw
            }
            it 'Should call _GetDefault exactly 1 time' {
                Assert-MockCalled -CommandName '_GetDefault' -Exactly 1
            }
        }
        Context 'Unit Tests with existing repository Path' {
            BeforeAll {
                New-Item -Path TestDrive: -Name 'ExistentFolder' -ItemType 'Directory'
                New-Item -Path 'TestDrive:\ExistentFolder' -Name 'file.cred'
                New-Item -Path 'TestDrive:\ExistentFolder' -Name 'filename.cred'
                Mock -CommandName '_GetDefault' -MockWith {
                    "Testdrive:\ExistentFolder"
                } -ParameterFilter { $Option -and $Option -eq 'credential_repository'}
            }
            It 'Should not throw' {
                { Get-PasswordStateApiKey -ErrorAction Stop } | Should not throw
            }
            It 'Should return 1 object that is a File' {
                (Get-PasswordStateApiKey -Name 'filename'| Measure-Object).Count | should be 1
            }
            It 'Should return a FileInfo Object' {
                (Get-PasswordStateApiKey -Name 'filename').gettype().fullname | should be 'System.IO.FileInfo'
            }
            It 'Should return 2 objects' {
                (Get-PasswordStateApiKey | Measure-Object).Count | should be 2
            }
            It 'Should return only FileInfo Objects' {
                Foreach ($Type in (Get-PasswordStateApiKey | ForEach-Object { $_.gettype().fullname})) {
                    $Type | should be 'System.IO.FileInfo'
                } 
            }
            it 'Should call _GetDefault exactly 5 times' {
                Assert-MockCalled -CommandName '_GetDefault' -Exactly 5
            }
        }
    }
}