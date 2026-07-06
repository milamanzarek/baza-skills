# Skills Consolidation Report

- **Date:** 2026-06-18
- **Author:** Claude (Cowork session, plan-first pass)
- **Target library:** `C:\Users\kamil\PROJECTS\baza-skills`
- **Status:** PLAN ONLY. Nothing moved, archived, relinked, converted, or executed. Awaiting Kamilla's approval and the X2 format ratification before any Phase 4 migration.

This report covers Phases 0 to 3 of the brief. It ends with a decision gate. The companion file `SKILLS_MANIFEST.xlsx` holds the full row-level inventory, the family map, and the canonical-choice table.

---

## 1. Executive summary (read this first)

The sweep found **2,845 skill directories** across the accessible sources. After collapsing exact duplicates they reduce to **1,444 distinct skill families**. Two facts reshape the original brief:

1. **The library is overwhelmingly collected third-party material, not Kamilla's authored work.** Of the 1,444 distinct families, roughly **1,113 are marked `source: community`**, **193 carry a third-party GitHub or vendor URL as their source**, **58 are unmarked**, and only **about 80 are marked `personal` / `self` / `original`** (Kamilla's own). The big `CHERDAK\antigravity-agents\skills_backup` collection is a curated aggregation of public skills following an "Antigravity Diamond Standard," with provenance and license tracked in frontmatter. It is closer in nature to the AI_LABS reference libraries (which the brief says to LEAVE and catalog) than to a personal skill library.

