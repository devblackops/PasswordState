if (!(get-module Passwordstate)) {
    Remove-Module -Name 'PasswordState' -Force
    Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
}
if (!($global:TestJson) -or (!($global:TestXML))) {
    . .\Testdata.ps1
}
InModuleScope 'PasswordState' {
    Describe "Function Get-PasswordStatePasswordHistory" {
        BeforeAll {
            $ParameterTests = @(
                @{param='ApiKey';mandatory='True'}
                ,@{param='PasswordId';mandatory='True'}
                ,@{param='Endpoint';mandatory='False'}
                ,@{param='Format';mandatory='False'}
                ,@{param='UseV6Api';mandatory='False'}
            )
            $ValidParameterFormatTests=@(
                @{value='json';works=$True}
                @{value='xml';works=$True}
            )
            $AllParameterFormatTests =$ValidParameterFormatTests+@{value='incorrecttype';works=$False}
            $APIKey=@{
                'GoodKey'=([pscredential]::new('A very good key indeed',(ConvertTo-SecureString -AsPlainText -Force -String 'Please continue, Jarvis')))
                'BadKey'=([pscredential]::new('bad key, very bad key',(ConvertTo-SecureString -AsPlainText -Force -String 'Going to sleep now')))
            }
            Mock -CommandName '_GetDefault' -MockWith {
                'https://IDoNotExists.com'
            } -ParameterFilter { $Option -and $Option -eq 'api_endpoint'}

            Mock -CommandName 'Invoke-RestMethod' -MockWith {
                $global:TestJson['PasswordStatePasswordHistoryResponse'] | ConvertFrom-Json
            } -ParameterFilter { $uri -and $uri -match '/passwordhistory/' -and $ContentType -match 'json'}
            Mock -CommandName 'Invoke-RestMethod' -MockWith {
                [xml]($global:Testxml['PasswordStatePasswordHistoryResponse'])
            } -ParameterFilter { $uri -and $uri -match '/passwordhistory/' -and $ContentType -match 'xml'}
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Get-PasswordStatePasswordHistory').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'Get-PasswordStatePasswordHistory').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
            It "Should ensure that the format value <value> is accepted" -TestCases $AllParameterFormatTests {
                param($value,$works)
                $value -in ((get-command 'Get-PasswordStatePasswordHistory').Parameters['Format'].Attributes | Where-Object { $_.gettype().fullname -eq 'System.Management.Automation.ValidateSetAttribute' }).ValidValues | should be $works
            }
        }
        Context 'Unit Tests' {
            It "Should return an object with an property 'totalpasswords' for <value> Format" -TestCases $ValidParameterFormatTests {
                param($value, $works)
                (Get-PasswordStatePasswordHistory -ApiKey $APIKey['GoodKey'] -PasswordId 1 -format $value).totalpasswords | should -not -be $null
            }
        }
    }
}