if (!(get-module Passwordstate)) {
    Remove-Module -Name 'PasswordState' -Force
    Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
}
if (!($global:TestJson) -or (!($global:TestXML))) {
    . .\Testdata.ps1
}
InModuleScope 'PasswordState' {
    Describe 'Function Initialize-PasswordStateRepository' {
        BeforeAll {
            $Tests = @(
                @{param='ApiEndpoint';mandatory='True'}
                ,@{param='RepositoryKey';mandatory='False'}
            )
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $Tests {
                param($param)
                ((Get-Command -Name 'Initialize-PasswordStateRepository').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $Tests {
                param($param,$mandatory)
                "$(((Get-Command -Name 'Initialize-PasswordStateRepository').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}).Mandatory)" | should -be $mandatory
            }
        }
    }
}