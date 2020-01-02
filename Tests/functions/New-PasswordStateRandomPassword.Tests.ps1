#Remove-Module -Name 'PasswordState' -Force
#Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
InModuleScope 'PasswordState' {
    Describe "Function New-PasswordStateRandomPassword" {
        BeforeAll {
            $ParameterTests = @(
                @{param='ApiKey';mandatory='True'}
                ,@{param='UseV6Api';mandatory='False'}
                ,@{param='Endpoint';mandatory='False'}
                ,@{param='Quantity';mandatory='False'}
                ,@{param='AlphaSpecial';mandatory='False'}
                ,@{param='WordPhrases';mandatory='False'}
                ,@{param='MinLength';mandatory='False'}
                ,@{param='MaxLength';mandatory='False'}
                ,@{param='LowerCase';mandatory='False'}
                ,@{param='UpperCase';mandatory='False'}
                ,@{param='Numeric';mandatory='False'}
                ,@{param='HigherAlphaRatio';mandatory='False'}
                ,@{param='AmbiguousChars';mandatory='False'}
                ,@{param='SpecialChars';mandatory='False'}
                ,@{param='SpecialCharList';mandatory='False'}
                ,@{param='BracketChars';mandatory='False'}
                ,@{param='BracketCharsList';mandatory='False'}
                ,@{param='NumberOfWords';mandatory='False'}
                ,@{param='MaxWordLength';mandatory='False'}
                ,@{param='PrefexAppend';mandatory='False'}
                ,@{param='SeperateWords';mandatory='False'}
                ,@{param='GeneratorId';mandatory='True'}
            )
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'New-PasswordStateRandomPassword').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'New-PasswordStateRandomPassword').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
        }
    }
}