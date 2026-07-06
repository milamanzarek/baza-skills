# 01_INDEX_skills

Folder dashboard for `baza-skills\skills`. Generated 2026-06-18.

## Folder map

- `skills\` : the central deduplicated library, one folder per skill (canonical copy).
- `_held-for-review\` : skills withheld pending Kamilla review (secrets). Not yet placed.
- `SKILLS_MANIFEST.xlsx` : full row-level inventory, family map, drift, secrets, provenance.
- `SKILLS_CONSOLIDATION_REPORT_2026-06-18.md` : how this library was built.
- `CHANGELOG.md` : every consolidation action.

## Registry summary

- Skills placed (deduplicated, one canonical per family): **1460**
- Skills held for review (secret-bearing): **3**

| Provenance | Count | Meaning |
|---|---|---|
| own | 80 | Marked personal/self/original in frontmatter (Kamilla's authored). |
| unmarked | 82 | No source field; provenance unknown, review suggested. |
| community | 1106 | Marked source: community (collected). |
| third-party | 192 | Source is an external repo/vendor URL (often licensed). |

Provenance per skill is in `SKILLS_MANIFEST.xlsx` (Inventory sheet, `prov` column). Use it to prune.

## Open questions

- `C:\Users\kamil\.claude\skills` (~102) could NOT be included: it is a protected host location that cannot be mounted. To fold it in, copy it to a non-protected folder and tell me.
- 3 secret-bearing skills are held in `_held-for-review`: review before adding.
- Agent access not yet repointed: agents still load from their original paths. Junctions/repointing into this library is a follow-up.
- Community and third-party skills are intentionally included (confirmed by Kamilla 2026-06-18); they are kept, not pruned. The `prov` column in the manifest is for reference and filtering, not a cleanup list.

## Own-authored skills placed (80)

`00-andruia-consultant`, `10-andruia-skill-smith`, `20-andruia-niche-intelligence`, `ai-agent-development`, `ai-ml`, `angular`, `angular-best-practices`, `angular-state-management`, `angular-ui-patterns`, `antigravity-workflows`, `api-documentation`, `api-security-testing`, `base`, `bash-scripting`, `calc`, `cloud-devops`, `database`, `ddd-context-mapping`, `ddd-strategic-design`, `ddd-tactical-patterns`, `development`, `diary`, `documentation`, `domain-driven-design`, `dotnet-backend`, `draw`, `e2e-testing`, `explain-like-socrates`, `grpc-golang`, `impress`, `indexing-issue-auditor`, `keyword-extractor`, `kubernetes-deployment`, `linkedin-profile-optimizer`, `linux-troubleshooting`, `local-legal-seo-audit`, `odoo-accounting-setup`, `odoo-automated-tests`, `odoo-backup-strategy`, `odoo-docker-deployment`, `odoo-ecommerce-configurator`, `odoo-hr-payroll-setup`, `odoo-inventory-optimizer`, `odoo-manufacturing-advisor`, `odoo-migration-helper`, `odoo-module-developer`, `odoo-orm-expert`, `odoo-performance-tuner`, `odoo-project-timesheet`, `odoo-purchase-workflow`, `odoo-qweb-templates`, `odoo-rpc-api`, `odoo-sales-crm-expert`, `odoo-security-rules`, `odoo-upgrade-advisor`, `odoo-xml-views-builder`, `office-productivity`, `os-scripting`, `postgresql-optimization`, `professional-proofreader`, `python-fastapi-development`, `python-pptx-generator`, `radix-ui-design-system`, `rag-implementation`, `react-nextjs-development`, `security-audit`, `seo-forensic-incident-response`, `skill-router`, `stitch-ui-design`, `temporal-golang-pro`, `terraform-infrastructure`, `testing-qa`, `unreal-engine-cpp-pro`, `vibe-code-auditor`, `web-security-testing`, `wordpress`, `wordpress-plugin-development`, `wordpress-theme-development`, `wordpress-woocommerce-development`, `writer`
