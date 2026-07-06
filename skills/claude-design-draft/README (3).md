# Kamilla Gafurzianova — Neural Design System

A brand + interface design system for **Kamilla Gafurzianova** — **AI Implementation
Consultant & Olympic Silver Medalist**. A cross-domain generalist who turns scattered
tools, teams, and tactics into systems that actually fire together.

> **One-line positioning:** *Olympic-grade discipline applied to AI implementation —
> integrating people, process, and platforms across every domain a business touches.*

The defining idea of the brand is **integration**. Kamilla is strongest where domains
meet — AI, BizOps, Marketing, Community, Sport, and Education — so the entire visual
language is an **interconnected digital brain**: nodes (ideas, tools, people) lit up in
deep purple space, synapses firing, data flowing between them. Depth, luminance, and
cross-connection are the whole point.

---

## Sources

- **`uploads/3d-quantum-neural-network.html`** — the original WebGL neural-network concept
  piece (Three.js) that established the brand visual. The screenshots in the brief come
  from this. We reinterpret it as a lightweight, on-brand 2D canvas (`assets/neural-field.js`)
  so colours are controllable and performance is high.
- **`professional-developer-portfoliomodern-interactive-cv/`** (local, read-only) — a generic
  code-themed interactive-CV template (CodePen "qEZzbom" by Kan3an: HTML/CSS/JS, Anime.js,
  Tailwind CDN, Font Awesome). Used **only** as the *structural skeleton* for the interactive
  CV (section order, timeline, skills, projects, contact). It is not Kamilla's brand — all of
  its developer copy, `< Dev />` logo, and code-block styling are replaced with the neural
  identity and Kamilla's real positioning.
