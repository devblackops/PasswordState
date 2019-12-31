if (!(get-module Passwordstate)) {
    Remove-Module -Name 'PasswordState' -Force
    Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
}
if (!($global:TestJson) -or (!($global:TestXML))) {
    . .\Testdata.ps1
}
InModuleScope 'PasswordState' {
    Describe "Function Get-PasswordStateAllPassword" {
        BeforeAll {
            $ParameterTests = @(
                @{param='SystemApiKey';mandatory='True'}
                ,@{param='Endpoint';mandatory='False'}
                ,@{param='PreventAuditing';mandatory='False'}
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

            #Mock for invoke-restmethod
            Mock -CommandName 'Invoke-RestMethod' -MockWith {
                $global:TestJson['PasswordStateAllPasswordResponse'] | ConvertFrom-Json
            } -ParameterFilter { $uri -and $uri -match '/passwords/' -and $ContentType -match 'json'}

            #Mock for invoke-restmethod
            Mock -CommandName 'Invoke-RestMethod' -MockWith {
                [xml]($global:Testxml['PasswordStateAllPasswordResponse'])
            } -ParameterFilter { $uri -and $uri -match '/passwords/' -and $ContentType -match 'xml'}
        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'Get-PasswordStateAllPassword').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'Get-PasswordStateAllPassword').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
            It "Should ensure that the format value <value> is accepted" -TestCases $AllParameterFormatTests {
                param($value,$works)
                $value -in ((get-command 'Get-PasswordStateAllPassword').Parameters['Format'].Attributes | Where-Object { $_.gettype().fullname -eq 'System.Management.Automation.ValidateSetAttribute' }).ValidValues | should be $works
            }
        }
        Context 'Unit Testing function' {
            It "Should return an object with an property 'totalpasswords' for <value> Format" -TestCases $ValidParameterFormatTests {
                param($value, $works)
                (Get-PasswordStateAllPassword -SystemApiKey $APIKey['GoodKey'] -format $value).totalpasswords | should -not -be $null
            }
        }
    }
}