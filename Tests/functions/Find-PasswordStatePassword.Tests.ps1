#Remove-Module -Name 'PasswordState' -Force
#Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
InModuleScope 'PasswordState' {
    Describe "Function Find-PasswordStatePassword" {
        BeforeAll {
            $ParameterTests = @(
                @{param='ApiKey';mandatory='True'}
                ,@{param='SystemApiKey';mandatory='True'}
                ,@{param='Endpoint';mandatory='False'}
                ,@{param='PasswordListId';mandatory='True'}
                ,@{param='SearchString';mandatory='True'}
                ,@{param='Title';mandatory='False'}
                ,@{param='UserName';mandatory='False'}
                ,@{param='Description';mandatory='False'}
                ,@{param='GenericField1';mandatory='False'}
                ,@{param='GenericField2';mandatory='False'}
                ,@{param='GenericField3';mandatory='False'}
                ,@{param='GenericField4';mandatory='False'}
                ,@{param='GenericField5';mandatory='False'}
                ,@{param='GenericField6';mandatory='False'}
                ,@{param='GenericField7';mandatory='False'}
                ,@{param='GenericField8';mandatory='False'}
                ,@{param='GenericField9';mandatory='False'}
                ,@{param='GenericField10';mandatory='False'}
                ,@{param='Notes';mandatory='False'}
                ,@{param='Url';mandatory='False'}
                ,@{param='ExpireBefore';mandatory='False'}
                ,@{param='ExpireAfter';mandatory='False'}
                ,@{param='Format';mandatory='False'}
                ,@{param='UseV6Api';mandatory='False'}
            )
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Find-PasswordStatePassword').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'Find-PasswordStatePassword').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
        }
    }
}