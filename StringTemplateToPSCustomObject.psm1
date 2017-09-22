function New-StringTemplateFile {
    param(
        $String,
        [Parameter(Mandatory, ParameterSetName = "PathByConvention")]$TemplateName,
        [Parameter(Mandatory, ParameterSetName = "PathByConvention")]$ModuleName,
        [Parameter(Mandatory, ParameterSetName = "Path")]$Path,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    if (-not $Path) {
        $Path = Get-StringTemplatePath -TemplateName $TemplateName -ModuleName $ModuleName -TemplateType $TemplateType
    }
    $String | Out-File $Path
}

function Edit-StringTemplateFile {
    param(
        [Parameter(Mandatory, ParameterSetName = "PathByConvention")]$TemplateName,
        [Parameter(Mandatory, ParameterSetName = "PathByConvention")]$ModuleName,
        [Parameter(Mandatory, ParameterSetName = "Path")]$Path,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    if (-not $Path) {
        $Path = Get-StringTemplatePath -TemplateName $TemplateName -ModuleName $ModuleName -TemplateType $TemplateType
    }
    Invoke-Item $Path
}

function Invoke-StringTemplateToPSCustomObject {
    param(
        [Parameter(Mandatory)]$String,
        [Parameter(Mandatory, ParameterSetName = "PathByConvention")]$TemplateName,
        [Parameter(Mandatory, ParameterSetName = "PathByConvention")]$ModuleName,
        [Parameter(Mandatory, ParameterSetName = "Path")]$Path,
        [ValidateSet("FlashExtract","Regex")]$TemplateType = "FlashExtract"
    )
    if (-not $Path) {
        $Path = Get-StringTemplatePath -TemplateName $TemplateName -ModuleName $ModuleName -TemplateType $TemplateType
    }

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
