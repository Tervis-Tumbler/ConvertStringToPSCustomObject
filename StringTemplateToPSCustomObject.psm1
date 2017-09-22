function New-StringToPSCustomObjectTemplate {
    param(
        $String,
        $FunctionName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $ModulePath = (Get-Module -ListAvailable $ModuleName).ModuleBase
    $String | Out-File "$ModulePath\Templates\$FunctionName.$($TemplateType).Template"
}

function Edit-StringToPSCustomObjectTemplate {
    param(
        $FunctionName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $ModulePath = (Get-Module -ListAvailable $ModuleName).ModuleBase
    Invoke-Item "$ModulePath\Templates\$FunctionName.$($TemplateType).Template"
}

