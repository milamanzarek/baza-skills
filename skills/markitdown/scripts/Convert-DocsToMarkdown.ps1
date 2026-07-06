[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path,

    [string]$OutputDir,
    [switch]$Recurse,
    [switch]$Force,
    [switch]$ListOnly,
    [int]$MaxFiles = 0,

    [string[]]$Extensions = @(".pdf", ".docx", ".doc", ".pptx", ".ppt", ".xlsx", ".xls", ".csv", ".html", ".htm", ".txt"),

    [ValidateSet("Auto", "Always", "Never")]
    [string]$Ocr = "Auto",

    [string]$PythonLauncher = "py",
    [string]$PythonVersion = "-3.12",
    [string]$TesseractPath = "C:\Program Files\Tesseract-OCR\tesseract.exe",
    [string]$TessdataDir = "C:\Program Files\Tesseract-OCR\tessdata",
    [string]$OcrLanguage = "eng",
    [int]$MaxOcrPages = 50,
    [int]$MinMarkdownChars = 50,
    [switch]$KeepWork
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$PythonHelper = @'
import json
import sys
from pathlib import Path

mode = sys.argv[1]

if mode == "check":
    import fitz  # noqa: F401
    from PIL import Image, ImageOps  # noqa: F401
    print(json.dumps({"ok": True}))
    raise SystemExit(0)

if mode == "analyze":
    import fitz
    src = Path(sys.argv[2])
    doc = fitz.open(src)
    pages = []
    total_text_chars = 0
    for index, page in enumerate(doc, start=1):
        text = page.get_text("text") or ""
        total_text_chars += len(text)
        pages.append({
            "page": index,
            "text_chars": len(text),
            "image_count": len(page.get_images(full=True)),
            "width": page.rect.width,
            "height": page.rect.height,
        })
    print(json.dumps({
        "page_count": doc.page_count,
        "total_text_chars": total_text_chars,
        "pages": pages,
    }))
    raise SystemExit(0)

if mode == "render":
    import fitz
    src = Path(sys.argv[2])
    work = Path(sys.argv[3])
    work.mkdir(parents=True, exist_ok=True)
    doc = fitz.open(src)
    rendered = []
    for index, page in enumerate(doc, start=1):
        target_width = 2500.0
        scale = max(1.0, min(4.0, target_width / max(float(page.rect.width), 1.0)))
        pix = page.get_pixmap(matrix=fitz.Matrix(scale, scale), alpha=False)
        image_path = work / f"page-{index:03d}.png"
        pix.save(image_path)
        rendered.append({
            "page": index,
            "image": str(image_path),
            "scale": scale,
            "width": pix.width,
            "height": pix.height,
        })
    print(json.dumps(rendered))
    raise SystemExit(0)

if mode == "preprocess":
    from PIL import Image, ImageOps
    src = Path(sys.argv[2])
    out = Path(sys.argv[3])
    threshold = int(sys.argv[4])
    img = Image.open(src).convert("L")
    width, height = img.size
    margin = min(40, max(0, int(min(width, height) * 0.015)))
    if margin > 0 and width > margin * 2 and height > margin * 2:
        img = img.crop((margin, margin, width - margin, height - margin))
    img = ImageOps.autocontrast(img)
    bw = img.point(lambda p: 0 if p < threshold else 255, mode="1")
    out.parent.mkdir(parents=True, exist_ok=True)
    bw.save(out)
    print(json.dumps({"image": str(out), "threshold": threshold}))
    raise SystemExit(0)

if mode == "techsmith":
    import html as html_mod
    import re
    import xml.etree.ElementTree as ET

    src = Path(sys.argv[2])

    def read_text(path):
        return Path(path).read_text(encoding="utf-8", errors="ignore")

    def normalize_text(value):
        value = html_mod.unescape(value or "").strip()
        return re.sub(r"\s+", " ", value)

    def local_attr(element, name):
        for key, value in element.attrib.items():
            if key.split("}")[-1] == name:
                return value
        return None

    def format_time(ms_value):
        try:
            total_seconds = int(int(ms_value) / 1000)
        except Exception:
            total_seconds = 0
        minutes, seconds = divmod(total_seconds, 60)
        hours, minutes = divmod(minutes, 60)
        if hours:
            return f"{hours}:{minutes:02d}:{seconds:02d}"
        return f"{minutes}:{seconds:02d}"

    def find_config_from_html(path):
        text = read_text(path)
        direct = re.search(r"setXMPSrc\([\"']([^\"']+)[\"']\)", text)
        if direct:
            return path.parent / direct.group(1)

        iframe = re.search(r"<iframe[^>]+src=[\"']([^\"']+)[\"']", text, flags=re.IGNORECASE)
        if iframe:
            player = iframe.group(1).split("?", 1)[0]
            player_path = path.parent / player
            if player_path.exists():
                return find_config_from_html(player_path)
        return None

    candidates = []
    from_html = find_config_from_html(src)
    if from_html is not None:
        candidates.append(from_html)

    stem = src.stem
    if stem.endswith("_player"):
        stem = stem[:-7]
    candidates.append(src.parent / f"{stem}_config.xml")
    candidates.extend(src.parent.glob("*_config.xml"))

    config_path = None
    seen = set()
    for candidate in candidates:
        candidate = candidate.resolve()
        if candidate in seen:
            continue
        seen.add(candidate)
        if candidate.exists():
            config_path = candidate
            break

    if config_path is None:
        print(json.dumps({"ok": False, "error": "No companion TechSmith config XML found."}))
        raise SystemExit(2)

    root = ET.fromstring(read_text(config_path))
    title = ""
    items = []
    previous_text = None
    for element in root.iter():
        element_title = local_attr(element, "title")
        if element_title and not title:
            title = normalize_text(element_title)

        name = local_attr(element, "name")
        start_time = local_attr(element, "startTime")
        if name is None or start_time is None:
            continue
        text = normalize_text(name)
        if not text or text == previous_text:
            continue
        previous_text = text
        items.append({
            "time": format_time(start_time),
            "start_time_ms": start_time,
            "text": text,
        })

    if not items:
        print(json.dumps({"ok": False, "error": "No searchable text items found in companion XML.", "config_path": str(config_path)}))
        raise SystemExit(3)

    print(json.dumps({
        "ok": True,
        "config_path": str(config_path),
        "title": title or src.stem,
        "items": items,
    }, ensure_ascii=True))
    raise SystemExit(0)

raise SystemExit(f"unknown mode: {mode}")
'@

function Invoke-Native {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [string[]]$Arguments = @(),
        [string]$StandardInput,
        [hashtable]$Environment = @{}
    )

    $psi = [System.Diagnostics.ProcessStartInfo]::new()
    $psi.FileName = $FilePath
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true

    if ($null -ne $StandardInput) {
        $psi.RedirectStandardInput = $true
    }

    foreach ($argument in $Arguments) {
        [void]$psi.ArgumentList.Add($argument)
    }

    foreach ($key in $Environment.Keys) {
        $psi.Environment[$key] = [string]$Environment[$key]
    }

    try {
        $process = [System.Diagnostics.Process]::Start($psi)
    }
    catch {
        return [pscustomobject]@{
            ExitCode = 9999
            Stdout = ""
            Stderr = $_.Exception.Message
        }
    }

    if ($null -ne $StandardInput) {
        $process.StandardInput.Write($StandardInput)
        $process.StandardInput.Close()
    }

    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    $process.WaitForExit()

    return [pscustomobject]@{
        ExitCode = $process.ExitCode
        Stdout = $stdoutTask.GetAwaiter().GetResult()
        Stderr = $stderrTask.GetAwaiter().GetResult()
    }
}

