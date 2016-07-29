#requires -Version 3
<#
    Copyright 2015 Brandon Olin

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
#>

function New-PasswordStatePassword 
{    
  [cmdletbinding(SupportsShouldProcess = $true)]
  param(
    [parameter(Mandatory)]
    [pscredential]$ApiKey,

    [parameter(Mandatory)]
    [int]$PasswordListId,

    [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

    [ValidateSet('json','xml')]
    [string]$Format = 'json',

    [Parameter(Mandatory)]
    [string]$Title,

    [Parameter(Mandatory = $true,ParameterSetName = 'UsePassword')]
    [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
    [securestring]$Password,

    [string]$Username,

    [string]$Description,

    [string]$GenericField1,
        
    [string]$GenericField2,

    [string]$GenericField3,

    [string]$GenericField4,

    [string]$GenericField5,

    [string]$GenericField6,

    [string]$GenericField7,

    [string]$GenericField8,

    [string]$GenericField9,

    [string]$GenericField10,

    [string]$Notes,

    [int]$AccountTypeID,

    [string]$Url,

    [string]$ExpiryDate,

    [bool]$AllowExport,

    [Parameter(Mandatory = $true,ParameterSetName = 'GenPassword')]
    [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
    [switch]$GeneratePassword,

    [switch]$GenerateGenFieldPassword,

    [switch]$UseV6Api,

    [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
    [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
    [String]$DocumentPath,

    [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
    [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
    [String]$DocumentName,
        
    [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
    [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
    [String]$DocumentDescription

  )

  $headers = @{}
  $headers['Accept'] = "application/$Format"

  $request = '' | Select-Object -Property Title, PasswordListID, apikey
  $request.Title = $Title
  $request.PasswordListID = $PasswordListId
  $request.apikey = $($ApiKey.GetNetworkCredential().password)

  if ($null -ne $Password) {
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
    $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    $request | Add-Member -MemberType NoteProperty -Name Password -Value $UnsecurePassword
  }

  if ($PSBoundParameters.ContainsKey('Username')) {
    $request | Add-Member -MemberType NoteProperty -Name UserName -Value $Username
  }

  if ($PSBoundParameters.ContainsKey('Description')) {
    $request | Add-Member -MemberType NoteProperty -Name Description -Value $Description
  }
  if ($PSBoundParameters.ContainsKey('GenericField1')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField1 -Value $GenericField1
  }
  if ($PSBoundParameters.ContainsKey('GenericField2')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField2 -Value $GenericField2
  }
  if ($PSBoundParameters.ContainsKey('GenericField3')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField3 -Value $GenericField3
  }
  if ($PSBoundParameters.ContainsKey('GenericField4')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField4 -Value $GenericField4
  }
  if ($PSBoundParameters.ContainsKey('GenericField5')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField5 -Value $GenericField5
  }
  if ($PSBoundParameters.ContainsKey('GenericField6')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField6 -Value $GenericField6
  }
  if ($PSBoundParameters.ContainsKey('GenericField7')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField7 -Value $GenericField7
  }
  if ($PSBoundParameters.ContainsKey('GenericField8')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField8 -Value $GenericField8
  }
  if ($PSBoundParameters.ContainsKey('GenericField9')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField9 -Value $GenericField9
  }
  if ($PSBoundParameters.ContainsKey('GenericField10')) {
    $request | Add-Member -MemberType NoteProperty -Name GenericField10 -Value $GenericField10
  }
  if ($PSBoundParameters.ContainsKey('Notes')) {
    $request | Add-Member -MemberType NoteProperty -Name Notes -Value $Notes
  }
  if ($PSBoundParameters.ContainsKey('AccountTypeID')) {
    $request | Add-Member -MemberType NoteProperty -Name AccountTypeID -Value $AccountTypeID
  }
  if ($PSBoundParameters.ContainsKey('Url')) {
    $request | Add-Member -MemberType NoteProperty -Name Url -Value $Url
  }
  if ($GeneratePassword.IsPresent) {
    $request | Add-Member -MemberType NoteProperty -Name GeneratePassword -Value $true
  }
  if ($GenerateGenFieldPassword.IsPresent) {
    $request | Add-Member -MemberType NoteProperty -Name GenerateGenFieldPassword -Value $true
  }

  $uri = "$Endpoint/passwords"

  if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
    $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
  }
  else {
    $uri += "?apikey=$($ApiKey.GetNetworkCredential().password)"
  }

  $json = ConvertTo-Json -InputObject $request

  Write-Verbose -Message $json

  $Output = @()

  If ($DocumentPath) {
    $DocumentInfo = "Upload Document.`nDocumentPath : $DocumentPath`nDocumentName : $DocumentName`nDocument Description : $DocumentDescription"
  }

  If ($PSCmdlet.ShouldProcess("Creating new password entry: $Title `n$json`n$DocumentInfo")) {
    $result = Invoke-RestMethod -Uri $uri -Method Post -ContentType "application/$Format" -Headers $headers -Body $json
    $Output += $result
    
    If ($DocumentPath) {
      $uri = "$Endpoint/document/password/$($result.PasswordID)?DocumentName=$([System.Web.HttpUtility]::UrlEncode($DocumentName))&DocumentDescription=$([System.Web.HttpUtility]::UrlEncode($DocumentDescription))"
      Write-Verbose  -Message $uri 

      $result = Invoke-RestMethod -Uri $uri -Method Post -InFile $DocumentPath -ContentType 'multipart/form-data' -Headers $headers 
      $Output += $result
      
      return $Output
    }
  }
}
