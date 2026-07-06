name: brand-strategy
description: >
  Generates a complete brand positioning framework for a client or brand. Use this skill immediately
  whenever the user says "develop brand positioning for [X]", "build a brand strategy for [X]",
  "create a positioning framework", "help me position [brand/product/company]", "what should our
  brand stand for", "define our ICP", "we need messaging pillars", or any request involving brand
  strategy, value proposition, competitive differentiation, brand voice, or target audience
  definition. Also trigger when a user shares a brand brief, client intake notes, or asks for a
  one-pager summary of a brand's strategic positioning. Works for B2B and B2C brands equally.
  Always use this skill for any multi-faceted brand or messaging work.
---

# Brand Strategy OS

Two modes. Same quality standard. Choose based on what the client needs.

| Mode | When to use | Output |
|---|---|---|
| **Quick Positioning** | Internal alignment, early-stage brand, lightweight brief | 7-section Markdown framework |
| **Full OS** | Client deliverable, established brand, full engagement | 14 sections + CSV + SVG lockups + HTML file |

If the user doesn't specify, ask one question:
> "Is this for a quick internal positioning framework, or a full client deliverable with logo brief and HTML presentation?"

---

## QUICK POSITIONING MODE

A structured, opinionated framework. Consultant-grade output — not generic, not templated-sounding.

### Step 1: Intake

Work with whatever the user provides. Don't force a format.

- **Brief, notes, deck, or raw context provided**: extract directly. Do not ask them to re-enter information.
- **Brand name and little else**: make reasonable inferences on competitive landscape and category conventions, clearly label inferred vs. stated, ask only for critical gaps (★).
- **Nothing useful**: ask all critical questions in a single message grouped by section — never one at a time.

**Critical inputs (★ — must have before generating)**
- What the brand does, in plain language (not marketing copy)
- B2B or B2C (or both)?
- Who is the target customer (rough is fine)
- 2–4 direct competitors
- The #1 business goal this positioning needs to support

**Helpful but optional**
- Brand stage (pre-launch / early / scaling / mature)
- Geographic scope
- Current tagline or messaging (even if broken)
- Tone words the brand aspires to
- Who is explicitly NOT the customer

### Step 2: Input Quality Check (Opinionated Mode)

Before generating, flag and push back on:

- **Vague differentiators**: "customer-focused" or "great quality" — call it out. Ask: "What specifically makes that true, and why can't a competitor say the same thing?"
- **Undefined audiences**: "small businesses" or "professionals" is not an ICP. Ask for specifics.
- **Overcrowded positioning**: more than 2–3 distinct owned things = dilution risk. Flag it.
- **Aspirational ≠ credible**: if desired positioning doesn't match current reality, surface the tension. Offer to build toward it vs. claim it now.

State flags clearly and concisely. Offer to proceed with caveats rather than blocking.

### Step 3: Generate the Framework

Output all seven sections. Each must be specific to the brand — no generic filler.
If a section can't be completed due to missing info, say so rather than hallucinating.

For format: see `references/output-format.md`
For ICP construction logic (B2B vs B2C): see `references/icp-logic.md`

#### 1. Ideal Customer Profile (ICP)
- Apply B2B or B2C logic from `references/icp-logic.md`
- Primary ICP: full profile
- Secondary ICP (if applicable): abbreviated
- Anti-ICP: who to avoid and why

#### 2. Core Value Proposition
- One-sentence value prop ("we help X do Y so they can Z" structure)
- 3 supporting proof points (specific, not generic)
- The "so what" test: why each proof point matters to the ICP

#### 3. Differentiation & Competitive Positioning
- Positioning map: where the brand sits vs. named competitors on 2 key axes (describe in text; choose axes based on the actual landscape)
- Owned whitespace: what no competitor is claiming that this brand can credibly own
- Borrowed credibility: what the brand can borrow from adjacent categories or proof sources

#### 4. Messaging Pillars (3–5)
- Each pillar = a strategic theme communicated consistently
- Per pillar: **Pillar name** (2–4 words) · one-line definition · example message · proof point or reason to believe

#### 5. Brand Voice & Tone
- 3 voice attributes with do/don't examples each
- Tone spectrum: how voice shifts across contexts (ads vs. support vs. exec comms)
- Words/phrases to use and avoid

#### 6. Tagline / Positioning Statement Options
- 3 positioning statement options (full "for X who Y, Brand Z is the A that B" format)
- 3–5 tagline directions (short, punchy, distinct from each other)
- Flag which options are aspirational vs. currently credible

#### 7. One-Page Summary
- Executive-ready synthesis: ICP snapshot, value prop, 3 pillars, positioning statement, voice in 3 words
- Suitable for client presentation or internal alignment doc

### Step 4: Deliver Output

Output all 7 sections sequentially in structured Markdown with a summary table at the top.
See `references/output-format.md` for Markdown structure and formatting conventions.

### Step 5: Iteration Protocol

After delivering:
1. Ask: "Which section needs the most refinement, or should we pressure-test any positioning claims?"
2. Offer to go deeper on any section (full brand voice guide, expanded ICP research questions, competitive battle cards)
3. If testing messaging: offer to draft sample copy (email, homepage hero, elevator pitch) using the framework as a brief

