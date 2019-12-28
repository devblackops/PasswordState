#Remove-Module -Name 'PasswordState' -Force
#Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
InModuleScope 'PasswordState' {
    Describe "Function Set-PasswordStateDocument" {
        BeforeAll {
            $ParameterTests = @(
                @{param='ApiKey';mandatory='True'}
                ,@{param='PasswordId';mandatory='True'}
                ,@{param='PasswordListId';mandatory='True'}
                ,@{param='Endpoint';mandatory='False'}
                ,@{param='DocumentPath';mandatory='True'}
                ,@{param='DocumentName';mandatory='True'}
                ,@{param='DocumentDescription';mandatory='True'}
            )
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Set-PasswordStateDocument').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'Set-PasswordStateDocument').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
        }
    }
}