# Assets

## `neural-field.js` — the signature brand motif
A lightweight 2D-canvas reinterpretation of Kamilla's interconnected-digital-brain visual.
Nodes (neurons) drift through deep purple space; nearby nodes link with synapse lines that
pulse with travelling data packets; one rare warm-peach **ignition** node sparks. On-brand
colours, honours `prefers-reduced-motion` (renders one static frame), reusable behind heroes
and section dividers.

```html
<canvas class="neural-field" data-density="1" data-spark="true" data-interactive="true"></canvas>
<script src="assets/neural-field.js"></script>
```
`data-*`: `density` (0.4–1.6) · `spark` ("true"/"false") · `interactive` ("true" = nodes nudge
away from the cursor). Or mount programmatically: `NeuralField.mount(canvasEl, { density: 1 })`.
Put it on a radial nebula background and overlay content above it (`z-index`).

## Brand mark — the neural node-cluster glyph
The logo is **not a raster file** — it is built from circles + synapse lines only (allowed
primitives), so it scales and recolors with the theme:
- **Full glyph:** four nodes (the PPPP — violet/magenta/lilac/gold) linked through one bright
  central node (Protocol, warm-peach). Pairs with the wordmark **"KAMILLA GAFURZIANOVA"** in
  Space Grotesk, or the eyebrow **"AI IMPLEMENTATION CONSULTANT · OLY"** in mono.
- **Compact mark:** "KG" set in a single glowing magenta node — used in footers/avatars.
See `LogoMark` in `ui_kits/portfolio-site/PortfolioComponents.jsx` for the canonical recreation.

## Concept source
`../uploads/3d-quantum-neural-network.html` — the original Three.js WebGL neural network that
established the visual identity (deep purple, lilac/white synapse nodes, one blue spark). The
brief's reference screenshots come from it. `neural-field.js` is the production-friendly,
brand-accurate reinterpretation.

## Icons
- **Lucide** (UI icons) — `https://unpkg.com/lucide@0.288.0/dist/umd/lucide.min.js`, then
  `lucide.createIcons()`. Thin stroke, rounded joins.

> No raster logo/photo binaries ship with this system. If you need a real portrait or
> credential badges, ask Kamilla for originals and drop them into this folder.
