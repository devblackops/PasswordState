function Set-PasswordStateDocument {
    <#
    .SYNOPSIS
        Attach a document to an existing Password or PasswordList.
    .DESCRIPTION
        Attach a document to an existing Password or PasswordList.
    .PARAMETER ApiKey
        The API key for the password list in PasswordState.
    .PARAMETER PasswordId
        The ID of the password that you want to attach a document to.
    .PARAMETER PasswordListId
        The ID of the password list that you want to attach a document to.
    .PARAMETER Endpoint
        The Uri of your PasswordState site.
    .PARAMETER DocumentPath
        This is the path to the file, that is to be uploaded to PasswordState.
    .PARAMETER DocumentName
        The name of the file to be displayed in PasswordState, this is also the name used, when the file is downloaded from PasswordState.
    .PARAMETER DocumentDescription
        The description of the document shown in PasswordState.
    .EXAMPLE
        PS C:\> Set-PasswordStateDocument -ApiKey $key -PasswordListId 1 -DocumentPath "C:\temp\Secure.txt" -DocumentName SecureDoc.txt -DocumentDescription 'My Very Secure Document'

        Adds the document c:\temp\Secure.txt to the Password list with ID 1.
    #>
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(Mandatory = $true)]
        [pscredential]$ApiKey,

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [int]$PasswordId,

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [int]$PasswordListId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [String]$DocumentPath,

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [String]$DocumentName,

        [parameter(Mandatory = $true,ParameterSetName = 'PasswordListID')]
        [parameter(Mandatory = $true,ParameterSetName = 'PasswordID')]
        [String]$DocumentDescription
    )

    begin {
        $headers = @{}
        $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
    }

    process {
        if ($PasswordId) {
            $uri = "$Endpoint/document/password/$($PasswordID)?DocumentName=$([System.Web.HttpUtility]::UrlEncode($DocumentName))&DocumentDescription=$([System.Web.HttpUtility]::UrlEncode($DocumentDescription))"
            $id = "PasswordID [$PasswordId]"
        } else {
            $uri = "$Endpoint/document/passwordlist/$($PasswordListID)?DocumentName=$([System.Web.HttpUtility]::UrlEncode($DocumentName))&DocumentDescription=$([System.Web.HttpUtility]::UrlEncode($DocumentDescription))"
            $id = "PasswordListID [$PasswordListId]"
        }

        Write-Verbose -Message $uri
        Write-Verbose -Message $id


        if ($PSCmdlet.ShouldProcess("Uploading document `nUpload Document.`nDocumentPath : $DocumentPath`nDocumentName : $DocumentName`nDocument Description : $DocumentDescription to $ID")) {
            $result = Invoke-RestMethod -Uri $uri -Method Post -InFile $DocumentPath -ContentType 'multipart/form-data' -Headers $headers
            return $result
        }
    }
}