2. **There is almost no genuine version drift.** Of 1,444 families, **1,385 are exact duplicates** (identical folder hash) and only **13 show any drift**. Of those 13, **11 are just the `skills_backup` top-level copy versus its own `skills_backup\full_library\` mirror** (internal capture artifact). Only **3 families drift across real agent boundaries** and need a canonical pick: `checkly`, `imagen`, `test-driven-development`.

> **Provenance caution (added 2026-06-18 after Kamilla review):** some captured skills reference an "Antigravity Diamond Standard" / "Estándar de Diamante" in their own `SKILL.md` text. Kamilla has confirmed that standard was hallucinated content, not a real ratified spec. This is treated as further evidence that much of `skills_backup` is AI-generated or collected material of uncertain value, and the schema proposal below does NOT rely on it.

Because of point 1, the central decision is no longer "how to move 2,830 skills safely." It is **"which of these 1,444 belong in `baza-skills` as Kamilla's canonical library, versus which are third-party reference material that should be cataloged in place or kept as a separate reference set."** The plan below is built around that gate.

The migration also remains **gated by the charter**: the `baza-skills` README states migration waits for the X2 shared-`SKILL.md`-format decision (R-D02-07), so the repo "holds structure and rules only" until then. That gate is still in effect. Format status is **PENDING**, so this report **proposes** a schema and does **not** convert anything.

---

## 2. Phase 0: charters, format gate, access

### 2.1 Charters read
- `baza-skills\README.md` (DEC-17 ratified 2026-06-12): one physical home, agent discovery via junctions, git history as the anti-amnesia property, dedupe on entry, one skill = one folder = one `SKILL.md`, **no em dashes anywhere**, `created_by` + changelog on every skill.
- `Baza\99-System\Protocols\Global_File_Folder_Creation_Protocol.md` (GLBL-PRTCL-027): search before creating, one canonical home, every managed folder gets `00_README.md`, active folders get `01_INDEX_[folder].md`, retire by superseding (never silent delete), no secrets in notes/names/logs, `YYYY-MM-DD` dates, descriptive-first naming.
- `Baza\99-System\SOPs\BAZA_Folder_Structure_and_Naming_Protocol.md` (reference, present).

### 2.2 Format decision status: PENDING
The README explicitly gates migration on the **X2 skill-format decision** ("one shared `SKILL.md` format readable by every agent, R-D02-07"). No ratified schema file exists in `baza-skills` yet. Therefore: schema is **proposed** in Section 7, and **no format conversion is performed**.

### 2.3 Access confirmed and gaps
**Reachable this session (mounted under `PROJECTS`):** all PROJECTS-side sources, including `baza-skills` (confirmed: only `README.md`, gate intact), CHERDAK, CORE_OS, career-ops, the small standalone homes, and AI_LABS.

**NOT reachable this session (require a mount / connector before they can be swept):**
- `C:\Users\kamil\.claude\skills` (~102) and `C:\Users\kamil\.gemini\skills` (~43): the user-global home directory is not mounted here. The README and brief both call these the primary input where the bulk of Kamilla's own usable skills likely live. **They are NOT in this inventory.**
- `C:\Users\kamil\.craft-agent\`, `C:\Users\kamil\.codex\`: not reachable; presence unconfirmed.
- OneDrive and Google Drive skill exports/backups: not reachable as a synced folder here. Per the README, Drive integration was already deferred by Kamilla on 2026-06-12 (1 skill, `kamilla-closing-coach`).

**Consequence:** this inventory is complete for PROJECTS but does not yet include the user-global home dirs or cloud. See Open Question O-1.

---

## 3. Phase 1: inventory summary

Full row-level data is in `SKILLS_MANIFEST.xlsx` (sheet `Inventory`) and `SKILLS_inventory_full.csv`.

| Source root | Disposition | Skill dirs found |
|---|---|---|
| `CHERDAK\antigravity-agents\skills_backup` (+ its `full_library\` mirror) | PRIMARY | 2,795 |
| `CHERDAK\antigravity-agents\skills` | PRIMARY | 5 |
| `CHERDAK\antigravity-agents\baza-skills` (captured old copy) | PRIMARY / recovery | 1 |
| `CORE_OS\03_TECHNICAL_EXPERIMENTS\...\agent-skills\skills` | CARE | 19 |
| `CORE_OS\.adk\skills` | CARE | 6 |
| `CORE_OS\.gemini\skills` | CARE | 3 |
| `CORE_OS\.claude\skills` | CARE | 1 |
| `CORE_OS\.agents\skills` | CARE | 1 |
| `career-ops\.claude` `\.agents` `\.qwen` | CARE-UPSTREAM | 3 |
| `road-trip-recommendations-by-mila\...\agent\skills` | CONSOLIDATE | 7 |
| `uftanma\Skills` | CONSOLIDATE | 1 |
| `Baza_Legacy\gemini-scribe\Skills` | CONSOLIDATE | 1 |
| `brand-os-kamilla\04_design-explorations` | CONSOLIDATE | 1 |
| `mistral-workflows\workflow-1\.agents` | CONSOLIDATE | 1 |
| **Total** | | **2,845** |
| `AI_LABS\...` (vendored reference, LEAVE) | CATALOG | ~355 (not row-inventoried; cataloged in place) |

Per-skill fields captured: folder name, manifest `name`, provenance `source`, `author`, `license`, `risk`, `category`, `version`, `date_added`, source label, full path, file count, byte size, latest mtime, a 16-char folder content hash, a secrets flag, and a one-line purpose.

### 3.1 The `skills_backup` shape
`skills_backup` holds ~1,391 top-level skill folders plus a near-complete `full_library\` mirror of them. That mirror is the source of nearly all the "duplication." The 5 dirs in `skills`, and the captured `baza-skills` copy, are small.

---

## 4. Phase 2: duplicate-family map and drift

Families are grouped by normalized folder/`name` (lowercased, trailing `v2`/`copy`/`backup`/`old`/date stripped). Full table in `SKILLS_MANIFEST.xlsx` (sheet `Families`) and `SKILLS_families.csv`.

| Classification | Families | Meaning |
|---|---|---|
| Singletons | 46 | One copy only. Carry over as-is (subject to the provenance gate). |
| Exact duplicates | 1,385 | 2+ copies, identical hash. Keep one canonical, archive the rest. |
| Drifted | 13 | 2+ copies, different hashes. Pick canonical, archive others. |
| **Distinct families total** | **1,444** | |

### 4.1 The 13 drifted families
- **11 are `skills_backup` top-level vs `skills_backup\full_library\`** (same skill, mirror drifted by a file or minor edit): `advanced-evaluation`, `api-design-principles`, `hugging-face-vision-trainer`, `lint-and-validate`, `mobile-design`, `monte-carlo-push-ingestion`, `team-collaboration-standup-notes`, `ui-ux-pro-max`, `voice-ai-engine-development`, `whatsapp-cloud-api`, and `imagen` (partly). For these, the newer/larger of the two is canonical; the other is archived. No human merge needed.
- **3 drift across real agent boundaries** (these are the only true canonical-pick decisions):
  - `checkly`: `CORE_OS\.claude\skills` (2026-05-15) vs `CORE_OS\.agents\skills` (2026-05-19). Minor drift, 1 file each.
  - `imagen`: `CORE_OS\.adk\skills` (2026-05-14) vs CHERDAK `skills_backup` (2026-05-20). Different content.
  - `test-driven-development`: `CORE_OS\...\agent-skills\skills` (2026-05-07) vs CHERDAK `skills_backup` (2026-05-20, 2 files). Different content.

None of the 13 shows the kind of large capability divergence that demands a capability merge, but all 13 are flagged in the manifest for a quick eyeball before archiving the non-canonical copy (Golden Rule 4: no version lost).

### 4.2 Per-agent references
Each skill's serving agent is implied by the directory it lives in: `.claude` to Claude Code, `.gemini` to Gemini, `.adk` to Google ADK, `.qwen` to Qwen, `.agents` to the shared antigravity agents path, and the `CHERDAK\antigravity-agents` tree to the captured antigravity workspace. The manifest records the source label per row so access can be preserved per agent. **Note:** CHERDAK is an archive, not a live agent path, so moving skills out of it breaks no running agent. The live agent paths in scope are the CORE_OS `.claude` / `.gemini` / `.adk` / `.agents` stashes and the standalone homes.

### 4.3 Provenance triage (the key reframe)
Distinct families by provenance bucket:

| Provenance | Distinct families | Recommended treatment |
|---|---|---|
| `community` | 1,113 | Decision needed (O-2). Collected third-party. |
| third-party GitHub / vendor URL | 193 | Decision needed (O-2). Upstream clones, often licensed (MIT, Apache-2.0, BSD). |
| unmarked (`source` empty) | 58 | Review; likely mixed. |
| `personal` / `self` / `original` | ~80 | Kamilla's own. Migrate into `baza-skills`. |

This is why the migration is not a simple "move all of CHERDAK in." Roughly 90 percent of the collection is collected third-party content with tracked upstream sources and licenses.

---

## 5. career-ops and AI_LABS (confirmations)

- **career-ops is upstream, LEAVE.** Git remote is `github.com/santifer/career-ops` (a third-party clone, not Kamilla's repo). Its `.claude`, `.agents`, and `.qwen` stashes each contain exactly one skill literally named `career-ops`, i.e. the clone's own shipped skill, not Kamilla's additions. Recommendation: do not migrate; catalog once. (Resolves the brief's open question on career-ops.)
- **AI_LABS reference libraries: LEAVE and catalog.** ~355 `SKILL.md` under `AI_LABS\04_Reference_Libraries` and `AI_LABS\02_AI_Frameworks` and `AI_LABS\gemini-cli-deep-research\skills` are vendored upstream clones (claude-cookbooks, agency-agents, adk-samples, deer-flow, vertex-ai-creative-studio, etc.). Not row-inventoried; recorded once as external reference per the brief.

---

## 6. Secrets flags (never exposed)

The scanner flagged 547 directories on a broad keyword match (`api_key`, `secret`, `token`, `password`, `bearer`), but **almost all are documentation that merely mentions those words.** Only **6 directories trip a high-confidence credential pattern, and they are 3 distinct skills each mirrored into `full_library\`:**

| Skill (distinct) | Pattern type | Paths (no values shown) |
|---|---|---|
| `comfyui-gateway` | AWS-key-shaped string | `...\skills_backup\comfyui-gateway`, `...\skills_backup\full_library\comfyui-gateway` |
| `aws-iam-best-practices` | AWS-key-shaped string | `...\skills_backup\security\aws-iam-best-practices`, `...\skills_backup\full_library\security\aws-iam-best-practices` |
| `k8s-manifest-generator` | PRIVATE KEY header | `...\skills_backup\k8s-manifest-generator`, `...\skills_backup\full_library\k8s-manifest-generator` |

`aws-iam-best-practices` and `k8s-manifest-generator` are security/devops skills, so these are very likely example or placeholder values in documentation rather than live credentials, but per Golden Rule 8 they are **flagged, not judged, and never printed.** Kamilla should review these three before any centralization (O-4). The full keyword list is in the manifest `secrets` column for completeness.

---

## 7. Phase 3: proposed target layout, canonical choices, schema, access

### 7.1 Proposed `baza-skills` internal layout (per charter)
```
baza-skills\
  README.md                      (existing charter)
  00_README.md                   (Phase 5, post-approval: orientation surface)
  01_INDEX_skills.md             (Phase 5: folder dashboard / registry)
  CHANGELOG.md                   (Phase 5: every canonical choice, archive, junction)
  skills\                        (canonical skills, one folder each)
    <skill-name>\SKILL.md + resources
  _archive\
    superseded-skills-2026-06-18\<source-label>\<skill>\   (non-canonical versions)
    from-CHERDAK-2026-06-18\<skill>\                        (drift losers, mirror losers)
  _reference\                    (OPTIONAL, pending O-2: catalog of community/third-party
                                  skills kept for reference rather than adopted as canonical)
