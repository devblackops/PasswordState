[![Build status](https://ci.appveyor.com/api/projects/status/1019ek26bd5x2op2?svg=true)](https://ci.appveyor.com/project/devblackops/passwordstate)

# PasswordState

Passwordstate is a PowerShell module used to interface with 
ClickStudio's [PasswordState](http://www.clickstudios.com.au/) application via the REST API.

This module supports creating, retrieving, and updating 
PasswordState entries using simple PowerShell cmdlets that 
you can integrate into your existing processes.

# Getting Started
You start off by running `Initialize-PasswordStateRepository`, which will initialize some base variables used in the PasswordState PowerShell module. It takes 2 parameters: -APIEndpoint is the URL to where your current PasswordState installation resides, and the -CredentialRepository is where you can store "Credentials" or API keys in this case.
If you do not specify -CredentialRepository it will be created under your `%UserProfile%` folder.

Then you want to store some "credentials" on disk (Not really credentials, but API keys, PowerShell credential objects are used as a method of storing credentials in a secure way)

First you create a credential object using PowerShells `Get-Credential` cmdlet. You will be prompted to input a username/password, in username put in the name you want to call the credential file (Usually something that refers to, what the actual API key is giving you access to, a password list for instance), and in the password field enter your APIkey. If you do not specify a location, the credentials will be stored in the location you specified when you ran `Initialize-PasswordStateRepository`


   ```powershell   
   $Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -CredentialRepository 'C:\PasswordStateCreds'
   $Cred = Get-Credential
   Export-PasswordStateApiKey -ApiKey $cred
   ```  

Lets say you entered "ADUserList" as Username and "52e7c9d84hb7fa33f6b123dac823e956" as password, this will result in a file called  ADUserList.cred under the directory C:\PasswordStateCreds

If you at a later time want to use that credential you just call: `Import-PasswordStateApiKey`


```powershell
$ADUserListCred = Import-PasswordStateApiKey -Name 'ADUserList'
```
Now you can use that credential object (API key) to connect to PasswordState
In the below example, the API key is read from the $ADUserListCred variable, and URL to PasswordState is read from the URL you typed in when you ran `Initialize-PasswordStateRepository`
```powershell
Get-PasswordStateListPasswords -ApiKey $ADUserListCred -PasswordListId 42
```


# Examples

 - Initialize-PasswordStateRepository

	```powershell
	Initialize-PasswordStateRepository -ApiEndpoint 'https://passwordstate.local/api' -CredentialRepository 'C:\PasswordStateCreds'
	```
 - Export-PasswordStateApiKey 
 
  	```powershell
    $Cred = Get-Credential
    Export-PasswordStateApiKey -ApiKey $cred -Repository c:\users\joe\data\.customrepo
	```
- Get-PasswordStateApiKey

	```powershell
	Get-PasswordStateApiKey -Name 'system' -Repository c:\users\joe\data\.customrepo
	```
- Import-PasswordStateApiKey

	```powershell
	$cred = Import-PasswordStateApiKey -Name personal -Repository c:\users\joe\data\.customrepo
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
- New-PasswordStatePassword

	```powershell
	New-PasswordStatePassword -ApiKey $key -PasswordListId 1 -Title "TestDocument" -Username "testDoc" -GeneratePassword -DocumentPath "C:\temp\SecureDoc.txt" -DocumentName SecureDoc.txt -DocumentDescription 'My Very Secure Document'
	```

- New-PasswordStateRandomPassword
	```powershell
	New-PasswordStateRandomPassword -Quantity 10 -WordPhrases $false -MinLength 20
	```

- Set-PasswordStatePassword
	```powershell
	Set-PasswordStatePassword -ApiKey $key -PasswordId 1234 -Username 'mypassword'
	```
- Set-PasswordStateDocument (On PasswordList)
 
	```powershell
	 Set-PasswordStateDocument -ApiKey $key -PasswordListId 1 -DocumentPath "C:\temp\Secure.txt" -DocumentName SecureDoc.txt -DocumentDescription 'My Very Secure Document'
	```
- Set-PasswordStateDocument (On Password)
 
	```powershell
	 Set-PasswordStateDocument -ApiKey $key -PasswordId 4242 -DocumentPath "C:\temp\Secure.txt" -DocumentName SecureDoc.txt -DocumentDescription 'My Very Secure Document'
	```

	
	
For more information, see [http://devblackops.io](http://devblackops.io/powershell-module-for-clickstudios-passwordstate/)