function Get-PythonArgs {
    param([string[]]$Arguments)
    $allArgs = @()
    if ($PythonVersion -and $PythonVersion.Trim().Length -gt 0) {
        $allArgs += $PythonVersion
    }
    $allArgs += $Arguments
    return $allArgs
}

function Invoke-PythonHelper {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Mode,

        [string[]]$Arguments = @()
    )

    $pythonArgs = Get-PythonArgs -Arguments (@("-", $Mode) + $Arguments)
    return Invoke-Native -FilePath $PythonLauncher -Arguments $pythonArgs -StandardInput $PythonHelper
}

function Get-StringHash {
    param([string]$Text)
    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
        $hashBytes = $sha1.ComputeHash($bytes)
        return ([System.BitConverter]::ToString($hashBytes) -replace "-", "").Substring(0, 12).ToLowerInvariant()
    }
    finally {
        $sha1.Dispose()
    }
}

function ConvertTo-YamlString {
    param([string]$Value)
    $escaped = ($Value -replace "\\", "\\") -replace '"', '\"'
    return '"' + $escaped + '"'
}

function Escape-MarkdownCell {
    param([string]$Value)
    if ($null -eq $Value) {
        return ""
    }
    return (($Value -replace "\r?\n", " ") -replace "\|", "\|").Trim()
}

function Get-OcrScore {
    param([string]$Text)
    if ($null -eq $Text) {
        return -100000
    }
    $letters = [regex]::Matches($Text, "[A-Za-z0-9]").Count
    $noise = [regex]::Matches($Text, "[~=_{}<>]").Count
    return $letters - ($noise * 3)
}

