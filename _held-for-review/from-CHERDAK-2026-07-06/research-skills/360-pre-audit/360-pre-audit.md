name: 360-pre-audit
description: >
  Automates a full 360° pre-audit workflow for any website URL. Use this skill
  immediately whenever the user says "run pre-audit for [URL]", "audit this site",
  "do a pre-audit on [URL]", "pre-audit [URL]", or asks for an SEO/technical/
  accessibility site audit. Covers four pillars: (1) Technical SEO — meta tags,
  schema markup, broken links; (2) Performance — Core Web Vitals proxies, mobile
  friendliness; (3) Accessibility — WCAG 2.1 alt-text and ARIA checks; (4) Market
  Intelligence — traffic estimates, SERP features, competitive signals. Outputs a
  structured AUDIT_BRIEF_[project].md with a SWOT analysis. Always trigger this
  skill when a URL and any audit/analysis intent appear together, even if the user
  doesn't use the word "pre-audit" explicitly.
---
 
# 360° Pre-Audit Skill
 
## Overview
 
This skill performs a structured, four-pillar website pre-audit using available tools (web_fetch, web_search, and any connected MCP servers) and produces a professional `AUDIT_BRIEF_[project].md` deliverable.
 
---
 
## Execution Workflow
 
### Step 0 — Parse & Confirm
 
Extract the target URL from the user's message. Normalize it (add `https://` if missing). Derive `[project]` = domain name (e.g., `buildateam.io` → `buildateam`). Confirm with the user only if the URL is ambiguous.
 
---
 
### Step 1 — Technical SEO Scrape
 
Use `web_fetch` on the homepage URL.
 
From the raw HTML, extract and evaluate:
 
**Meta Tags**
- `<title>` — present? length 50–60 chars?
- `<meta name="description">` — present? length 150–160 chars?
- `<meta name="robots">` / `<meta name="googlebot">` — any noindex/nofollow flags?
- Open Graph tags (`og:title`, `og:description`, `og:image`) — present?
- Twitter Card tags — present?
- `<link rel="canonical">` — present? points to self?
- `<meta name="viewport">` — present? (mobile-readiness signal)
 
**Schema Markup**
- Scan for `<script type="application/ld+json">` blocks
- Identify schema types found (e.g., Organization, WebSite, BreadcrumbList, Product, LocalBusiness, FAQPage)
- Note: schema present = YES/NO, types found, any obvious malformation
 
**Broken Links (Sampled)**
- Extract all `<a href>` values from the homepage
- Filter to internal links (same domain) — attempt `web_fetch` on up to **5** sampled internal links
- Flag any that return errors or non-200-equivalent responses
- Note: full crawl is not possible via web_fetch; flag as "sampled check"
 
**Status Signals**
- Note HTTP redirects if web_fetch reports them (e.g., HTTP → HTTPS, www → non-www)
- Check for presence of `<link rel="hreflang">` (multilingual signal)
 
---
 
### Step 2 — Performance Proxies
 
> Note: Claude cannot run Lighthouse directly. Use proxies from the fetched HTML and public search data.
 
**Core Web Vitals (Proxy Assessment)**
- **LCP (Largest Contentful Paint)** proxy: Does the page use `loading="lazy"` on above-the-fold images? Are hero images served via `<img>` with explicit `width`/`height`? Large inline base64 images? Render-blocking `<script>` tags in `<head>` without `defer`/`async`?
- **CLS (Cumulative Layout Shift)** proxy: Images without dimensions (`width`/`height` attributes)? Ads or iframes without reserved space? Web fonts loaded without `font-display`?
- **FID/INP proxy**: Number of synchronous `<script>` blocks in `<head>`.
 
**Mobile-Friendliness**
- Viewport meta tag present (already checked in Step 1)
- Touch targets: count `<a>` and `<button>` elements with inline styles smaller than 44px (flag if found)
- Font size: scan inline styles or `<style>` blocks for `font-size` < 16px on body/p elements
- Horizontal scroll risk: tables without `overflow-x`, fixed-width containers > 768px
 
