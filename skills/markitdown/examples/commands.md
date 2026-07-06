# Command Examples

Use the canonical Baza runner when working in the Baza workspace:

```powershell
$runner = "C:\Users\kamil\PROJECTS\Baza\99-System\Scripts\Convert-DocsToMarkdown.ps1"
```

Use the bundled skill runner when the Baza script is not available:

```powershell
$runner = "C:\Users\kamil\PROJECTS\CHERDAK\antigravity-agents\baza-skills\markitdown\scripts\Convert-DocsToMarkdown.ps1"
```

Inventory only:

```powershell
& $runner -Path "SOURCE_FOLDER" -Recurse -ListOnly
```

Convert a small folder:

```powershell
& $runner -Path "SOURCE_FOLDER" -Recurse -OcrLanguage "eng+rus"
```

Convert a large or sensitive folder in chunks:

```powershell
& $runner -Path "SOURCE_FOLDER" -Recurse -MaxFiles 15 -OcrLanguage "eng+rus"
```

Rerun the same chunk command until no new files convert, then verify:

```powershell
$verify = "C:\Users\kamil\PROJECTS\CHERDAK\antigravity-agents\baza-skills\markitdown\scripts\Test-DocsToMarkdownOutput.ps1"
& $verify -Path "SOURCE_FOLDER" -Recurse
```

Force refresh HTML/TXT after a fallback patch:

```powershell
& $runner -Path "SOURCE_FOLDER" -Recurse -Force -Extensions ".html", ".htm", ".txt" -OcrLanguage "eng+rus"
```