function Test-TesseractLanguages {
    param([string]$LanguageSpec)

    $languages = @($LanguageSpec -split "\+" |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_.Length -gt 0 })

    if ($languages.Count -eq 0) {
        throw "No OCR languages were specified."
    }

    foreach ($language in $languages) {
        $trainedDataPath = Join-Path $TessdataDir ($language + ".traineddata")
        if (-not (Test-Path -LiteralPath $trainedDataPath)) {
            throw "Missing OCR language data: $trainedDataPath"
        }
    }
}

function New-FrontMatter {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$Method,
        [string]$Status,
        [int]$PageCount,
        [bool]$OcrUnverified,
        [string]$Notes
    )

    $lines = @(
        "---",
        "source_file: $(ConvertTo-YamlString $SourceFile.Name)",
        "conversion_status: $(ConvertTo-YamlString $Status)",
        "conversion_method: $(ConvertTo-YamlString $Method)",
        "converted_at: $(ConvertTo-YamlString ((Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")))",
        "ocr_language: $(ConvertTo-YamlString $OcrLanguage)",
        "ocr_unverified: $($OcrUnverified.ToString().ToLowerInvariant())",
        "page_count: $PageCount",
        "notes: $(ConvertTo-YamlString $Notes)",
        "---",
        ""
    )
    return ($lines -join "`n")
}

function Write-ConversionSummary {
    param([string]$LogCsv, [string]$SummaryPath)
    if (-not (Test-Path -LiteralPath $LogCsv)) {
        return
    }

    $rows = Import-Csv -LiteralPath $LogCsv
    $lines = @(
        "# Document to Markdown Conversion Log",
        "",
        "Generated by `99-System/Scripts/Convert-DocsToMarkdown.ps1`.",
        "",
        "| Timestamp | Status | Method | Source | Output | Notes |",
        "| --- | --- | --- | --- | --- | --- |"
    )

    foreach ($row in $rows) {
        $lines += "| $(Escape-MarkdownCell $row.timestamp) | $(Escape-MarkdownCell $row.status) | $(Escape-MarkdownCell $row.method) | $(Escape-MarkdownCell $row.source_file) | $(Escape-MarkdownCell $row.output_file) | $(Escape-MarkdownCell $row.notes) |"
    }

    Set-Content -LiteralPath $SummaryPath -Value ($lines -join "`n") -Encoding UTF8
}

function Add-LogRow {
    param(
        [string]$LogCsv,
        [string]$SummaryPath,
        [pscustomobject]$Row
    )
    $Row | Export-Csv -LiteralPath $LogCsv -NoTypeInformation -Append -Encoding UTF8
    Write-ConversionSummary -LogCsv $LogCsv -SummaryPath $SummaryPath
}

function Get-OutputPath {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$BaseDir,
        [string]$OutputRoot
    )

    $relative = [System.IO.Path]::GetRelativePath($BaseDir, $SourceFile.FullName)
    $relativeDir = Split-Path -Path $relative -Parent
    if ([string]::IsNullOrWhiteSpace($relativeDir)) {
        $fileOutputDir = $OutputRoot
    }
    else {
        $fileOutputDir = Join-Path $OutputRoot $relativeDir
    }

    New-Item -ItemType Directory -Path $fileOutputDir -Force | Out-Null

    $sameBaseFiles = @(Get-ChildItem -LiteralPath $SourceFile.DirectoryName -File |
        Where-Object {
            $Extensions -contains $_.Extension.ToLowerInvariant() -and
            $_.BaseName -eq $SourceFile.BaseName
        })

    if ($sameBaseFiles.Count -gt 1) {
        $extensionLabel = $SourceFile.Extension.TrimStart(".")
        return Join-Path $fileOutputDir ($SourceFile.BaseName + "." + $extensionLabel + ".md")
    }

    return Join-Path $fileOutputDir ($SourceFile.BaseName + ".md")
}

function Invoke-MarkItDown {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$WorkDir
    )

    $tempMarkdown = Join-Path $WorkDir "markitdown.md"
    $pythonArgs = Get-PythonArgs -Arguments @("-m", "markitdown", $SourceFile.FullName, "-o", $tempMarkdown)
    $result = Invoke-Native -FilePath $PythonLauncher -Arguments $pythonArgs
    $chars = 0
    if (Test-Path -LiteralPath $tempMarkdown) {
        $raw = Get-Content -LiteralPath $tempMarkdown -Raw -ErrorAction SilentlyContinue
        if ($null -ne $raw) {
            $chars = $raw.Length
        }
    }

    return [pscustomobject]@{
        ExitCode = $result.ExitCode
        Stdout = $result.Stdout
        Stderr = $result.Stderr
        TempMarkdown = $tempMarkdown
        Chars = $chars
    }
}

