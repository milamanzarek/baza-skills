# baza-skills: the one home for every agent skill

**DEC-17 (2026-06-12):** this repo is the single canonical home for all agent skills in Kamilla's system. Ratified, created, named, and pushed the same day.
**Local:** `C:\Users\kamil\PROJECTS\baza-skills` · **Remote:** `github.com/milamanzarek/baza-skills` (private)

## What lands here (after migration)

All skills currently scattered across:
- `~\.claude\skills` (102)
- `~\.gemini\skills` (43)
- `CHERDAK\antigravity-agents\skills` (the Amnesia-era temporary refuge, reached via the `~\.agents\skills` symlink)
- `G:\My Drive\AI-Skills` (1: kamilla-closing-coach, integration deferred per Kamilla 2026-06-12)
- `~\.agents\skills_old` and `~\.agents\_00_backup` leftovers (triage, then retire)

## Migration is GATED. Do not move skills yet.

Execution = engagement backlog item 1. It waits for the **X2 skill-format decision** (one shared SKILL.md format readable by every agent, R-D02-07) so everything migrates once, not twice. Until then this repo holds structure and rules only.

## Architecture (ratified)

- **One physical home:** this repo.
- **Agent discovery via junctions:** after migration, `~\.claude\skills`, `~\.gemini\skills`, and `~\.agents\skills` all point here. One home, N native discovery paths.
- **Cloud agents:** Jules reads the GitHub remote; Gemini Spark gets a one-way Drive mirror leg (the mirror-v2 pattern).
- **Git history is the anti-Amnesia property:** every change to every skill is a logged, attributed commit. A skill can never again be silently "optimized" out of existence.

## Rules

1. Skills enter through the guarded write path (X4) once it exists; until then, by reviewed commit only.
2. One skill = one folder = one `SKILL.md` (format ratifies at X2).
3. Every skill carries `created_by` and a changelog.
4. No em dashes anywhere (global rule, 2026-06-12).
5. Dedupe on entry: check the index before adding; near-duplicates merge, never multiply.

---
Created by Fable 5 (Claude Code) on Kamilla's ratification, 2026-06-12.
