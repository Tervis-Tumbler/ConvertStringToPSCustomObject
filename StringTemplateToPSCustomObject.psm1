function New-StringToPSCustomObjectTemplate {
    param(
        $String,
        $FunctionName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $Path = Get-StringToPSCustomObjectTemplatePath -FunctionName $FunctionName -ModuleName $ModuleName -TemplateType $TemplateType        
    $String | Out-File $Path
}

function Edit-StringToPSCustomObjectTemplate {
    param(
        $FunctionName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $Path = Get-StringToPSCustomObjectTemplatePath -FunctionName $FunctionName -ModuleName $ModuleName -TemplateType $TemplateType    
    Invoke-Item $Path
}

function Invoke-StringToPSCustomObjectTemplate {
    param(
        $String,
        $FunctionName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $Path = Get-StringToPSCustomObjectTemplatePath -FunctionName $FunctionName -ModuleName $ModuleName -TemplateType $TemplateType

    if ($TemplateType -eq "FlashExtract") {
        $String | ConvertFrom-String -TemplateFile $Path
    } elseif ($TemplateType -eq "Regex") {
        $String | ConvertFrom-StringUsingRegexCaptureGroup -TemplateFile $Path
    }
}

function Get-StringToPSCustomObjectTemplatePath {
    param(
        $FunctionName,
        $ModuleName,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    $ModulePath = (Get-Module -ListAvailable $ModuleName).ModuleBase
    "$ModulePath\Templates\$FunctionName.$($TemplateType).Template"
}

}