```
Grouping inside `skills\` can be flat or by `category` frontmatter (the antigravity standard already carries `category`). Recommendation: flat folders with a category column in `01_INDEX_skills.md`, to match the README's "one skill = one folder."

### 7.2 Canonical-choice rules (applied per family in the manifest)
1. Singleton: it is canonical.
2. Exact duplicate: keep one (prefer the live agent path over CHERDAK; prefer `skills_backup` top-level over `full_library`); archive the rest with a provenance note.
3. Drift: canonical = newest `date_added`/mtime AND most complete (file count, richest frontmatter) AND closest to the ratified schema; archive the others. The 3 cross-agent drifts (`checkly`, `imagen`, `test-driven-development`) are pre-flagged for Kamilla to eyeball.
4. Never let a thinner/older copy overwrite a fuller/newer one. Never delete; archive.

The manifest `Families` sheet proposes canonical-vs-archive per family; it is a proposal, not yet executed.

### 7.3 Proposed canonical SKILL.md schema (format is PENDING; do not convert yet)
This proposal is anchored on Anthropic's `SKILL.md` (only `name` + `description` are required; any extra keys are ignored by Claude). The optional fields below are simply the provenance and routing fields that already appear in many of the captured files; adopting them as optional means the bulk of the library needs no rewrite. This is NOT an endorsement of any pre-existing "standard" found in the captured text (see the provenance caution in Section 1).

```yaml
---
name:            # required (Anthropic-compatible)
description:     # required (Anthropic-compatible; the trigger text)
id:              # optional, stable slug
version:         # optional
created_by:      # required by baza-skills charter
date_added:      # YYYY-MM-DD
source:          # personal | self | original | community | <upstream URL>
author:          # original author when source is third-party
license:         # when known
category:        # for the index
risk:            # safe | caution | critical
ecosystem:       # claude | gemini | antigravity | adk | qwen | other
---
```
Per-ecosystem mapping (Gemini/ADK/Qwen manifests to this schema) is drafted in the manifest `Schema-Mapping` sheet. **No conversion happens until Kamilla ratifies X2.**

### 7.4 Access-preservation plan (Windows junctions)
Goal (Golden Rule 2): after any skill leaves a live agent path, that agent must still resolve it. CHERDAK is not a live path, so it needs no junction; the live paths do.

Default mechanism (charter's intended pattern): replace each live agent skills dir with a **directory junction** into `baza-skills\skills` (or a per-agent subset), created with `mklink /J`. Plan:

1. For each live agent skills dir in scope (the CORE_OS `.claude` / `.gemini` / `.adk` / `.agents` stashes; the user-global `~\.claude\skills` and `~\.gemini\skills` once mounted; the standalone homes): migrate its skills into `baza-skills`, verify them present and intact (file count + hash match), then create a junction from the old path to `baza-skills`.
2. **Verify before removing.** Confirm the agent resolves all its skills through the junction before deleting any original. If uncertain, leave the original and flag it.
3. **Git interaction:** a junction inside a tracked git repo can confuse git. Several live stashes sit inside repos (`CORE_OS`, etc.). Prefer junctions in true home dirs (`~\.claude`, `~\.gemini`). For repo-internal stashes, prefer **config repointing** (point the agent config at `baza-skills`) over an in-repo junction, or add the junction path to that repo's `.gitignore`. Each link or repoint is logged in `CHANGELOG.md`.
4. **CHERDAK move is git-to-git:** copy into `baza-skills`, verify, then `git rm` from CHERDAK, commit both sides with clear messages, leave `MIGRATED_TO_baza-skills.md` in CHERDAK. No history rewrite.

---

## 7.5 Decisions recorded with Kamilla (2026-06-18)

- **No hallucinated or AI-generated content gets adopted.** Kamilla: "we are not using hallucinated anything." The dubious/generated material in `skills_backup` (including skills that cite a non-existent "Diamond Standard") is excluded from canonical adoption. This points to the conservative scope: canonical = Kamilla's own-authored skills (~80 `personal`/`self`/`original` families) + the project-home skills; the collected community/third-party set is cataloged as reference only, not adopted.
- **Today's goal was the plan, not the move.** Kamilla confirmed the inventory/plan is what was needed today. No migration performed. Home-dir (`~\.claude\skills`, `~\.gemini\skills`) and cloud remain unswept and unmounted; sweeping them is the first step whenever migration is picked up.
- Migration stays gated; resume from Section 8 open questions when ready.

## 8. Open questions (decision gate, Kamilla)

- **O-1 (access):** Mount the user-global `C:\Users\kamil\.claude\skills` (~102) and `C:\Users\kamil\.gemini\skills` (~43), and confirm `.craft-agent` / `.codex`, so they can be inventoried before Phase 4? These are likely the bulk of your own usable skills and are not yet covered. Cloud (OneDrive/Drive) remains deferred unless you want it enumerated.
- **O-2 (scope, the big one):** Should `baza-skills` adopt the full ~1,444-family curated collection (mostly `community`/third-party with tracked sources and licenses), or only your **own-authored subset** (~80 `personal`/`self`/`original` plus the small project homes), and keep the community set as a separate `_reference` catalog? The charter rule "come out clean, not 2,830 near-copies" and "dedupe on entry" plus the third-party-leave triage principle both point toward the narrower option, but this is your call.
- **O-3 (format / X2):** The charter gates migration on the X2 `SKILL.md` format decision. Ratify the proposed schema in 7.3 (or amend it) so Phase 4 can proceed, or keep the gate closed and treat this as plan-only.
- **O-4 (secrets):** Review the 3 secret-bearing skills (`comfyui-gateway`, `aws-iam-best-practices`, `k8s-manifest-generator`) before centralizing. Confirm whether the flagged strings are examples or live credentials.
- **O-5 (drift):** Confirm the canonical pick for the 3 cross-agent drifts (`checkly`, `imagen`, `test-driven-development`); the other 10 mirror-drifts can auto-resolve to newest/largest.
- **O-6 (career-ops / AI_LABS):** Confirm LEAVE-and-catalog (recommended) for the upstream `career-ops` skills and the AI_LABS reference libraries.

---

## 9. Verification (this pass)

- **Nothing executed.** No skill script, binary, or installer was run. Only read-only enumeration, content hashing, frontmatter parsing, and a regex secret scan.
- **No secrets exposed.** Secret-bearing skills are reported by path and pattern type only; no values printed here or in the manifest.
- **Nothing moved, archived, relinked, or converted.** `baza-skills` still contains only `README.md` plus this report and the manifest. Source trees are untouched.
- **Counts reconcile:** 2,845 raw skill dirs to 1,444 distinct families; 1,385 exact-dup + 13 drift + 46 singleton families; 6 high-confidence secret paths across 3 distinct skills.

**STOP for approval.** Phase 4 (migrate) and Phase 5 (control files + changelog) will proceed only after you answer the open questions above, in particular O-2 (scope) and O-3 (format gate).
