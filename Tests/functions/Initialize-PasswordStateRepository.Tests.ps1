#Remove-Module -Name 'PasswordState' -Force
#Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
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
            It "Should ensure that the mandatory property for Parameter <param> is <mandatory>" -TestCases $Tests {
                param($param,$mandatory)
                "$(((Get-Command -Name 'Initialize-PasswordStateRepository').Parameters[$param].Attributes | Select-Object -First 1).Mandatory)" | should -be $mandatory
            }
        }
    }
}