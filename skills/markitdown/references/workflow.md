# Workflow Reference

## Supported Inputs

Default extensions:

- `.pdf`
- `.docx`
- `.doc`
- `.pptx`
- `.ppt`
- `.xlsx`
- `.xls`
- `.csv`
- `.html`
- `.htm`
- `.txt`

## Conversion Behavior

The runner tries MarkItDown first unless `-Ocr Always` is set.

Fallbacks:

- Image-only PDF: local Tesseract OCR.
- Large image-only PDF over the page cap: skipped placeholder unless `-MaxOcrPages 0`.
- TechSmith/Camtasia HTML wrapper: companion `_config.xml` extraction when available.
- Non-empty tiny/source-heavy `.txt`, `.html`, `.htm`: raw local text/source preservation.
- Legacy Word/Excel: local Word/Excel COM fallback with macros disabled.

Generated Markdown frontmatter includes:

- `source_file`
- `conversion_status`
- `conversion_method`
- `converted_at`
- `ocr_language`
- `ocr_unverified`
- `page_count`
- `notes`

## Safety Rules

- Keep sensitive files local.
- Do not broadly convert a parent folder when the user names a sensitive child folder.
- Do not follow or create symlinks/junctions.
- Do not treat OCR output as verified text.
- Keep chat summaries count-focused for legal, medical, immigration, financial, identity, or family records.
- Recursive scans skip any nested `_markdown` output tree.

## Chunking Defaults

- Small folders: run one full recursive pass.
- Medium folders: use `-MaxFiles 20` or `-MaxFiles 25`.
- Sensitive/OCR-heavy folders: use `-MaxFiles 15`.
- Rerun the same command until the final verification shows all expected outputs are present.

