# Held for review: database-schema-designer (2026-07-14)

Adopted by Kamilla's direction after she flagged the missing schema-design capability
(2026-07-14, camp workbook session). Extracted STANDALONE: none of the MCPmarket plugin
machinery (hooks, MCP server, sync scripts, token) travels with it.

- Skill: database-schema-designer (SKILL.md only; upstream assets/references/scripts
  folders contained placeholder READMEs, not adopted)
- Source: github.com/jeremylongshore/claude-code-plugins-plus-skills @ d3990fe4,
  backups/skills-migration-20251108-070147/plugins/database/database-schema-designer/
  skills/database-schema-designer/ (verified byte-identical, minus an mcpmarket-version
  frontmatter stamp, to the copy in mcpmarket-plugin-me.zip)
- Security review: Baza 00-POCHTA/AGENT_NOTES/Skill-Review-mcpmarket-plugin-me_Fable5_2026-07-14.md
  (cleared standalone: no shell, no network, no credentials, prompt guidance only)
- Known scope note: the skill is SQL/database oriented; Kamilla's use case extends to
  spreadsheet/workbook schemas (entities + surfaces). Extension or a companion skill is
  a candidate follow-up, her call.

Added by Fable 5 (Claude Code), 2026-07-14.
