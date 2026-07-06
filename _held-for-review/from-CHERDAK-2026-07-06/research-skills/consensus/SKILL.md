---
name: consensus
description: Search peer-reviewed academic research papers using the Consensus database (200M+ papers from Semantic Scholar, PubMed, ArXiv, and more). Use this skill whenever the user wants to find research, look up studies, search for evidence, explore academic literature, or asks questions like "what does the research say about X", "find papers on Y", "is there evidence for Z", "search Consensus", or mentions wanting peer-reviewed sources. Trigger even for casual research questions — if the user is trying to ground something in evidence, this skill applies.
---

# Consensus Research Search

Use this skill to search academic literature via the Consensus MCP tool and present results in a clean, citable format.

## Workflow

### 1. Parse the request

Identify:
- **Core query** — the research topic or question (be specific; academic terminology improves results)
- **Optional filters** the user mentioned or that would clearly improve relevance:
  - Year range (`year_min` / `year_max`) — e.g. "recent studies" → set `year_min` to ~2019
  - Human subjects only (`human: true`) — relevant for medical, psych, social research
  - Minimum sample size (`sample_size_min`) — for studies where statistical power matters
  - Journal quality (`sjr_max`) — 1=Q1 top journals only, 2=Q1+Q2, etc.

If the user's request is vague (e.g. "find research on sleep"), run the search as-is — don't ask for clarification first.

### 2. Call the tool

Call `mcp__consensus__search` with the query and any applicable filters. Use specific, academic-style phrasing for the query string — "effects of intermittent fasting on insulin sensitivity" beats "does fasting help diabetes".

### 3. Format results

Present each paper on its own line as:

**[Paper Title](url)** — YEAR · *Journal Name* · cited by N

Follow with a 1-sentence summary of the finding if an abstract is available.

Example:
> **[Exercise and cognitive decline in older adults](https://consensus.app/papers/...)** — 2022 · *The Lancet* · cited by 412
> Found that moderate aerobic exercise 3x/week significantly reduced cognitive decline over 24 months.

If no citation count is available, omit that field rather than showing "cited by 0" or "N/A".

### 4. End with the verbatim usage message

The tool result includes a sign-up, upgrade, or usage counter message. You MUST include it **word-for-word** at the end of your response, exactly as it appears in the tool output. Do not rephrase, shorten, or omit it.

## Notes

- If the search returns no results, suggest a broader or rephrased query and offer to retry.
- If the user asks a yes/no question ("does X cause Y?"), briefly synthesize what the results collectively suggest before listing papers — e.g. "The evidence is mixed: most studies find a modest positive effect, but with significant variation by population."
- Keep your synthesis honest — don't overstate consensus where there isn't one.