function Convert-PdfWithOcr {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$OutputPath,
        [string]$WorkDir,
        [string]$PriorNote
    )

    if (-not (Test-Path -LiteralPath $TesseractPath)) {
        throw "Tesseract not found at: $TesseractPath"
    }
    Test-TesseractLanguages -LanguageSpec $OcrLanguage

    $check = Invoke-PythonHelper -Mode "check"
    if ($check.ExitCode -ne 0) {
        throw "Python OCR dependencies are not available. $($check.Stderr)"
    }

    $analysisResult = Invoke-PythonHelper -Mode "analyze" -Arguments @($SourceFile.FullName)
    if ($analysisResult.ExitCode -ne 0) {
        throw "PDF analysis failed. $($analysisResult.Stderr)"
    }
    $analysis = $analysisResult.Stdout | ConvertFrom-Json

    if ($MaxOcrPages -gt 0 -and [int]$analysis.page_count -gt $MaxOcrPages) {
        $notes = "OCR fallback skipped because PDF has $([int]$analysis.page_count) pages, exceeding MaxOcrPages=$MaxOcrPages. Re-run with -Force -MaxOcrPages 0 to allow full OCR."
        if ($PriorNote) {
            $notes = "$PriorNote $notes"
        }
        $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method "ocr-skipped-page-limit" -Status "skipped" -PageCount ([int]$analysis.page_count) -OcrUnverified $true -Notes $notes
        $body = "# $($SourceFile.BaseName)`n`n[OCR skipped: source appears to need OCR but has $([int]$analysis.page_count) pages. Re-run with `-Force -MaxOcrPages 0` only if full local OCR is intended.]`n"
        Set-Content -LiteralPath $OutputPath -Value ($frontMatter + $body) -Encoding UTF8
        $raw = Get-Content -LiteralPath $OutputPath -Raw
        return [pscustomobject]@{
            Status = "Skipped - OCR page limit"
            Method = "ocr-skipped-page-limit"
            PageCount = [int]$analysis.page_count
            Chars = $raw.Length
            Notes = $notes
        }
    }

    $renderDir = Join-Path $WorkDir "rendered"
    $renderResult = Invoke-PythonHelper -Mode "render" -Arguments @($SourceFile.FullName, $renderDir)
    if ($renderResult.ExitCode -ne 0) {
        throw "PDF render failed. $($renderResult.Stderr)"
    }
    $renderedPages = $renderResult.Stdout | ConvertFrom-Json

    $pageBlocks = New-Object System.Collections.Generic.List[string]
    $thresholdsAndModes = @(
        @{ Threshold = 120; Psm = "3" },
        @{ Threshold = 140; Psm = "3" },
        @{ Threshold = 120; Psm = "4" },
        @{ Threshold = 120; Psm = "6" },
        @{ Threshold = 160; Psm = "3" }
    )

    foreach ($page in $renderedPages) {
        $bestText = ""
        $bestScore = -100000
        $bestLabel = ""
        $candidateIndex = 0

        foreach ($candidate in $thresholdsAndModes) {
            $candidateIndex += 1
            $preprocessedPath = Join-Path $WorkDir ("page-{0:000}-ocr-{1}.png" -f [int]$page.page, $candidateIndex)
            $preprocessResult = Invoke-PythonHelper -Mode "preprocess" -Arguments @([string]$page.image, $preprocessedPath, [string]$candidate.Threshold)
            if ($preprocessResult.ExitCode -ne 0) {
                continue
            }

            $ocrEnv = @{ TESSDATA_PREFIX = $TessdataDir }
            $ocrResult = Invoke-Native -FilePath $TesseractPath -Arguments @($preprocessedPath, "stdout", "-l", $OcrLanguage, "--psm", $candidate.Psm) -Environment $ocrEnv
            if ($ocrResult.ExitCode -ne 0) {
                continue
            }

            $text = ($ocrResult.Stdout -replace "`r", "").Trim()
            $score = Get-OcrScore -Text $text
            if ($score -gt $bestScore) {
                $bestScore = $score
                $bestText = $text
                $bestLabel = "threshold=$($candidate.Threshold), psm=$($candidate.Psm), score=$score"
            }

            if ($score -ge 120 -and $text.Length -ge 150) {
                break
            }
        }

        $pageBlocks.Add("<!-- page $([int]$page.page); OCR $bestLabel -->")
        if ($bestText.Length -gt 0) {
            $pageBlocks.Add($bestText)
        }
        else {
            $pageBlocks.Add("[OCR produced no text for this page.]")
        }
    }

    $notes = "Local OCR fallback. OCR text is unverified."
    if ($PriorNote) {
        $notes = "$PriorNote $notes"
    }
    if ([int]$analysis.total_text_chars -eq 0) {
        $notes = "$notes Source PDF has no embedded text layer."
    }

    $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method "local-tesseract-ocr" -Status "completed" -PageCount ([int]$analysis.page_count) -OcrUnverified $true -Notes $notes
    $body = "# $($SourceFile.BaseName)`n`n" + ($pageBlocks.ToArray() -join "`n`n") + "`n"
    Set-Content -LiteralPath $OutputPath -Value ($frontMatter + $body) -Encoding UTF8

    $raw = Get-Content -LiteralPath $OutputPath -Raw
    return [pscustomobject]@{
        Status = "Done - OCR"
        Method = "local-tesseract-ocr"
        PageCount = [int]$analysis.page_count
        Chars = $raw.Length
        Notes = $notes
    }
}

