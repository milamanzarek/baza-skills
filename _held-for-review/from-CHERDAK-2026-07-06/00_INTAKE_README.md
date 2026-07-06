# Intake: skills consolidated out of CHERDAK (2026-07-06)

**Ruling:** Kamilla, 2026-07-06 — "all skills live in PROJECTS\baza-skills." This intake executes that ruling for everything found in `CHERDAK/antigravity-agents/` during the CHERDAK git-tree cleanup (Session H continuation).

**Provenance:** these lived in `CHERDAK/antigravity-agents/skills/`, an Antigravity working area inside the transcript archive. Full pre-move state is preserved in `G:\My Drive\DIGITAL_ATTIC\from-CHERDAK-cleanup-2026-07-06\cherdak-all-refs-2026-07-06.bundle` and in CHERDAK git history.

## What is here

### `gsd-codex-port/` — 65 skills, NOT previously in baza-skills
A Codex-adapted port of the installed GSD plugin (`~/.claude/skills/gsd-*`): byte-identical except every path rewritten `$HOME/.claude` → `$HOME/.Codex`. Created 2026-06-18 (the evening of the skills consolidation), presumably to give Codex the GSD workflows. Regenerable by re-running the path rewrite, but kept because it records intent.
**Review question:** should GSD skills join the canonical `skills/` set, and if so, in which path convention (per-agent ports vs one copy + pointer)?

### `variants-vs-canonical/` — 4 skills that DIFFER from `skills/<same-name>`
- `microsoft-foundry` — CHERDAK copy carries live edits made after consolidation (~+555/−1039 lines across 14 files vs its own git base). Likely NEWER than canon. Reconcile before adopting.
- `neon-postgres` — 1 file differs.
- `ui-ux-pro-max` — 20 files differ.
- `notebooklm` — 14 files differ. Was a git clone of `https://github.com/PleasePrompto/notebooklm-skill`; inner `.git` stripped at intake (content only; upstream URL recorded here).
**Review question per skill:** newer-wins into `skills/`, or discard the variant?

### Flat items — NOT previously in baza-skills
- `marketing-skills/` (72K), `research-skills/` (68K), `workctl/` (100K), `mdsilo.json` (100K manifest).

## Handled elsewhere (not in this folder)
- 4 `higgsfield-*` skills + `baza-skills/markitdown` copy in CHERDAK: byte-identical to canon → removed from CHERDAK, no intake needed.
- `dev-skills/`, `global_skills/`: empty directory shells, zero files → removed.
- `agency_personas`: not a skill — persona collection; de-forked in place in CHERDAK per Kamilla's 2026-07-06 ruling (inner repo bundled to the Attic first).

---
created_by: Claude Code (Fable 5), 2026-07-06
