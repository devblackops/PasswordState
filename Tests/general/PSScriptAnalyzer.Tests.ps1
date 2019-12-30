[CmdletBinding()]
Param (
	[switch]
	$SkipTest,
	
	[string[]]
	$CommandPath = @("$PSScriptRoot\..\..\PasswordState\functions", "$PSScriptRoot\..\..\PasswordState\internal\functions"),

	[string]
	$ExceptionsFile = "$PSScriptRoot\PSScriptAnalyzer.Exceptions.ps1"
)

if ($SkipTest) { return }
. $ExceptionsFile
$list = New-Object System.Collections.ArrayList

Describe 'Invoking PSScriptAnalyzer against commandbase' {
	$commandFiles = Get-ChildItem -Path $CommandPath -Recurse -Filter "*.ps1"
	$scriptAnalyzerRules = Get-ScriptAnalyzerRule
	
	foreach ($file in $commandFiles)
	{
		Context "Analyzing $($file.BaseName)" {
			$ExcludeRules= @()
			$ExcludeRules+='PSAvoidTrailingWhitespace'
			$ExcludeRules+='PSShouldProcess'
			if ($file.name -in $global:PSRulesException.keys) { $global:PSRulesException[$file.name] | ForEach-Object { $ExcludeRules += $_} }
			$analysis = Invoke-ScriptAnalyzer -Path $file.FullName -ExcludeRule $ExcludeRules
			
			forEach ($rule in $scriptAnalyzerRules)
			{
				It "Should pass $rule" {
					If ($analysis.RuleName -contains $rule)
					{
						$analysis | Where-Object RuleName -EQ $rule -outvariable failures | ForEach-Object { $list.Add($_) }
						
						1 | Should Be 0
					}
					else
					{
						0 | Should Be 0
					}
				}
			}
		}
	}
}

$list | Out-Default