function Convert-TechSmithHtml {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$OutputPath,
        [string]$WorkDir,
        [string]$PriorNote
    )

    $extractResult = Invoke-PythonHelper -Mode "techsmith" -Arguments @($SourceFile.FullName)
    if ($extractResult.ExitCode -ne 0) {
        throw "TechSmith companion XML extraction failed. $($extractResult.Stdout) $($extractResult.Stderr)"
    }

    $extract = $extractResult.Stdout | ConvertFrom-Json
    $title = [string]$extract.title
    if ([string]::IsNullOrWhiteSpace($title)) {
        $title = $SourceFile.BaseName
    }

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("# $title")
    $lines.Add("")
    $lines.Add("Source HTML is a TechSmith/Camtasia player wrapper. MarkItDown could not extract useful body text, so this Markdown was built from the companion searchable slide XML.")
    $lines.Add("")
    $configName = [System.IO.Path]::GetFileName([string]$extract.config_path)
    $lines.Add("Companion XML: ``$configName``")
    $lines.Add("")
    $lines.Add("## Searchable Slide Text")
    $lines.Add("")

    foreach ($item in $extract.items) {
        $text = ([string]$item.text).Trim()
        if ($text.Length -gt 0) {
            $lines.Add("- [$([string]$item.time)] $text")
        }
    }

    $notes = "MarkItDown produced empty or tiny output. Extracted searchable slide text from companion TechSmith/Camtasia XML."
    if ($PriorNote) {
        $notes = "$PriorNote $notes"
    }

    $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method "techsmith-config-xml" -Status "completed" -PageCount 0 -OcrUnverified $false -Notes $notes
    $body = ($lines.ToArray() -join "`n") + "`n"
    Set-Content -LiteralPath $OutputPath -Value ($frontMatter + $body) -Encoding UTF8

    $raw = Get-Content -LiteralPath $OutputPath -Raw
    return [pscustomobject]@{
        Status = "Done - TechSmith XML"
        Method = "techsmith-config-xml"
        PageCount = 0
        Chars = $raw.Length
        Notes = $notes
    }
}

function Convert-WordWithCom {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$OutputPath,
        [string]$PriorNote
    )

    $word = $null
    $doc = $null
    try {
        $word = New-Object -ComObject Word.Application
        $word.Visible = $false
        $word.DisplayAlerts = 0
        try { $word.AutomationSecurity = 3 } catch { }

        $doc = $word.Documents.Open($SourceFile.FullName, $false, $true, $false)
        $rawText = [string]$doc.Range().Text
        $rawText = $rawText -replace "`r", "`n"
        $rawText = $rawText -replace "`a", "`t"
        $rawText = $rawText -replace "`v", "`n"
        $rawText = [regex]::Replace($rawText, "`n{3,}", "`n`n").Trim()

        if ([string]::IsNullOrWhiteSpace($rawText)) {
            throw "Microsoft Word COM opened the document but extracted no text."
        }

        $notes = "Extracted via Microsoft Word COM fallback with macros disabled."
        if ($PriorNote) {
            $notes = "$PriorNote $notes"
        }

        $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method "word-com" -Status "completed" -PageCount 0 -OcrUnverified $false -Notes $notes
        $body = "# $($SourceFile.BaseName)`n`n$rawText`n"
        Set-Content -LiteralPath $OutputPath -Value ($frontMatter + $body) -Encoding UTF8

        $raw = Get-Content -LiteralPath $OutputPath -Raw
        return [pscustomobject]@{
            Status = "Done - Word COM"
            Method = "word-com"
            PageCount = 0
            Chars = $raw.Length
            Notes = $notes
        }
    }
    finally {
        if ($null -ne $doc) {
            try { $doc.Close($false) | Out-Null } catch { }
            try { [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($doc) } catch { }
        }
        if ($null -ne $word) {
            try { $word.Quit() | Out-Null } catch { }
            try { [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) } catch { }
        }
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }
}