**Supplemental Web Search**
Run a web_search for: `site:[domain] PageSpeed score` OR `[brand name] Core Web Vitals` to surface any publicly reported lab data.
 
---
 
### Step 3 — Accessibility (WCAG 2.1)
 
From the fetched HTML:
 
**Alt Text**
- Count `<img>` elements total
- Count `<img>` with missing or empty `alt=""` attributes (empty alt is acceptable for decorative images — note the distinction)
- Flag images with `alt` that are clearly non-descriptive (e.g., `alt="image"`, `alt="photo"`, `alt="1"`)
 
**ARIA Labels**
- Check for `<nav>`, `<main>`, `<header>`, `<footer>`, `<aside>` landmark elements — present?
- Check for `aria-label` or `aria-labelledby` on interactive elements (`<button>`, `<a>`, form inputs)
- Check for `role` attributes — any obvious misuse (e.g., `role="button"` on a `<div>` without keyboard handlers visible)?
- Check form inputs for associated `<label>` elements
 
**Color & Contrast**
- Note: contrast ratios cannot be computed without rendering. Flag if inline styles use very light colors (e.g., `color: #ccc`, `color: #ddd`, `color: #eee`, `color: #fff` on non-white backgrounds).
 
**Keyboard / Focus**
- Check for `tabindex="-1"` on interactive elements (removes from focus order — flag if excessive)
- Check for `outline: none` or `outline: 0` in `<style>` blocks (kills focus visibility)
 
**WCAG Level Tag each finding**: `[A]`, `[AA]`, or `[AAA]`
 
---
 
### Step 4 — Market Intelligence
 
Attempt the following in order, using what tools are available:
 
**4a. Web Search Signals (always available)**
Run targeted web_search queries:
1. `[domain] organic traffic estimate 2024 OR 2025` — surface SimilarWeb/SEMrush snippets
2. `[brand] site:[domain] -site:[domain]` — backlink/mention signals
3. `[primary keyword from title tag] featured snippet` — SERP feature landscape
4. `[brand] reviews` — reputation signal
5. `[domain] DA DR authority` — domain authority snippets
 
**4b. MCP-Assisted Intelligence (use if connected)**
- If SEMrush MCP is available: query for organic keyword count, top keywords, estimated traffic
- If SimilarWeb MCP is available: query for monthly visits, traffic sources, top referrers
- If any search console / analytics MCP is available: query for impressions, CTR, top queries
 
**4c. SERP Feature Ownership**
From web_search results, note:
- Featured Snippet ownership (does the target domain appear?)
- Local Pack presence (if local business schema found)
- People Also Ask presence
- Sitelinks
- Knowledge Panel
 
---
 
### Step 5 — Synthesize & Write AUDIT_BRIEF
 
Generate the output file `AUDIT_BRIEF_[project].md` using the template in `references/output-template.md`.
 
Save to `/mnt/user-data/outputs/AUDIT_BRIEF_[project].md` using `create_file`. Then call `present_files` if available.
 
---
 
## Handling Limitations
 
Be transparent. In each section, use one of these callout labels when data is inferred rather than measured:
 
- `⚠️ PROXY` — estimated from HTML signals, not lab measurement
- `🔍 SCRAPED` — directly extracted from fetched HTML
- `🌐 WEB SEARCH` — sourced from a web_search result
- `🔌 MCP` — sourced from a connected MCP tool
- `❌ UNAVAILABLE` — could not be determined with available tools
 
---
 
## Notes
 
- Do **not** hallucinate metric scores. If a metric cannot be determined, say so explicitly.
- Broken link checks are **sampled** (up to 5 links), not a full crawl.
- CWV scores (LCP ms, CLS score) require lab tools (Lighthouse, CrUX). Proxies are signals only.
- Market intelligence from web_search is best-effort; always cite the source snippet.
- If `web_fetch` fails (blocked, timeout, auth wall): note it and proceed with whatever partial data was returned plus web_search fallback.
 
---
 
## Reference Files
 
- `references/output-template.md` — The full AUDIT_BRIEF output template with all sections and SWOT framework. **Read this before writing the output.**
 