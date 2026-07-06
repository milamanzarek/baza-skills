# UI Kits

High-fidelity, governed recreations of Kamilla Gafurzianova's surfaces. Both kits use the
**Neural** theme (default) and the shared component classes in `_shared.css` (paired with the
root `../../colors_and_type.css`). They honour Kamilla's three hard NO's: no pills, no flat
surfaces, no low contrast.

## Kits

### `portfolio-site/` — the flagship interactive CV
A single-page interactive CV / portfolio. Structure adapted from a generic code-themed CV
template; **every** pixel re-skinned to the neural identity with Kamilla's real positioning.
- `PortfolioAtoms.jsx` — `I` (Lucide icon), `Kicker`, `LogoMark` (neural node-cluster glyph +
  wordmark), `Btn`, `Chip`, `DomainTag`, `PBadge`, `Node`, `Nav` (sticky, blurred, **theme
  toggle**), `Footer`.
- `PortfolioSections.jsx` — `NeuralHero` (live neural-field backdrop), `About`, `PPPPFramework`
  (interactive node diagram — click a P), `SkillMatrix` (six domains), `ExperienceTimeline`,
  `SelectedWork` (domain filter), `Contact` (fake submit).
- `index.html` — assembles the page, supplies data, wires nav scroll + the Neural↔Document
  theme toggle, and mounts the neural field via `NeuralField.initAll()`.

### `pppp-framework/` — the signature-method explainer
A focused, **plain-HTML** (no React) page teaching the PPPP method: neural hero, the five-node
diagram (Protocol at the synapse), and each P expanded with its role + an "in practice" line.
Demonstrates building with the system in static HTML.

## Conventions
- React 18 + Babel standalone, inline JSX (portfolio kit). Components export to `window` at the
  end of each `.jsx` file. The PPPP kit is plain HTML.
- Lucide icons pinned to `lucide@0.288.0`; call `lucide.createIcons()` after render.
- The signature neural field is `../../assets/neural-field.js` — a `<canvas class="neural-field">`
  behind heroes. Honours `prefers-reduced-motion`.
- Entrance animations are gated behind `.kg-anim` + `@media (prefers-reduced-motion: no-preference)`
  so the end state is always visible (print / reduced-motion / capture safe).
- Cosmetic recreations only — no real backend.
