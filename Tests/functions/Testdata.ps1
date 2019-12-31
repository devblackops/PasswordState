$JSONPath="$PSScriptRoot\json"
$XMLPath="$PSScriptRoot\xml"
$Global:TestJson=@{
    'PasswordStateListResponse'= (Get-Content "$($JSONPath)\PasswordStateListResponse.json")
}

$Global:TestXML=@{
    'PasswordStateListResponse'=(Get-Content "$($XMLPath)\PasswordStateListResponse.xml")
}

$FailedJson=0
foreach ($Jsonkey in $global:TestJson.Keys) {
    try {
        ConvertFrom-Json $global:TestJson[$Jsonkey] | Out-Null
    } catch [System.ArgumentException] {
        Write-PSFMessage -Level Important -Message "The Json <c='em'>$Jsonkey</c> does not contain a correct json: '$($global:TestJson[$Jsonkey])'" -Target $Jsonkey
        $FailedJson+=1
    }
}

if ($FailedJson -gt 0) {
    throw "At least 1 test json could not be parsed successfully. Review your json files!"
}

$FailedXML=0
foreach ($XMLkey in $Global:TestXML.Keys) {
    try {
        [xml]($Global:TestXML[$XMLkey]) | Out-Null
    } catch [System.Management.Automation.PSInvalidCastException] {
        Write-PSFMessage -Level Important -Message "The XML <c='em'>$XMLkey</c> does not contain a correct xml: '$($Global:TestXML[$XMLkey])'" -Target $XMLkey
        $FailedXML+=1
    }
}

if ($FailedXML -gt 0) {
    throw "At least 1 test xml could not be parsed successfully. Review your xml files!"
}