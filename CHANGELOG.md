# CHANGELOG

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
