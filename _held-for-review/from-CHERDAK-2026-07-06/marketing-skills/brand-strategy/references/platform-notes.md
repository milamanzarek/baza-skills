# Platform-Specific Calibration Notes

Read this file when adapting the Brand Strategy OS for GPT-4o or Gemini, or when troubleshooting
output quality issues on any platform.

---

## Platform Comparison Table

| Instruction Type | Claude | GPT-4o | Gemini 1.5 Pro |
|---|---|---|---|
| System Prompt placement | Project Instructions field | System message | System Instructions in Gem config |
| File handling | Attach all files to chat; Claude states what it found in each | Attach via paperclip; mention each file explicitly in the message | Upload to Gem; files persist in the session |
| SVG generation (P2) | Excellent; outputs clean SVG without nudging | Good; add "output raw SVG code only, no prose" | Good; add "do not truncate the SVG code" |
| Long-form table output (P1) | May truncate at ~14,000 tokens — split into P1a (S1–7) and P1b (S8–14 + CSV) if needed | Handles well with GPT-4o-128k | Best long-context performance; rarely truncates |
| CSV output | Add "do not truncate the CSV" as explicit final instruction | Reliable without extra instruction | Very reliable |
| In-session memory | Persists within a Project — use Projects for repeat clients | Custom GPT memory is optional and unreliable for long sessions | Session-scoped; re-upload files between sessions |

---

## Claude-Specific Notes

### Truncation Prevention
- P1 is the highest-risk phase for truncation (14 sections + CSV)
- If the model stops before completing: re-run with "Continue from Section [N]"
- CSV truncation: always end the P1 prompt with "Do not truncate the CSV. Include every row."
- Split strategy: P1a = Sections 1–7, P1b = Sections 8–14 + CSV (paste P1a output as context for P1b)

### File Handling
- Claude reads all attached files automatically — state in your first message what files are attached
- For P0: "I've attached [list of files]. Please begin the Intake Parser."
- For P2: "I've attached the logo file. Please begin the Logo Brief."

### SVG Output
- Claude generates clean SVG reliably
- If SVG is truncated, ask: "Continue outputting the SVG lockups from where you left off."

### Project Setup (Repeat Clients)
- Create a Claude Project per client
- Upload all intake materials to the Project once
- Brand strategy session history persists — reference previous sessions naturally

---

## GPT-4o-Specific Notes

### SVG Generation
Add to every SVG request: "Output raw SVG code only, no prose before or after the code block."

### Vision Mode (Existing Logo)
- Attach logo image directly to the message
- GPT-4o will attempt to extract exact hex values from color swatches or screenshots
- Ask explicitly: "Extract the exact hex values from the uploaded color swatch."

### Custom GPT Configuration
- Paste BRAND_STRATEGY_OS.md content into the System Instructions field
- Memory is unreliable for long sessions — paste full context at the start of each P1 session

---

## Gemini 1.5 Pro-Specific Notes

### Long-Context Advantage
- Gemini handles the full P1 (all 14 sections + CSV) in a single pass most reliably
- Rarely truncates — but always add "do not truncate" for CSV as a precaution

### SVG Output
Add to every SVG request: "Do not truncate the SVG code. Output the complete SVG for each configuration."

### File Persistence
- Files uploaded to a Gem persist for the session
- Re-upload intake files at the start of each new session if the Gem was closed

### Gem Configuration
- Paste BRAND_STRATEGY_OS.md content into the System Instructions field in the Gem config

---

## Troubleshooting Common Issues

| Problem | Cause | Fix |
|---|---|---|
| CSV is malformed / breaks on import | Commas inside cell values not escaped | Add: "Escape all commas within cell values using double-quotes. No line breaks within cells." |
| Voice Slider scores feel arbitrary | Model generated numbers without grounding | Re-run Section 12 with: "Every score MUST cite a direct quote from the intake as evidence." |
| SVG lockups use generic colors | Model defaulted to placeholder hex values | Explicitly paste the hex codes from Section 6 into the P2 prompt |
| HTML presentation missing Preface or About page | Model skipped early pages | Re-run P3 with "Build in this exact order" and list all required pages explicitly |
| Logo brief is hollow / generic | Section 6 & 7 weren't complete enough | Re-run P1 Sections 6 & 7 first, then re-run P2 with richer input |
| Section data feels invented, not grounded | Weak P0 output | Re-run P0 and ask: "Do not infer or generate. Only extract what the client explicitly said." |