function Convert-ExcelWithCom {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$OutputPath,
        [string]$PriorNote
    )

    $excel = $null
    $workbook = $null
    try {
        $excel = New-Object -ComObject Excel.Application
        $excel.Visible = $false
        $excel.DisplayAlerts = $false
        try { $excel.AutomationSecurity = 3 } catch { }

        $workbook = $excel.Workbooks.Open($SourceFile.FullName, 0, $true)
        $lines = New-Object System.Collections.Generic.List[string]
        $lines.Add("# $($SourceFile.BaseName)")
        $lines.Add("")

        foreach ($sheet in $workbook.Worksheets) {
            $used = $sheet.UsedRange
            $rowCount = [int]$used.Rows.Count
            $colCount = [int]$used.Columns.Count
            if ($rowCount -lt 1 -or $colCount -lt 1) {
                continue
            }

            $lines.Add("## $([string]$sheet.Name)")
            $lines.Add("")

            for ($row = 1; $row -le $rowCount; $row++) {
                $cells = New-Object System.Collections.Generic.List[string]
                $nonEmpty = $false
                for ($col = 1; $col -le $colCount; $col++) {
                    $cellText = [string]$used.Cells.Item($row, $col).Text
                    if (-not [string]::IsNullOrWhiteSpace($cellText)) {
                        $nonEmpty = $true
                    }
                    $cells.Add((Escape-MarkdownCell $cellText))
                }
                if (-not $nonEmpty) {
                    continue
                }
                $lines.Add("| " + ($cells.ToArray() -join " | ") + " |")
                if ($row -eq 1) {
                    $lines.Add("| " + (($cells.ToArray() | ForEach-Object { "---" }) -join " | ") + " |")
                }
            }
            $lines.Add("")

            try { [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($used) } catch { }
        }

        $body = ($lines.ToArray() -join "`n").Trim()
        if ($body.Length -lt $MinMarkdownChars) {
            throw "Microsoft Excel COM opened the workbook but extracted no useful table text."
        }

        $notes = "Extracted via Microsoft Excel COM fallback with macros disabled."
        if ($PriorNote) {
            $notes = "$PriorNote $notes"
        }

        $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method "excel-com" -Status "completed" -PageCount 0 -OcrUnverified $false -Notes $notes
        Set-Content -LiteralPath $OutputPath -Value ($frontMatter + $body + "`n") -Encoding UTF8

        $raw = Get-Content -LiteralPath $OutputPath -Raw
        return [pscustomobject]@{
            Status = "Done - Excel COM"
            Method = "excel-com"
            PageCount = 0
            Chars = $raw.Length
            Notes = $notes
        }
    }
    finally {
        if ($null -ne $workbook) {
            try { $workbook.Close($false) | Out-Null } catch { }
            try { [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($workbook) } catch { }
        }
        if ($null -ne $excel) {
            try { $excel.Quit() | Out-Null } catch { }
            try { [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) } catch { }
        }
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }
}

function Convert-RawTextLikeFile {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$OutputPath,
        [string]$PriorNote
    )

    $raw = Get-Content -LiteralPath $SourceFile.FullName -Raw -ErrorAction Stop
    if ([string]::IsNullOrWhiteSpace($raw)) {
        throw "Source text file is empty or whitespace-only."
    }

    $extension = $SourceFile.Extension.ToLowerInvariant()
    $method = if (@(".html", ".htm") -contains $extension) { "raw-html-source" } else { "raw-text" }
    $notes = if ($method -eq "raw-html-source") {
        "MarkItDown produced empty or tiny output and no TechSmith companion XML was available. Preserved non-empty source HTML in a fenced Markdown block."
    }
    else {
        "MarkItDown produced empty or tiny output. Preserved non-empty source text directly."
    }
    if ($PriorNote) {
        $notes = "$PriorNote $notes"
    }

    if ($method -eq "raw-html-source") {
        $title = $SourceFile.BaseName
        if ($raw -match '(?is)<title[^>]*>(.*?)</title>') {
            $titleCandidate = [System.Net.WebUtility]::HtmlDecode(($Matches[1] -replace '\s+', ' ').Trim())
            if (-not [string]::IsNullOrWhiteSpace($titleCandidate)) {
                $title = $titleCandidate
            }
        }

        $body = @(
            "# $title",
            "",
            "Source HTML did not yield useful rendered text through MarkItDown. The original non-empty HTML source is preserved below.",
            "",
            "````html",
            $raw.TrimEnd(),
            "````",
            ""
        ) -join "`n"
    }
    else {
        $body = $raw.TrimEnd() + "`n"
    }

    $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method $method -Status "completed" -PageCount 0 -OcrUnverified $false -Notes $notes
    Set-Content -LiteralPath $OutputPath -Value ($frontMatter + $body) -Encoding UTF8

    $written = Get-Content -LiteralPath $OutputPath -Raw
    return [pscustomobject]@{
        Status = "Done - Raw Text"
        Method = $method
        PageCount = 0
        Chars = $written.Length
        Notes = $notes
    }
}