- The brief itself (positioning, the PPPP framework, the palette, and Kamilla's hard "no" list).

A previous version of this project reverse-engineered a *light, beige, document-grade* system
from a different codebase (`k-portfolio`). That direction has been **superseded**: it survives
only as the secondary **Document** theme for long-form reading and the **Print** theme for PDF.

---

## Surfaces / products

1. **Interactive CV / portfolio** — the flagship. Live neural hero, identity, the PPPP
   operating framework, cross-domain skill matrix, experience timeline, selected work, and
   contact. *(UI kit: `ui_kits/portfolio-site/`)*
2. **PPPP framework explainer** — a focused surface that teaches Kamilla's signature
   method as a connected neural diagram. *(UI kit: `ui_kits/pppp-framework/`)*

---

## The PPPP framework (signature method)

Kamilla's repeatable operating method. Four visible P's, plus a hidden fifth that binds them.

| P | Meaning | Role | Hue token |
|---|---|---|---|
| **Past** | What already happened — history, data, prior art, audits. | Evidence | `--p-past` (violet) |
| **Present** | What is true now — the live state, constraints, reality. | Diagnosis | `--p-present` (magenta) |
| **Possible** | What could be — options, futures, the design space. | Imagination | `--p-possible` (lilac) |
| **Practice** | Repeated, deliberate action that compounds. | Execution | `--p-practice` (amber) |
| **Protocol** *(hidden 5th P)* | The connective layer — Process/Protocol that standardizes & reinforces *anything*. | Integration | `--p-protocol` (warm peach) |

Visually, the four P's are **four nodes in the neural network**; **Protocol is the synapse
layer** that connects and standardizes them — it is the warm-peach "ignition" running through
everything. Represent PPPP with the `.pbadge--*` badge family and/or a node-and-synapse diagram.

---

## Theme governance

The system is **dark-first** — the neural identity *is* the brand.

| Theme | Class | Status | Use |
|---|---|---|---|
| **Neural** | `theme-neural` | ✅ Primary (default) | All digital/brand surfaces. Deep purple void, glowing nodes, glass, depth. |
| **Document** | `theme-document` | ✅ Secondary | Long-form reading, dense proposals, web copy where a calm light field reads better. Warm light, same accents. |
| **Print** | `theme-print` | ✅ Print/PDF | High-contrast grayscale, no motion/glow. |

Default to **Neural**. Document/Print exist for accessibility and export, and inherit the same
tokens — never invent off-system colors when switching themes.

---

## CONTENT FUNDAMENTALS

**Voice.** First-person, confident, integrative. Kamilla writes as "I" to the reader's
"you / your business." The register is an elite athlete who became a systems thinker:
disciplined, calm, evidence-led — never hype.

- *Signature line:* "I integrate AI into how teams actually work — connecting the tools,
  people, and processes that usually sit in separate rooms."
- *Athletic throughline:* Olympic discipline → operational rigor. The medal is proof of a
  *method*, not a trophy to wave.

**Tone.** Precise and connective. The recurring rhetorical move is **integration**: this
domain + that domain → a system. Favor "and" over "or." Show how parts connect.

**Casing.**
- Headings: **sentence case**, display font. No ALL-CAPS headlines.
- Kickers / eyebrows / chips / buttons / labels / node tags: **UPPERCASE**, letter-spaced
  (mono). These are the "circuit labels" of the system.
- Body: sentence case, left-aligned. Center only a single closing footer note.

**Naming.** "Kamilla Gafurzianova" — full name. Title: **AI Implementation Consultant**;
secondary descriptor: **Olympic Silver Medalist**. When both appear, AI consultant leads.

**Vocabulary.** integrate · connect · system · implementation · node · synapse · cross-domain ·
framework · protocol · discipline · compounding · signal. Domains are tagged: **AI, BizOps,
Marketing, Community, Sport, Education**. The framework is **PPPP** (Past · Present · Possible ·
Practice, + Protocol).

**Emoji.** Not used. Iconography carries meaning instead (see ICONOGRAPHY).

**Numbers.** Pair metrics with context; avoid decorative/unsourced stats ("data slop"). Big
numbers render in the display font, magenta or lilac, with a mono label beneath.

---

## VISUAL FOUNDATIONS

**Overall feel.** A luminous, dimensional, deep-space neural network. Calm and premium, not
loud — but never flat. Think *observatory* meets *operating system*: dark, high-contrast,
glowing nodes connected by living synapses. Every surface should feel like it sits in 3D space.

**Kamilla's three hard NO's (non-negotiable):**
1. **No pill shapes.** Rounded corners are fine; fully-round capsules are banned. There is no
   `--radius-pill` token. Buttons/chips/tags use `--radius-sm`/`--radius-md` rectangles.
2. **No flat / dull surfaces.** Depth is mandatory — layered glow, glass with backdrop-blur,
   soft 3D shadows, luminance gradients, node-glow. If a surface looks flat, it's wrong.
3. **No low contrast.** Accessibility is first-class (Kamilla works with people with
   disabilities). Text/surface pairs target WCAG AA (4.5:1)+. Muted text never drops below AA.

**Color.**
- **Surfaces:** a deep purple-black void (`--bg-color #0d0719`), layered up through
  `--bg-raised`/`--bg-elevated` and aubergine "nebula" glows (`--nebula-1/2`) for depth.
- **Ink:** pale washed-out pink (`--text-primary #f8eefc`, "barely distinguishable from
  white"), with lilac-tinted secondary and an AA-safe muted.
- **Accents (one family, purple→magenta→lilac):** orchid-magenta `--accent-primary #ce43da`
  (primary action / key numbers), lilac `--accent-secondary #c9a7e8` (links, soft accents —
  Kamilla's childhood flower), muted violet `--accent-violet #924bb2` (connector mid-tone).
- **The single spark:** one warm-peach **ignition node** `--spark #ff9e5e` — the rare
  highlight (and Protocol's hue; warmth = ignition, where icy blue read cold). Use sparingly:
  one spark per composition.
- **Domains:** six bright-on-dark tags (AI violet, BizOps amber, Marketing pink, Community
  green, Sport periwinkle, Education lavender), shared chroma/lightness, varied hue.
- **Status (brand-harmonized — no fire-red or yellow):** success jade `#4fc2a1`, warning
  dusty-apricot `#e6a06a`, danger raspberry-rose `#d65b86` — luminous, AA on dark.

**Type.** Three families. **Space Grotesk** (display — headings, wordmark, big numbers; modern,
geometric, a touch of character). **Source Sans 3** (body & UI; highly legible). **JetBrains
Mono** (data, labels, kickers, code, node tags — the "circuit" voice). Bold weight is used for
H1/display and key numbers; otherwise semibold/medium.

**Backgrounds.** The signature is the **neural field** (`assets/neural-field.js`) — a live
canvas of drifting nodes + firing synapses behind heroes and section dividers, sitting on a
radial nebula gradient (`radial-gradient(...--nebula-1, --bg-color, --void)`). Static surfaces
use the nebula gradient alone or solid `--bg-raised`. Never a flat single-color fill on a hero.

**Cards / panels.** Glass: `--glass-bg` gradient fill, 1px lilac-tinted border with a brighter
top/left highlight edge (catches the "light from above"), `--radius-lg`, layered
`--shadow-md` + inner-top highlight, and `backdrop-filter: blur`. Interactive cards lift 3px
and gain a lilac glow on hover. Solid variant (`.panel--solid`) for dense content.

**Borders & radii.** Hairline lilac-tinted borders everywhere. Radii: chips/tags/inputs `4px`,
buttons `8px`, cards `12px`, panels `18px`, hero/feature `24px`. **Never** round to a pill.

**Shadows & depth.** Three soft shadow tiers (`--shadow-sm/md/lg`) plus `--inner-top` highlight
and node/text **glow** tokens (`--glow-magenta/lilac/violet/spark`, `--text-glow`). Depth comes
from stacking glow + glass + shadow, not from heavy black drop-shadows alone.

**Motion.** Purposeful and alive but never gimmicky. Synapses pulse and data travels along
links (the neural field). Entrances: gentle fade + 16–24px rise, ~0.4s ease. Buttons press to
`scale(0.97)`; cards lift on hover. **No bounce/elastic.** Everything honors
`prefers-reduced-motion` (neural field renders a single static frame; transitions collapse).

**Hover / press.** Hover = border warms to lilac + lift + soft glow. Press = `scale(0.97)`.
Links shift lilac → magenta.

**Transparency & blur.** Core to the look in Neural theme (glass panels, blurred nav). Disabled
in Document/Print.

**Layout.** Centered single-column reading measure (`--measure` ~1180px) with generous vertical
rhythm. Left-aligned text. Sticky blurred top nav. Numbered sections (`01 / 02 …`) in mono.

**Imagery vibe.** Cool, luminous, deep-space. Real photos sit inside glass frames with a subtle
purple wash; treat screenshots as evidence inside bordered frames. Use striped placeholders
with mono captions where real assets are pending — never hand-draw illustrative SVGs.

---

## ICONOGRAPHY

- **Primary icon set: [Lucide](https://lucide.dev)** — thin 1.5–2px stroke, rounded joins.
  Load from CDN (`https://unpkg.com/lucide@0.288.0/...`), call `lucide.createIcons()`. Used for
  nav, links, timeline nodes, contact, and metadata. (The source CV template used Font Awesome;
  we standardize on Lucide for a cleaner, consistent stroke.)
- **The brand mark is the neural node-cluster glyph.** Built from circles + synapse lines only
  (no illustrative SVG): four nodes (the PPPP) connected through a bright central/linking node
  (Protocol). Pairs with the wordmark **"KAMILLA GAFURZIANOVA"** (display) or the short mark
  **"KG"** inside a glowing node. See `assets/README.md` and the `LogoMark` component.
- **The neural field** (`assets/neural-field.js`) is the brand's living signature, not an icon.
- **Domain & PPPP markers** are colored nodes (glowing dots) + mono labels, via `.dtag--*` and
  `.pbadge--*`.
- **Emoji / unicode-as-icons:** not used.

---

## INDEX / manifest

Root:
- `README.md` — this file.
- `colors_and_type.css` — themes + type/spacing/radius/depth tokens. **Import this**; set
  `class="theme-neural"` (default) on `<body>`.
- `SKILL.md` — Agent-Skills entry point.
- `assets/` — `neural-field.js` (signature canvas), brand-mark notes, asset URLs.
- `preview/` — specimen cards rendered in the Design System tab.

UI kits (`ui_kits/<surface>/`):
- `_shared.css` — governed component classes (buttons, chips, badges, panels, nodes, PPPP
  badges, fields) for both kits.
- `portfolio-site/` — the flagship interactive CV (neural hero + PPPP + skills + timeline +
  work + contact). React + Babel, inline JSX.
- `pppp-framework/` — the PPPP method explainer surface.
