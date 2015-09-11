# PasswordState

Passwordstate is a PowerShell module used to interface with 
ClickStudio's PasswordState application via the REST API.

This module supports creating, retrieving, and updating 
PasswordState entries using simple PowerShell cmdlets that 
you can integrate into your existing processes.

# Examples

- Initialize-PasswordStateRepository

	```powershell
	Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -ConfigurationRepository 'C:\PasswordStateCreds'
	```
- Get-PasswordStateApiKey

	```powershell
	Get-PasswordStateApiKey -Name 'system' -Repository c:\users\joe\data\.customrepo
	```
- Import-PasswordStateApiKey

	```powershell
	$cred = Import-PasswordStateApiKey -Name personal -Repository c:\users\joe\data\.customrepo
	```
- Export-PasswordStateApiKey

	```powershell
	Export-PasswordStateApiKey -ApiKey $cred -Repository c:\users\joe\data\.customrepo
	```
- Find-PasswordStatePassword

	```powershell
	$allPasswords = Get-PasswordStateAllPasswords -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
	```
- Get-PasswordStateAllLists

	```powershell
	$lists = Get-PasswordStateList -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
	```
- Get-PasswordStateAllPasswords

	```powershell
	$allPasswords = Get-PasswordStateAllPasswords -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
	```
- Get-PasswordStateList

	```powershell
	$lists = Get-PasswordStateList -SystemApiKey $sysKey -Endpoint 'https://passwordstate.local'
	```
- Get-PasswordStateListPasswords

	```powershell
	$passwords = Get-PasswordStateListPasswords -ApiKey $key -PasswordListId 1234 -Endpoint 'https://passwordstate.local'
	```
- Get-PasswordStatePasswordHistory

	```powershell
	$history = Get-PasswordStatePasswordHistory -ApiKey $key -PasswordId 1234 -Endpoint 'https://passwordstate.local'
	```
- New-PasswordStatePassword
	```powershell
	New-PasswordStatePassword -ApiKey $key -PasswordListId 1 -Title 'testPassword' -Username 'testPassword' -Description 'this is a test' -GeneratePassword
	```

- New-PasswordStateRandomPassword
	```powershell
	New-PasswordStateRandomPassword -Quantity 10 -WordPhrases $false -MinLength 20
	```
- Set-PasswordStatePassword
	```powershell
	Set-PasswordStatePassword -ApiKey $key -PasswordId 1234 -Username 'mypassword'
	```
	
For more information, see [http://devblackops.io/powershell-module-for-clickstudios-passwordstate/v](http://devblackops.io/powershell-module-for-clickstudios-passwordstate/)