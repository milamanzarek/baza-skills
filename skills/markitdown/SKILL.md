---
type: note
note_status: active
name: markitdown
description: "Deterministic local document-to-Markdown conversion workflow for Baza, OneDrive, and Downloads folders. Use when the user asks to convert PDFs, Office docs, HTML, TXT, scanned PDFs, sensitive document folders, or batches of documents to Markdown with MarkItDown, OCR fallback, verification, and Baza logging."
metadata:
  author: Kamil/Codex
  version: "1.0.0"
---

# Baza MarkItDown Conversion

Use this skill to convert document folders to Markdown with a deterministic local workflow.

## Core Rules

- Process the exact file or folder scope requested by the user.
- For sensitive folders, process one child folder at a time and keep chat/log summaries count-focused.
- Do not use cloud OCR or upload documents unless the user explicitly approves it.
- Write output to `_markdown` beside the source folder unless the user asks otherwise.
- Verify output counts and frontmatter statuses before reporting success.
- Log completed work in the Baza weekly activity log when working in the Baza environment.

## Bundled Scripts

- `scripts/Convert-DocsToMarkdown.ps1`: primary deterministic converter.
- `scripts/Test-DocsToMarkdownOutput.ps1`: verification helper for expected outputs, statuses, and methods.

Prefer the bundled scripts for new agents. If working inside Baza and the canonical script already exists at `C:\Users\kamil\PROJECTS\Baza\99-System\Scripts\Convert-DocsToMarkdown.ps1`, use the canonical script unless the user asks to test the skill copy.

## Workflow

1. Inventory the requested scope before converting.
2. Use `-Recurse` when the user asks for subfolders, or when the ongoing conversion session convention says subfolders are included.
3. Use `-MaxFiles` chunks for large or sensitive folders.
4. Use `-OcrLanguage "eng+rus"` for bilingual English/Russian folders.
5. Run verification with `scripts/Test-DocsToMarkdownOutput.ps1`.
6. Log the result with source count, Markdown count, missing count, status counts, method counts, and any failed/skipped placeholders.

For detailed behavior and fallback rules, read `references/workflow.md`.
For Baza tracker/activity logging, read `references/logging.md`.
For command patterns, read `examples/commands.md`.

## Recommended Commands

```powershell
$runner = "C:\Users\kamil\PROJECTS\Baza\99-System\Scripts\Convert-DocsToMarkdown.ps1"
& $runner -Path "SOURCE_FOLDER" -Recurse -MaxFiles 25 -OcrLanguage "eng+rus"
```

```powershell
$verify = "C:\Users\kamil\PROJECTS\CHERDAK\antigravity-agents\baza-skills\markitdown\scripts\Test-DocsToMarkdownOutput.ps1"
& $verify -Path "SOURCE_FOLDER" -Recurse
```

