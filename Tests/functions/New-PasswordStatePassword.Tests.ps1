if (!(get-module Passwordstate)) {
    Remove-Module -Name 'PasswordState' -Force
    Import-Module "$PSScriptRoot\..\..\PasswordState\PasswordState.psd1"
}
if (!($global:TestJson) -or (!($global:TestXML))) {
    . .\Testdata.ps1
}
InModuleScope 'PasswordState' {
    Describe "Function New-PasswordStatePassword" {
        BeforeAll {
            $ParameterTests = @(
                @{param='ApiKey';mandatory='True'}
                ,@{param='PasswordListId';mandatory='True'}
                ,@{param='EndPoint';mandatory='False'}
                ,@{param='Format';mandatory='False'}
                ,@{param='Title';mandatory='True'}
                ,@{param='Password';mandatory='True'}
                ,@{param='Username';mandatory='False'}
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
                ,@{param='AccountTypeID';mandatory='False'}
                ,@{param='Url';mandatory='False'}
                ,@{param='ExpiryDate';mandatory='False'}
                ,@{param='AllowExport';mandatory='False'}
                ,@{param='GeneratePassword';mandatory='True'}
                ,@{param='UseV6Api';mandatory='False'}
                ,@{param='DocumentPath';mandatory='True'}
                ,@{param='DocumentName';mandatory='True'}
                ,@{param='DocumentDescription';mandatory='True'}
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
            } -ParameterFilter { $uri -and $uri -match '/passwordhistory/' -and $ContentType -match 'xml'}        }
        Context 'Analyzing Parameters' {
            It 'Should ensure parameter <param> is declared'-TestCases $ParameterTests {
                param($param)
                ((Get-Command -Name 'New-PasswordStatePassword').Parameters[$param]) | should -Not -Be $null
            }
            It "Should ensure that the mandatory property for Parameter <param> is set to <mandatory>" -TestCases $ParameterTests {
                param($param,$mandatory)
                "$((((Get-Command -Name 'New-PasswordStatePassword').Parameters[$param].Attributes | ? { $_.GetType().fullname -match 'ParameterAttribute'}) | select-object -first 1).Mandatory)" | should -be $mandatory
            }
            It "Should ensure that the format value <value> is accepted" -TestCases $AllParameterFormatTests {
                param($value,$works)
                $value -in ((get-command 'New-PasswordStatePassword').Parameters['Format'].Attributes | Where-Object { $_.gettype().fullname -eq 'System.Management.Automation.ValidateSetAttribute' }).ValidValues | should be $works
            }
        }
    }
}