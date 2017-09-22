function New-StringTemplateToPSCustomObject {
    param(
        $String,
        $TemplateName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $Path = Get-StringTemplatePath -TemplateName $TemplateName -ModuleName $ModuleName -TemplateType $TemplateType        
    $String | Out-File $Path
}

function Edit-StringTemplateToPSCustomObject {
    param(
        $TemplateName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $Path = Get-StringTemplatePath -TemplateName $TemplateName -ModuleName $ModuleName -TemplateType $TemplateType    
    Invoke-Item $Path
}

function Invoke-StringTemplateToPSCustomObject {
    param(
        $String,
        $TemplateName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $Path = Get-StringTemplatePath -TemplateName $TemplateName -ModuleName $ModuleName -TemplateType $TemplateType

    if ($TemplateType -eq "FlashExtract") {
        $String | ConvertFrom-String -TemplateFile $Path
    } elseif ($TemplateType -eq "Regex") {
        $String | ConvertFrom-StringUsingRegexCaptureGroup -TemplateFile $Path
    }
}

function Get-StringTemplatePath {
    param(
        $TemplateName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $ModulePath = (Get-Module -ListAvailable $ModuleName).ModuleBase
    "$ModulePath\Templates\$TemplateName.$($TemplateType).Template"
}
