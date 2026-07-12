# 00_README

This folder, `baza-skills`, is the single central home for Kamilla's agent skills.

## Why this folder exists
One physical home for every skill, deduplicated, so the same skill is never copied and drifted across many agent directories again. Git history is the anti-amnesia property: every change is a logged commit.

## What is here now
- `skills\` : 1461 canonical skills, one folder each, deduplicated from the original 2888 source directories plus later reviewed additions.
- `_held-for-review\` : intake batches pending review (from-CHERDAK-2026-07-06, from-kepano-obsidian-skills-2026-07-11). Note: the 3 secret-bearing skills flagged 2026-06-18 were reviewed 2026-07-12 and deleted, not retained (see CHANGELOG); they never physically lived in this folder.
- `01_INDEX_skills.md` : the folder dashboard and registry summary.
- `SKILLS_MANIFEST.xlsx`, `SKILLS_CONSOLIDATION_REPORT_2026-06-18.md`, `CHANGELOG.md` : provenance and audit trail.

## What belongs here
Authorable agent skills (a folder with a SKILL.md or equivalent manifest plus its resources), one canonical copy per skill.

## What does not belong here
Vendored reference libraries and framework samples (for example AI_LABS clones), plugin caches, and read-only installed-plugin skills. Those stay where they are and are cataloged once.

## Important notes
- Skills were COPIED here. Originals remain in place, so no agent lost access. Repointing agents to load from this library (Windows junctions) is a pending follow-up.
- `C:\Users\kamil\.claude\skills` (~102) is not yet included: it is a protected location that cannot be mounted from the assistant session.
- Authority: Global File Folder Creation Protocol (GLBL-PRTCL-027). No secrets in notes, names, or logs. No em dashes.

## Key links
- Charter: `README.md`
- Build report: `SKILLS_CONSOLIDATION_REPORT_2026-06-18.md`