function Convert-OneFile {
    param(
        [System.IO.FileInfo]$SourceFile,
        [string]$BaseDir,
        [string]$OutputRoot,
        [string]$LogCsv,
        [string]$SummaryPath
    )

    $outputPath = Get-OutputPath -SourceFile $SourceFile -BaseDir $BaseDir -OutputRoot $OutputRoot
    $relativeSource = [System.IO.Path]::GetRelativePath($BaseDir, $SourceFile.FullName)
    $relativeOutput = [System.IO.Path]::GetRelativePath($OutputRoot, $outputPath)

    if ((Test-Path -LiteralPath $outputPath) -and -not $Force) {
        Write-Host "SKIP existing: $relativeSource"
        return [pscustomobject]@{ Counted = $false; Status = "Skipped"; Output = $outputPath }
    }

    $safeName = ($SourceFile.BaseName -replace "[^A-Za-z0-9._-]", "_")
    $hash = Get-StringHash -Text $SourceFile.FullName
    $workDir = Join-Path (Join-Path $env:TEMP "baza-doc-md") "$safeName-$hash"
    Remove-Item -LiteralPath $workDir -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Path $workDir -Force | Out-Null

    Write-Host "CONVERT: $relativeSource"
    $status = "Failed"
    $method = ""
    $pageCount = 0
    $chars = 0
    $notes = ""

    try {
        $usedMarkItDown = $false
        if ($Ocr -ne "Always") {
            $mark = Invoke-MarkItDown -SourceFile $SourceFile -WorkDir $workDir
            if ($mark.ExitCode -eq 0 -and $mark.Chars -ge $MinMarkdownChars) {
                $raw = Get-Content -LiteralPath $mark.TempMarkdown -Raw
                $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method "markitdown" -Status "completed" -PageCount 0 -OcrUnverified $false -Notes "Extracted by MarkItDown."
                Set-Content -LiteralPath $outputPath -Value ($frontMatter + $raw) -Encoding UTF8
                $usedMarkItDown = $true
                $status = "Done"
                $method = "markitdown"
                $chars = (Get-Content -LiteralPath $outputPath -Raw).Length
                $notes = "Extracted by MarkItDown."
            }
            elseif ($mark.ExitCode -ne 0) {
                $notes = "MarkItDown failed: $($mark.Stderr.Trim())"
            }
            else {
                $notes = "MarkItDown produced empty or tiny output."
            }
        }

        if (-not $usedMarkItDown) {
            if ($SourceFile.Extension.ToLowerInvariant() -eq ".pdf" -and $Ocr -ne "Never") {
                $ocr = Convert-PdfWithOcr -SourceFile $SourceFile -OutputPath $outputPath -WorkDir $workDir -PriorNote $notes
                $status = $ocr.Status
                $method = $ocr.Method
                $pageCount = $ocr.PageCount
                $chars = $ocr.Chars
                $notes = $ocr.Notes
            }
            elseif (@(".html", ".htm") -contains $SourceFile.Extension.ToLowerInvariant()) {
                try {
                    $html = Convert-TechSmithHtml -SourceFile $SourceFile -OutputPath $outputPath -WorkDir $workDir -PriorNote $notes
                }
                catch {
                    $fallbackNote = "$notes $($_.Exception.Message)"
                    $html = Convert-RawTextLikeFile -SourceFile $SourceFile -OutputPath $outputPath -PriorNote $fallbackNote
                }
                $status = $html.Status
                $method = $html.Method
                $pageCount = $html.PageCount
                $chars = $html.Chars
                $notes = $html.Notes
            }
            elseif (@(".doc", ".docx") -contains $SourceFile.Extension.ToLowerInvariant()) {
                $word = Convert-WordWithCom -SourceFile $SourceFile -OutputPath $outputPath -PriorNote $notes
                $status = $word.Status
                $method = $word.Method
                $pageCount = $word.PageCount
                $chars = $word.Chars
                $notes = $word.Notes
            }
            elseif (@(".xls", ".xlsx") -contains $SourceFile.Extension.ToLowerInvariant()) {
                $excel = Convert-ExcelWithCom -SourceFile $SourceFile -OutputPath $outputPath -PriorNote $notes
                $status = $excel.Status
                $method = $excel.Method
                $pageCount = $excel.PageCount
                $chars = $excel.Chars
                $notes = $excel.Notes
            }
            elseif ($SourceFile.Extension.ToLowerInvariant() -eq ".txt") {
                $text = Convert-RawTextLikeFile -SourceFile $SourceFile -OutputPath $outputPath -PriorNote $notes
                $status = $text.Status
                $method = $text.Method
                $pageCount = $text.PageCount
                $chars = $text.Chars
                $notes = $text.Notes
            }
            else {
                throw $notes
            }
        }
    }
    catch {
        $status = "Failed"
        if ([string]::IsNullOrWhiteSpace($method)) {
            $method = "failed"
        }
        if ([string]::IsNullOrWhiteSpace($notes)) {
            $notes = $_.Exception.Message
        }
        else {
            $notes = "$notes $($_.Exception.Message)"
        }
        if (-not (Test-Path -LiteralPath $outputPath)) {
            $frontMatter = New-FrontMatter -SourceFile $SourceFile -Method $method -Status "failed" -PageCount 0 -OcrUnverified $false -Notes $notes
            $body = "# $($SourceFile.BaseName)`n`n[Conversion failed. See notes in frontmatter and conversion log.]`n"
            Set-Content -LiteralPath $outputPath -Value ($frontMatter + $body) -Encoding UTF8
            $chars = (Get-Content -LiteralPath $outputPath -Raw).Length
        }
        Write-Host "FAIL: $relativeSource"
        Write-Host $notes
    }
    finally {
        if (-not $KeepWork) {
            Remove-Item -LiteralPath $workDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    $row = [pscustomobject]@{
        timestamp = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
        status = $status
        method = $method
        source_file = $relativeSource
        output_file = $relativeOutput
        page_count = $pageCount
        chars = $chars
        notes = $notes
    }
    Add-LogRow -LogCsv $LogCsv -SummaryPath $SummaryPath -Row $row

    return [pscustomobject]@{
        Counted = $true
        Status = $status
        Output = $outputPath
    }
}

$resolvedInput = Resolve-Path -LiteralPath $Path
$inputItem = Get-Item -LiteralPath $resolvedInput.Path

if ($inputItem.PSIsContainer) {
    $baseDir = $inputItem.FullName
    if ([string]::IsNullOrWhiteSpace($OutputDir)) {
        $OutputDir = Join-Path $inputItem.FullName "_markdown"
    }

    $getArgs = @{ LiteralPath = $inputItem.FullName; File = $true }
    if ($Recurse) {
        $getArgs.Recurse = $true
    }
    $files = Get-ChildItem @getArgs |
        Where-Object {
            $Extensions -contains $_.Extension.ToLowerInvariant() -and
            $_.FullName -notlike (Join-Path $OutputDir "*") -and
            -not ($_.FullName -match '\\_markdown(\\|$)')
        } |
        Sort-Object FullName
}
else {
    $baseDir = $inputItem.DirectoryName
    if ([string]::IsNullOrWhiteSpace($OutputDir)) {
        $OutputDir = Join-Path $inputItem.DirectoryName "_markdown"
    }
    $files = @($inputItem)
}

New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
$outputRoot = (Resolve-Path -LiteralPath $OutputDir).Path
$logCsv = Join-Path $outputRoot "conversion-log.csv"
$summaryPath = Join-Path $outputRoot "conversion-log.md"

if ($ListOnly) {
    $files | Select-Object FullName, Extension, Length, LastWriteTime
    return
}

$processedCount = 0
foreach ($file in $files) {
    if ($MaxFiles -gt 0 -and $processedCount -ge $MaxFiles) {
        break
    }

    $result = Convert-OneFile -SourceFile $file -BaseDir $baseDir -OutputRoot $outputRoot -LogCsv $logCsv -SummaryPath $summaryPath
    if ($result.Counted) {
        $processedCount += 1
    }
}

Write-Host ""
Write-Host "Output folder: $outputRoot"
Write-Host "Log: $logCsv"
Write-Host "Summary: $summaryPath"
