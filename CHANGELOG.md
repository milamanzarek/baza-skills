# CHANGELOG

## 2026-07-14 Add advisor-orchestrator-worker (first security-reviewed install) + first agent-access junction
- Added `skills/advisor-orchestrator-worker/` (5 files: SKILL.md, README.md, references/x3). Provenance: third-party, github.com/Shubhamsaboo/awesome-llm-apps @ 6ce858f (2026-07-13), Apache-2.0, manual copy (no npx installer).
- First skill to enter through the full pipeline: Skill Install Security Review SOP pass (2026-07-14, Baza: `00-POCHTA/AGENT_NOTES/DRAFT-Skill-Security-Review-Advisor-Orchestrator-Worker_Fable5_2026-07-14.md`) + Tool Triage SOP section 8 graduation gates. Kamilla approved install and placement 2026-07-14.
- LOCAL EDIT: Baza guard header added to SKILL.md (workers default to tool-less API fallback; `agy --dangerously-skip-permissions` requires Kamilla's per-session approval; no secrets in briefs). Provisional pending her Gate 3 ruling. Re-scanned after edit per SOP step 6.
- Created the library's FIRST agent-access junction (the "agent access repointing (junctions)" item pending since 2026-06-18): `C:\Users\kamil\.claude\skills\advisor-orchestrator-worker` -> this folder. One canonical copy; Claude Code loads through the junction. Pattern note: per-skill junctions on adoption only, never a bulk library link (would make `_held-for-review` and unreviewed skills live, bypassing the security review SOP).
- Repo-side evals from the source repo deliberately NOT copied (upstream convention: "you install only what runs").

## 2026-06-18 Initial consolidation (copy-in)
- Inventoried 2,888 skill directories across accessible sources (PROJECTS + ~/.gemini/skills).
- Deduplicated to 1,463 distinct families.
- Placed 1460 canonical skills into `skills\` (one per family). Originals left in place (additive copy, no agent access removed).
- Held 3 secret-bearing skills out of the library pending review: comfyui-gateway, aws-iam-best-practices, k8s-manifest-generator.
- Could not include ~/.claude/skills (~102): protected host location, not mountable.
- Did NOT convert any skill format. Did NOT remove any original. Did NOT execute any skill script.
- Pending: agent access repointing (junctions), .claude/skills inclusion, provenance-based pruning of community/generated skills.

## 2026-06-18 Fill missing descriptions
- Wrote real `description:` trigger lines for 20 skills that carried the placeholder "One sentence..." (the conversion-psychology suite). Bodies unchanged; only the empty metadata field filled. 0 placeholder descriptions remain in the library.

## 2026-06-18 Merge 9 duplicate skills
- Verified 9 approved duplicate pairs; archived the non-canonical copy of each to _archive/superseded-skills-2026-06-18/ (never deleted).
- 7 are clean (loser had no unique content; in 2 cases the keeper was the richer copy).
- 2 had real drift (error-diagnostics-error-trace, codebase-cleanup-refactor-clean): canonical kept, drifted copy archived, FLAGGED for optional capability-merge.
- Loser removal from skills/ is pending host-side (mount blocks deletion): see MERGE_REMOVALS_2026-06-18.md.

- 2026-07-06 — First full content commit (library was untracked since founding). CHERDAK intake added under _held-for-review/from-CHERDAK-2026-07-06/ (gsd Codex port ×65, 4 variants to reconcile, 3 skill groups + manifest). By Claude Code (Fable 5), Kamilla ruling: all skills live here.

- 2026-07-11: Adopted kepano/obsidian-skills (5 skills: obsidian-bases, json-canvas, obsidian-markdown, obsidian-cli, defuddle). Cloned from https://github.com/kepano/obsidian-skills (MIT), copied minus .git into `_held-for-review/from-kepano-obsidian-skills-2026-07-11/` pending review (same intake pattern as the CHERDAK batch). Provenance corrected against the source: kepano is Steph Ango (Obsidian CEO), but this is his personal open-source project, NOT an official Obsidian org product. Reason for adoption: obsidian-bases to author the Baza Backlog (B.B.) as a `.base` record set; json-canvas and obsidian-markdown cover Baza's own canvas and markdown formats (recurring agent drift sources). Baza has no skill registry yet, so pointers and agent-repointing (junctions) are deferred per Kamilla ("we bring the skill pointers back when ready"). Transient download clone left at `C:/Users/kamil/PROJECTS/obsidian-skills` (source; keep-or-remove is Kamilla's call). By Claude Code (Opus 4.8), with Kamilla. No secrets.

## 2026-07-11 Add list-miro-boards
- Added the own-authored `list-miro-boards` skill as the canonical copy under `skills\`. Added a directory symbolic link at `C:\Users\kamil\.codex\skills\list-miro-boards` for Codex discovery without duplication. The skill calls the existing local Miro helper read-only, keeps credentials in Windows Credential Manager, and was validated with the Codex skill validator. By Codex, with Kamilla. No secrets.

## 2026-07-12 Resolve the 3 held secret-bearing skills (deleted) + retire CHERDAK skills_backup
- The 3 skills withheld 2026-06-18 as secret-bearing (`comfyui-gateway`, `aws-iam-best-practices`, `k8s-manifest-generator`) were reviewed with Kamilla. She did not recognize them and chose delete over retain. None entered the library.
- Their sole copies lived only in `C:\Users\kamil\PROJECTS\CHERDAK\antigravity-agents\skills_backup`; they were never physically placed in `_held-for-review\` despite earlier notes. Corrected `00_README.md`, `01_INDEX_skills.md`, `_held-for-review\00_README.md`, and `TODO_agent-pointers_2026-06-18.md` to match reality.
- Duplicate check first: of the 1,394 `skills_backup` folders, 1,386 were already canonical here (name match); the rest were wrappers/artifacts (`libreoffice`, `security` groupers over already-present skills; `agents_skills_backup`, `build`, `docs`, `full_library`). Only the 3 above were unique. Nothing needed adding.
- Kamilla deleted the full CHERDAK `antigravity-agents` folder (`skills_backup` plus a disconnected copy of the agency-agents persona notes), since all skill content was already canonical here. The "relocate CHERDAK skills to baza-skills" job closes as: nothing to relocate.
- By Claude Code (Opus 4.8), with Kamilla. No secrets printed.
