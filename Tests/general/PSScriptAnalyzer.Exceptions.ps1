$global:PSRulesException= @{
    #'filename.ps1'=@('ScriptAnalyzer testname')
    'Find-PasswordStatePassword.ps1' = @('PSAvoidUsingUserNameAndPassWordParams')
    'New-PasswordStatePassword.ps1' = @('PSAvoidUsingUserNameAndPassWordParams')
    'Set-PasswordStatePassword.ps1' = @('PSAvoidUsingUserNameAndPassWordParams')
}