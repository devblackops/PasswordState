function New-PasswordStatePassword {    
    <#
        .SYNOPSIS
            Create a new password in PasswordState.
        .DESCRIPTION
            Create a new password in PasswordState.
        .PARAMETER ApiKey
            The API key for the password list in PasswordState.
        .PARAMETER Endpoint
            The Uri of your PasswordState site. (i.e. https://passwordstate.local)
        .PARAMETER Format
            The response format from PasswordState. Choose either json or xml.
        .PARAMETER Title
            The title field for the password entry.
        .PARAMETER Password
            The password field for the password entry.
        .PARAMETER Username
            The username field for the password entry.
        .PARAMETER Description
            The description field for the password entry.
        .PARAMETER GenericField1
            The generic field 1 for the password entry.
        .PARAMETER GenericField2
            The generic field 2 for the password entry.
        .PARAMETER GenericField3
            The generic field 3 for the password entry.
        .PARAMETER GenericField4
            The generic field 4 for the password entry.
        .PARAMETER GenericField5
            The generic field 5 for the password entry.
        .PARAMETER GenericField6
            The generic field 6 for the password entry.
        .PARAMETER GenericField7
            The generic field 7 for the password entry.
        .PARAMETER GenericField8
            The generic field 8 for the password entry.
        .PARAMETER GenericField9
            The generic field 9 for the password entry.
        .PARAMETER GenericField10
            The generic field 10 for the password entry.
        .PARAMETER Notes
            The notes field for the password entry.
        .PARAMETER Url
            The url field for the password entry.
        .PARAMETER ExpiryDate
            The expire field for the password entry.
        .PARAMETER AllowExport
            Allow the password to be exported
        .PARAMETER GeneratePassword
            If set to true, a newly generated random password will be created based on the Password Generator options associated with the Password List. If the Password List is set to use the user's Password Generator options, the Default Password Generator options will be used instead.
        .PARAMETER GenerateGenFieldPassword
            If set to true, any 'Generic Fields' which you have set to be of type 'Password' will have a newly generated random password assigned to it. If the Password List or Generic Field is set to use the user's Password Generator options, the Default Password Generator options will be used instead.
        .EXAMPLE
            
        
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true)]
        [int]$PasswordListId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

		[ValidateSet('json','xml')]
        [string]$Format = 'json',

        [Parameter(Mandatory = $true)]
        [string]$Title,

        [Parameter(ParameterSetName='UsePassword', Mandatory = $true)]
        [string]$Password,

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

        [string]$Url,

        [string]$ExpiryDate,

        [bool]$AllowExport,

        [Parameter(ParameterSetName='GenPassword')]
        [switch]$GeneratePassword,

        [switch]$GenerateGenFieldPassword
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    $request = "" | select Title, PasswordListID, apikey
    $request.Title = $Title    
    $request.PasswordListID = $PasswordListId
    $request.apikey = $($ApiKey.GetNetworkCredential().password)

    if ($Password -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name Password -Value $Password
    }
    if ($Userame -ne [string]::Empty) { 
        $request | Add-Member -MemberType NoteProperty -Name UserName -Value $Username
    }    
    if ($Description -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name Description -Value $Description
    }
    if ($GenericField1 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField1 -Value $GenericField1
    }
    if ($GenericField2 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField2 -Value $GenericField2
    }
    if ($GenericField3 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField3 -Value $GenericField3
    }
    if ($GenericField4 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField4 -Value $GenericField4
    }
    if ($GenericField5 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField5 -Value $GenericField5
    }
    if ($GenericField6 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField6 -Value $GenericField6
    }
    if ($GenericField7 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField7 -Value $GenericField7
    }
    if ($GenericField8 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField8 -Value $GenericField8
    }
    if ($GenericField9 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField9 -Value $GenericField9
    }
    if ($GenericField10 -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField10 -Value $GenericField10
    }
    if ($Notes -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name Notes -Value $Notes
    }
    if ($Url -ne [string]::Empty) {
        $request | Add-Member -MemberType NoteProperty -Name Url -Value $Url
    }
    if ($GeneratePassword -ne $null) {
        $request | Add-Member -MemberType NoteProperty -Name GeneratePassword -Value $true
    }
    if ($GenerateGenFieldPassword -ne $null) {
        $request | Add-Member -MemberType NoteProperty -Name GenerateGenFieldPassword -Value $true
    }

    $uri = "$Endpoint/passwords"

    $json = ConvertTo-Json -InputObject $request
    #write-verbose $json
    #write-verbose $uri

    $result = Invoke-RestMethod -Uri $uri -Method Post -ContentType "application/$Format" -Headers $headers -Body $json
    return $result
}