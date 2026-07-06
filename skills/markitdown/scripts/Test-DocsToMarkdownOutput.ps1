[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path,

    [string]$OutputDir,
    [switch]$Recurse,
    [switch]$Json,

    [string[]]$Extensions = @(".pdf", ".docx", ".doc", ".pptx", ".ppt", ".xlsx", ".xls", ".csv", ".html", ".htm", ".txt")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-FrontMatterValue {
    param(
        [string[]]$Lines,
        [string]$Key
    )

    $line = $Lines | Where-Object { $_ -match "^$([regex]::Escape($Key)):\s*" } | Select-Object -First 1
    if (-not $line) {
        return "(missing)"
    }

    return (($line -replace "^$([regex]::Escape($Key)):\s*", "").Trim('"')).Trim()
}

function Get-ExpectedOutputPath {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$BaseDir,
        [string]$OutputRoot,
        [string[]]$SupportedExtensions
    )

    $relative = [System.IO.Path]::GetRelativePath($BaseDir, $SourceFile.FullName)
    $relativeDir = Split-Path -Path $relative -Parent
    $targetDir = if ([string]::IsNullOrWhiteSpace($relativeDir)) {
        $OutputRoot
    }
    else {
        Join-Path $OutputRoot $relativeDir
    }

    $sameBaseFiles = @(Get-ChildItem -LiteralPath $SourceFile.DirectoryName -File |
        Where-Object {
            $SupportedExtensions -contains $_.Extension.ToLowerInvariant() -and
            $_.BaseName -eq $SourceFile.BaseName
        })

    $name = if ($sameBaseFiles.Count -gt 1) {
        $SourceFile.BaseName + "." + $SourceFile.Extension.TrimStart(".") + ".md"
    }
    else {
        $SourceFile.BaseName + ".md"
    }

    return Join-Path $targetDir $name
}

$inputItem = Get-Item -LiteralPath $Path
if ($inputItem.PSIsContainer) {
    $baseDir = $inputItem.FullName
    if ([string]::IsNullOrWhiteSpace($OutputDir)) {
        $OutputDir = Join-Path $inputItem.FullName "_markdown"
    }

    $getArgs = @{ LiteralPath = $inputItem.FullName; File = $true }
    if ($Recurse) {
        $getArgs.Recurse = $true
    }

    $sources = @(Get-ChildItem @getArgs |
        Where-Object {
            $Extensions -contains $_.Extension.ToLowerInvariant() -and
            -not ($_.FullName -match '\\_markdown(\\|$)')
        } |
        Sort-Object FullName)
}
else {
    $baseDir = $inputItem.DirectoryName
    if ([string]::IsNullOrWhiteSpace($OutputDir)) {
        $OutputDir = Join-Path $inputItem.DirectoryName "_markdown"
    }
    $sources = @($inputItem)
}

$outputRoot = $OutputDir
$missing = foreach ($source in $sources) {
    $expected = Get-ExpectedOutputPath -SourceFile $source -BaseDir $baseDir -OutputRoot $outputRoot -SupportedExtensions $Extensions
    if (-not (Test-Path -LiteralPath $expected)) {
        [pscustomobject]@{
            Source = [System.IO.Path]::GetRelativePath($baseDir, $source.FullName)
            ExpectedOutput = $expected
        }
    }
}

$markdownFiles = if (Test-Path -LiteralPath $outputRoot) {
    @(Get-ChildItem -LiteralPath $outputRoot -File -Recurse -Filter "*.md" -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -ne "conversion-log.md" })
}
else {
    @()
}

$frontmatter = foreach ($file in $markdownFiles) {
    $head = Get-Content -LiteralPath $file.FullName -TotalCount 80 -ErrorAction SilentlyContinue
    [pscustomobject]@{
        File = [System.IO.Path]::GetRelativePath($outputRoot, $file.FullName)
        Status = Get-FrontMatterValue -Lines $head -Key "conversion_status"
        Method = Get-FrontMatterValue -Lines $head -Key "conversion_method"
    }
}

$summary = [pscustomobject]@{
    SourceConvertibleCount = @($sources).Count
    MarkdownFileCount = @($markdownFiles).Count
    MissingExpectedOutputs = @($missing).Count
    OutputPath = $outputRoot
}

$statusCounts = @($frontmatter | Group-Object Status | Sort-Object Name | ForEach-Object {
    [pscustomobject]@{ Status = $_.Name; Count = $_.Count }
})

$methodCounts = @($frontmatter | Group-Object Method | Sort-Object Name | ForEach-Object {
    [pscustomobject]@{ Method = $_.Name; Count = $_.Count }
})

$nonCompleted = @($frontmatter | Where-Object { $_.Status -ne "completed" } | Select-Object File, Status, Method)

$result = [pscustomobject]@{
    Summary = $summary
    StatusCounts = $statusCounts
    MethodCounts = $methodCounts
    NonCompleted = $nonCompleted
    Missing = @($missing)
}

if ($Json) {
    $result | ConvertTo-Json -Depth 6
    return
}

"Summary:"
$summary | Format-List
"Status counts:"
$statusCounts | Format-Table -AutoSize
"Method counts:"
$methodCounts | Format-Table -AutoSize
"Non-completed outputs:"
$nonCompleted | Format-Table -AutoSize
if (@($missing).Count -gt 0) {
    "Missing expected outputs:"
    $missing | Format-Table -AutoSize
}
