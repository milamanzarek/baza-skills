# Skills Taxonomy Proposal (for review)

- Date: 2026-06-18
- Scope: organize the 1,460 skills in `baza-skills\skills` into a cascading, Fractal-Language tree.
- Your four design choices (confirmed): nested folders with per-level control surfaces, a discipline-based skills-native spine, single canonical home per skill plus see-also cross-references, and a semantic-dedupe pass first.
- Status: PROPOSAL. Nothing has been reorganized yet. Approve or edit the spine below and I will build it.

## 1. The principle, applied

Each level of the tree is a doorway, not a dump. An agent or a human reads only the branch they are descending, so lookup stays intuitive and token-cheap. Every folder carries two tiny control surfaces per the Baza protocol:

- `00_README.md` : what this category is, what belongs here, what does not.
- `01_INDEX_[category].md` : the children (subcategories or skills) with one-line purposes, plus a short "see also" list pointing to cross-cutting skills that live elsewhere.

So the physical layout mirrors the cascade:
```
skills\
  marketing\
    00_README.md
    01_INDEX_marketing.md
    strategic-marketing\
      00_README.md
      01_INDEX_strategic-marketing.md
      frameworks\
        00_README.md
        01_INDEX_frameworks.md
        stepps-analysis\SKILL.md
        aida-funnel\SKILL.md
        ...
```

Your worked example resolves exactly as you described: **Marketing -> Strategic Marketing -> Frameworks -> stepps-analysis**. If she is unsure the skill exists, she reads three short indexes (about 3 small files) instead of scanning 1,460 names.

## 2. Proposed top-level spine (10 disciplines)

Indicative counts from a first automated pass over the 1,460 skills. Counts will shift as the unsorted tail and cross-cutting items are placed by hand.

| Discipline | Indicative count | What lives here |
|---|---|---|
| Engineering | ~480 | Languages & frameworks, Frontend & UI, APIs & integration, Cloud & DevOps, Databases, Testing & QA, Mobile, Game & graphics, WordPress & CMS, ERP (Odoo) |
| Data & AI | ~350 | AI / agent development, ML & data science, Data engineering |
| Marketing | ~100 | Strategic marketing & frameworks, SEO, Content & social, Growth/ads/campaigns |
| Security | ~85 | Security, hardening, pentest, audit, IAM |
| Writing & Communication | ~50 | Writing & editing, Docs & knowledge (ADRs, architecture docs) |
| Meta & Skill-Tooling | ~36 | Skill authoring & routing, Agent orchestration |
| Design | ~30 | Visual / UX / brand-creative design |
| Business & Operations | ~30 | Product & project mgmt, Finance/Legal/HR, Productivity & workflow |
| Personal & Lifestyle | ~12 | Health, fitness, travel, journaling, media/podcast |
| Sales & CRM | ~10 | Sales, CRM, lead-gen, outreach |

Plus a temporary `_unsorted\` holding ~284 skills the auto-pass could not confidently place; these get hand-filed during the build (many are non-English or oddly named, e.g. `advogado-criminal`, `00-andruia-consultant`).

Notes on the spine:
- It is built to fit what is actually in the folder, which is heavily engineering and AI weighted. Engineering and Data & AI together are about 57 percent of the library, so those two get the deepest sub-trees.
- Marketing is smaller but gets a real sub-tree (your STEPPS use case), as do Sales, Design, Writing, Business, Personal.
- `Meta & Skill-Tooling` is the home for skills that build or route other skills.

## 3. Second level (sub-categories), as proposed

```
Engineering\
  languages-and-frameworks\   frontend-and-ui\   apis-and-integration\
  cloud-and-devops\           databases\         testing-and-qa\
  mobile\                     game-and-graphics\ wordpress-and-cms\   erp-odoo\
Data-and-AI\
  ai-agent-development\       ml-and-data-science\   data-engineering\
Marketing\
  strategic-marketing\ (-> frameworks\, positioning\, research\)
  seo\                 content-and-social\        growth-ads-campaigns\
Security\           (hardening\, appsec\, cloud-security\, offensive\)
Writing-and-Communication\   (writing-and-editing\, docs-and-knowledge\)
Design\                      (ui-ux\, brand-and-creative\)
Business-and-Operations\     (product-and-project\, finance-legal-hr\, productivity-and-workflow\)
Sales-and-CRM\
Personal-and-Lifestyle\
Meta-and-Skill-Tooling\      (skill-authoring\, agent-orchestration\)
```
Third level (like `frameworks\`) is added only where a category is big enough to warrant it, so depth stays adaptive, not forced.

## 4. Cross-cutting skills (single home + see-also)

A skill like `ai-security-testing` touches AI, Security, and Testing. Per your choice it gets ONE canonical home (the dominant intent, here Security), and the other relevant indexes list it under "see also" with a relative pointer. No skill is physically duplicated. The `01_INDEX` see-also lines are how findability is preserved without breaking the one-home rule.

## 5. Semantic dedupe findings (your review needed)

The pass found **150 candidate near-duplicate pairs**; full list in `semantic_dedupe_candidates.csv`. Important: most are NOT true duplicates, they are legitimate variants and should be KEPT separate:
- Language variants: `azure-cosmos-py` vs `azure-cosmos-rust`, `dbos-python` vs `dbos-typescript`.
- Format variants: `docx-official` vs `pptx-official`.
- App variants: `google-sheets-automation` vs `google-slides-automation` vs `google-drive-automation`.

A smaller set look like genuine merge candidates worth your eye, for example:
- `error-debugging-error-analysis` vs `error-diagnostics-error-analysis`
- `code-refactoring-refactor-clean` vs `codebase-cleanup-refactor-clean`
- `code-documentation-doc-generate` vs `documentation-generation-doc-generate`
- `brand-guidelines-anthropic` vs `brand-guidelines-community`

Proposal: I do NOT auto-merge anything. I will hand you a short reviewed shortlist of likely-true-duplicates (maybe 15 to 30 pairs) with a recommended keep/merge per pair; you approve, then I merge those and archive the losers before categorizing. Variants stay as distinct skills, often sitting side by side in the same leaf folder.

## 6. What I need from you

1. Approve the 10-discipline spine, or adjust it (rename, split, merge, reorder).
2. Confirm depth: add a third level only where a category exceeds, say, ~15 skills? Or a different threshold.
3. Confirm I should produce the reviewed dedupe shortlist next (before building the tree).
4. Once approved: I build the nested folders, write every `00_README` + `01_INDEX`, place all 1,460 (copy-move within `baza-skills`), hand-file the ~284 unsorted, and add the top-level master index. This is a re-org inside `baza-skills` only; originals outside it stay untouched, and agent pointers remain the separate later step.

Companion files: `semantic_dedupe_candidates.csv` (all 150 pairs), `taxonomy_assign.json` (the first-pass auto-assignment for transparency).