### Quality Standards
- Every claim traceable to a brand input — no invented facts
- Differentiation must be real, not aspirational, unless explicitly framed as a growth direction
- Messaging pillars must not overlap — if two say the same thing differently, merge them
- ICP must be specific enough that a salesperson could use it to qualify a lead
- Taglines must pass the "could a competitor say this?" test — if yes, reject and regenerate

---

## FULL OS MODE (4-Prompt Chain)

A modular chain that produces a complete client-ready deliverable: 14 strategy sections,
CSV export, SVG logo lockups, and a self-contained HTML presentation.

Full prompt text for all 4 phases: `references/master-prompts.md`
Platform calibration + troubleshooting: `references/platform-notes.md`

### Workflow

```
P0: INTAKE PARSER       → Clean 11-section structured brief (any input format)
P1: STRATEGY FOUNDATION → 14 sections as 3-column tables + CSV export
P2: LOGO BRIEF          → SVG lockups (8 total) + designer handoff checklist
P3: HTML PRESENTATION   → Self-contained client-ready .html file
```

### Step 1: Identify Entry Point

| User provides | Enter at |
|---|---|
| Raw intake (transcript, form, brain dump, files) | **P0** |
| "Generate the strategy" + clean brief in hand | **P1** |
| "Brief the designer" + Sections 6 & 7 ready | **P2** |
| "Build the deliverable" + all 14 sections ready | **P3** |
| `New Client [Name]` command | **P0** |
| Existing brand, needs packaging only | **P1** (preserve hex/fonts; add rationale + system rules) |

### Step 2: Execute the Phase

Read `references/master-prompts.md` and run the prompt for the current phase.

**P0 — Intake Parser**
- Accept any format: transcript, PDF, form, email, voice notes, deck, spreadsheet
- Output: 11 sections exactly as specified. Do NOT generate strategy yet.
- Flag missing data in Section 11 (Gaps) — do not invent what isn't there
- State what was found in each attached file before parsing

**P1 — Strategy Foundation**
- Input: clean brief from P0 (paste in full)
- Output: all 14 sections as 3-column Markdown tables + CSV
- Every section must be completed; use ⚠️ INFERRED if data is missing
- Evidence citations **mandatory** for Section 5 (Brand Tension) and Section 12 (Voice Sliders)
  Format: *(Evidence: "[quote from intake]")*
- Truncation risk: if context limit is a concern, split into P1a (Sections 1–7) and P1b (Sections 8–14 + CSV)
- Always end with: "Do not truncate the CSV. Include every row."

**P2 — Logo Brief**
- Input: Sections 6 & 7 from P1 + any uploaded logo files
- Output: 5 parts — Conceptual Direction, Color + Typography, Config Rules, 8 SVG Lockups, Handoff Checklist
- SVG lockups: 4 configs × 2 schemes = 8 total; use exact brand hex codes as fills
- If logo uploaded: describe every visible element before generating; note what to preserve vs. evolve
- Established brands: do NOT change hex codes or fonts — add rationale and missing system rules only

**P3 — HTML Presentation**
- Input: all 14 sections + Logo Brief from P2
- Run in: Antigravity (preferred), VS Code, or canvas session
- Output: single self-contained `.html` file
- Page order: Preface → About → TOC → Sections 1–14 → CSV Appendix
- Control bar (fixed, bottom-right): Edit · Theme · ↓PNG · ↓PDF · ↓HTML
- Theming: use brand hex values — never generic blues, Inter, or system font defaults
- See `references/master-prompts.md` for full technical spec and required CDNs

### Core Principles (Full OS)
- **Context Preservation**: every decision grounded in client intake quotes — not invented
- **Field Guide Philosophy**: an operational compass for daily decisions, not a marketing doc
- **Established Brands**: package what exists. Add rationale, SVG system, digital rules. Never override existing hex or fonts.
- **Evidence Over Assertion**: Voice Slider scores and Brand Tension claims without citations are invalid
- **Portability**: all outputs must be ready for Antigravity / VS Code / Node.js rendering

### Output Quality Checklist (Full OS)
- [ ] All 14 sections present — nothing skipped
- [ ] 3-column table format used throughout P1
- [ ] Evidence citations present for Section 5 and Section 12
- [ ] ⚠️ INFERRED flags on any best-guess entries
- [ ] CSV: all rows included, values double-quoted, no line breaks within cells
- [ ] SVGs: 8 total (4 configs × 2 schemes), brand hex fills, placeholder comment labels
- [ ] HTML: opens without errors, all 3 themes functional, export buttons working
- [ ] No PII, API keys, or passwords in any output

### Commands

| Command | Action |
|---|---|
| `New Client [Name]` | Begin P0 with provided files |
| `Generate Strategy` | Execute P1 (requires P0 output) |
| `Brief Designer` | Execute P2 (requires Sections 6 & 7) |
| `Build Deliverable` | Execute P3 (requires all 14 sections + Logo Brief) |
| `Rerun Section [N]` | Regenerate only that section from P1 |
| `Rerun CSV` | Regenerate only the CSV export |