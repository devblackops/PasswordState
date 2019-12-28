#Remove-Module -Name 'PasswordState' -Force
#Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
InModuleScope 'PasswordState' {
    Describe "Function Export-PasswordStateApiKey" {
        BeforeAll {
            $ParameterTests = @(
                @{param='ApiKey';mandatory='True'}
                ,@{param='Repository';mandatory='False'}
            )
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Export-PasswordStateApiKey').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$(((Get-Command -Name 'Export-PasswordStateApiKey').Parameters[$param].Attributes | Select-Object -First 1).Mandatory)" | should -be $mandatory
            }
        }
    }
}