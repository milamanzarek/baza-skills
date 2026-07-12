# TODO: agent pointers + retire originals (later)

Created 2026-06-18. This is the deferred follow-up to the skills consolidation. It is host-side work (Windows commands and edits) that should run on Kamilla's machine with review, not blind from an assistant session. Order matters: pointers and verification come BEFORE removing any original.

## Goal
Make `C:\Users\kamil\PROJECTS\baza-skills` the single physical home for skills, and make every agent load from it, so the same skill is never copied and drifted across agent directories again.

## Current state (done 2026-06-18)
- `baza-skills\skills\` contains 1,460 deduplicated canonical skills (copied in; originals left in place; no agent access removed).
- 3 secret-bearing skills were held out (not placed); RESOLVED 2026-07-12 - reviewed and deleted, not retained (see CHANGELOG).
- `C:\Users\kamil\.claude\skills` (~102) was NOT swept (protected location, could not be mounted).
- Repo is uncommitted (the mount was too slow for git in-session).

## Step 0: commit what is already in (quick, do first)
```
cd C:\Users\kamil\PROJECTS\baza-skills
del .git\index.lock
git add -A
git commit -m "Consolidate 1460 deduped skills into baza-skills"
```

## Step 1: bring in the two blocked / held inputs
1. Export `C:\Users\kamil\.claude\skills` to a non-protected folder (for example `C:\Users\kamil\PROJECTS\_claude-skills-export`), then ask the assistant to dedupe-and-fold it into `baza-skills\skills` (same copy-in + family-dedup as before).
2. DONE 2026-07-12: the 3 held skills (`comfyui-gateway`, `aws-iam-best-practices`, `k8s-manifest-generator`) were reviewed and deleted (not added); their sole copies in the CHERDAK skills_backup were removed.

## Step 2: create the agent pointers (the "agents' brains/configs" note)
Two mechanisms. Prefer config-repointing for skill dirs that live inside a git repo (a junction inside a tracked repo confuses git); use a junction for true home dirs.

Live agent skill paths to point at `baza-skills` (back up each first):
- `C:\Users\kamil\.claude\skills`        (home dir)  -> junction OR Claude config skills path
- `C:\Users\kamil\.gemini\skills`        (home dir)  -> junction
- `C:\Users\kamil\PROJECTS\CORE_OS\.claude\skills`   (in repo) -> config repoint preferred
- `C:\Users\kamil\PROJECTS\CORE_OS\.gemini\skills`   (in repo) -> config repoint preferred
- `C:\Users\kamil\PROJECTS\CORE_OS\.adk\skills`      (in repo) -> config repoint preferred
- `C:\Users\kamil\PROJECTS\CORE_OS\.agents\skills`   (in repo) -> config repoint preferred
- project homes (`road-trip ... \agent\skills`, `uftanma\Skills`, `Baza_Legacy\gemini-scribe\Skills`, `brand-os-kamilla\04_design-explorations`, `mistral-workflows\workflow-1\.agents`) -> decide per project whether they should resolve from baza-skills or stay local.

Junction example (run after backing up and emptying the target dir; junction target must not already exist):
```
ren  C:\Users\kamil\.gemini\skills  skills_old_2026-06-18
mklink /J  C:\Users\kamil\.gemini\skills  C:\Users\kamil\PROJECTS\baza-skills\skills
```
Config-repoint alternative (no junction): edit the agent's config so its skills directory points to `C:\Users\kamil\PROJECTS\baza-skills\skills`.

NOTE: if an agent only wants a subset (for example just Claude-format skills), point it at a curated subfolder or filtered view rather than the whole 1,460.

## Step 3: verify BEFORE removing anything
For each agent, confirm it lists/loads all its expected skills through the new pointer. Do not proceed to Step 4 for an agent until this passes.

## Step 4: retire the originals (only after Step 3 passes)
- Live-path originals (the `skills_old_*` backups from Step 2): remove once the junction/repoint is verified.
- CHERDAK is an archive, not a live agent path, so its skill copies can be retired independently. Per the brief: copy verified into baza-skills (done), then `git rm` from CHERDAK, commit both sides, and leave a `MIGRATED_TO_baza-skills.md` pointer in CHERDAK. Do not rewrite history.
- `career-ops` skills are upstream (third-party clone) and AI_LABS are vendored reference libraries: LEAVE in place, do not retire.

## Also queued (added 2026-06-18)
- **Create a Baza-level index of all skills.** A master index that lives in Baza (the control plane) and points to baza-skills, following the cascading-context / Fractal Language principle: high level first, then more granular. It should let a human or agent find a skill by drilling down (for example Marketing -> Strategic Marketing -> Frameworks -> STEPPS) in a token-efficient way. Likely realized as `01_INDEX_skills.md` at the top plus per-category `00_README` + `01_INDEX` surfaces as the tree deepens.
- **Categorize skills into a real taxonomy** beyond the current provenance tags (own/community/third-party). Build the cascading category tree and assign every skill a home in it. (Design questions are being worked through with Kamilla before building.)
- **Deeper (semantic) dedupe pass.** Exact-name and exact-content duplicates are already collapsed (1,460 canonical). A second pass can find same-purpose, differently-named skills (for example three different "code review" skills) and merge or cross-link them. Pending decision.

## Open decisions for Kamilla
- AI_LABS reference libraries (~355 vendored framework samples) were deliberately NOT transferred (they are upstream clones, not authored skills). Confirm leave-and-catalog, or say if you want any pulled in.
- Which project-home skills should resolve from baza-skills vs stay local to their project.
- Taxonomy structure, depth, and whether it aligns to existing Baza taxonomy codes (in progress).
