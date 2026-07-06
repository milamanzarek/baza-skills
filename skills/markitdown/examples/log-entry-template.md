# Log Entry Template

Weekly activity log row:

```markdown
| YYYY-MM-DD | Codex | Converted FOLDER_NAME documents to Markdown | Complete | Converted SOURCE_PATH recursively into _markdown. Final verification: N source files, N Markdown outputs, zero missing expected outputs, X completed outputs, Y failed/skipped placeholders. Counts: METHOD_COUNTS. Sensitive files were processed locally only. |
```

Tracker queue section:

```markdown
## FOLDER_NAME Queue

Output folder: `SOURCE_PATH\_markdown`

Detailed log: `SOURCE_PATH\_markdown\conversion-log.md`

| Status | Scope | Source files | Markdown outputs | Notes |
| --- | --- | ---: | ---: | --- |
| Done | Top-level and subfolders | N | N | Recursive conversion completed with `Convert-DocsToMarkdown.ps1 -Recurse -OcrLanguage "eng+rus"`. Final verification found zero missing expected outputs and zero failed/skipped outputs. Final method counts: METHOD_COUNTS. |
```

