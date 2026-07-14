# 01_INDEX_skills

Folder dashboard for `baza-skills\skills`. Generated 2026-06-18.

## Folder map

- `skills\` : the central deduplicated library, one folder per skill (canonical copy).
- `_held-for-review\` : intake batches pending Kamilla review (from-CHERDAK-2026-07-06, from-kepano-obsidian-skills-2026-07-11).
- `SKILLS_MANIFEST.xlsx` : original consolidation baseline inventory, family map, drift, secrets, and provenance. Later additions are recorded in `CHANGELOG.md`.
- `SKILLS_CONSOLIDATION_REPORT_2026-06-18.md` : how this library was built.
- `CHANGELOG.md` : every consolidation action.

## Registry summary

- Skills placed (deduplicated, one canonical per family): **1462** (+1 on 2026-07-14, advisor-orchestrator-worker, first security-reviewed install; see CHANGELOG)
- Skills held for review (secret-bearing): **0** (the 3 flagged 2026-06-18 were reviewed 2026-07-12 and deleted, not retained)

| Provenance | Count | Meaning |
|---|---|---|
| own | 81 | Marked personal/self/original in frontmatter (Kamilla's authored). |
| unmarked | 82 | No source field; provenance unknown, review suggested. |
| community | 1106 | Marked source: community (collected). |
| third-party | 192 | Source is an external repo/vendor URL (often licensed). |

Baseline provenance is in `SKILLS_MANIFEST.xlsx` (Inventory sheet, `prov` column); later additions are attributed in `CHANGELOG.md`. Use both when reviewing provenance.

## Open questions

- `C:\Users\kamil\.claude\skills` (~102) could NOT be included: it is a protected host location that cannot be mounted. To fold it in, copy it to a non-protected folder and tell me.
- RESOLVED 2026-07-12: the 3 secret-bearing skills flagged 2026-06-18 were reviewed and deleted (Kamilla did not recognize them; their sole copies were in the CHERDAK skills_backup, now removed).
- Agent access not yet repointed: agents still load from their original paths. Junctions/repointing into this library is a follow-up.
- Community and third-party skills are intentionally included (confirmed by Kamilla 2026-06-18); they are kept, not pruned. The `prov` column in the manifest is for reference and filtering, not a cleanup list.

## Own-authored skills placed (81)

`00-andruia-consultant`, `10-andruia-skill-smith`, `20-andruia-niche-intelligence`, `ai-agent-development`, `ai-ml`, `angular`, `angular-best-practices`, `angular-state-management`, `angular-ui-patterns`, `antigravity-workflows`, `api-documentation`, `api-security-testing`, `base`, `bash-scripting`, `calc`, `cloud-devops`, `database`, `ddd-context-mapping`, `ddd-strategic-design`, `ddd-tactical-patterns`, `development`, `diary`, `documentation`, `domain-driven-design`, `dotnet-backend`, `draw`, `e2e-testing`, `explain-like-socrates`, `grpc-golang`, `impress`, `indexing-issue-auditor`, `keyword-extractor`, `kubernetes-deployment`, `linkedin-profile-optimizer`, `linux-troubleshooting`, `local-legal-seo-audit`, `odoo-accounting-setup`, `odoo-automated-tests`, `odoo-backup-strategy`, `odoo-docker-deployment`, `odoo-ecommerce-configurator`, `odoo-hr-payroll-setup`, `odoo-inventory-optimizer`, `odoo-manufacturing-advisor`, `odoo-migration-helper`, `odoo-module-developer`, `odoo-orm-expert`, `odoo-performance-tuner`, `odoo-project-timesheet`, `odoo-purchase-workflow`, `odoo-qweb-templates`, `odoo-rpc-api`, `odoo-sales-crm-expert`, `odoo-security-rules`, `odoo-upgrade-advisor`, `odoo-xml-views-builder`, `office-productivity`, `os-scripting`, `postgresql-optimization`, `professional-proofreader`, `python-fastapi-development`, `python-pptx-generator`, `radix-ui-design-system`, `rag-implementation`, `react-nextjs-development`, `security-audit`, `seo-forensic-incident-response`, `skill-router`, `stitch-ui-design`, `temporal-golang-pro`, `terraform-infrastructure`, `testing-qa`, `unreal-engine-cpp-pro`, `vibe-code-auditor`, `web-security-testing`, `wordpress`, `wordpress-plugin-development`, `wordpress-theme-development`, `wordpress-woocommerce-development`, `writer`

Added 2026-07-11: `list-miro-boards`.
