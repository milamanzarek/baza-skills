

**# AUDIT\_BRIEF\_\[project].md — Output Template**

&#x20;

**Use this template exactly. Fill every section. Use the data source labels (🔍 SCRAPED, ⚠️ PROXY, 🌐 WEB SEARCH, 🔌 MCP, ❌ UNAVAILABLE) throughout.**

&#x20;

**---**

&#x20;

**```markdown**

**# 🔍 360° Pre-Audit Brief — \[Domain]**

&#x20;

**\*\*Prepared:\*\* \[Date]**

**\*\*URL Audited:\*\* \[Full URL]**

**\*\*Project ID:\*\* \[project]**

**\*\*Audit Scope:\*\* Technical SEO · Performance · Accessibility · Market Intelligence**

&#x20;

**---**

&#x20;

**## 1. EXECUTIVE SUMMARY**

&#x20;

**> One paragraph (4–6 sentences). Summarize the site's overall health, most critical**

**> issue, biggest opportunity, and confidence level of this report given tools available.**

&#x20;

**\*\*Overall Health Score:\*\* \[X/10 — your holistic judgment]**

**\*\*Critical Issues Found:\*\* \[N]**

**\*\*Quick Wins Available:\*\* \[N]**

&#x20;

**---**

&#x20;

**## 2. TECHNICAL SEO**

&#x20;

**### 2.1 Meta Tags**

&#x20;

**| Tag | Status | Value / Notes |**

**|-----|--------|---------------|**

**| Title | ✅ / ⚠️ / ❌ | "\[value]" (\[N] chars) |**

**| Meta Description | ✅ / ⚠️ / ❌ | "\[value]" (\[N] chars) |**

**| Canonical | ✅ / ⚠️ / ❌ | \[URL or MISSING] |**

**| Robots | ✅ / ⚠️ / ❌ | \[value or DEFAULT] |**

**| Viewport | ✅ / ⚠️ / ❌ | \[value or MISSING] |**

**| OG Tags | ✅ / ⚠️ / ❌ | \[og:title, og:description, og:image — present?] |**

**| Twitter Card | ✅ / ⚠️ / ❌ | \[type or MISSING] |**

**| hreflang | ✅ / N/A | \[languages or NOT PRESENT] |**

&#x20;

**\*\*Source:\*\* 🔍 SCRAPED**

&#x20;

**### 2.2 Schema Markup**

&#x20;

**| Schema Type | Present | Notes |**

**|-------------|---------|-------|**

**| \[Type] | ✅ / ❌ | \[Any issues] |**

&#x20;

**\*\*Source:\*\* 🔍 SCRAPED**

**\*\*Recommendation:\*\* \[Add/Fix/Expand schema. Specific types recommended.]**

&#x20;

**### 2.3 Broken Links (Sampled)**

&#x20;

**Checked \[N] of \[total] internal links found on homepage.**

&#x20;

**| URL | Status |**

**|-----|--------|**

**| \[url] | ✅ OK / ❌ Error / ⚠️ Redirect |**

&#x20;

**\*\*Source:\*\* 🔍 SCRAPED (sampled — not a full crawl)**

&#x20;

**### 2.4 HTTPS \& Redirect Chain**

&#x20;

**- HTTP → HTTPS redirect: \[YES / NO / UNKNOWN]**

**- www → non-www (or vice versa): \[YES / NO / UNKNOWN]**

&#x20;

**\*\*Source:\*\* 🔍 SCRAPED**

&#x20;

**---**

&#x20;

**## 3. PERFORMANCE**

&#x20;

**### 3.1 Core Web Vitals (Proxy Assessment)**

&#x20;

**| Metric | Proxy Signal | Inferred Risk |**

**|--------|-------------|---------------|**

**| LCP | \[findings: lazy loading, render-blocking scripts, etc.] | 🟢 Low / 🟡 Medium / 🔴 High |**

**| CLS | \[findings: images without dimensions, font-display, etc.] | 🟢 Low / 🟡 Medium / 🔴 High |**

**| FID/INP | \[findings: sync scripts in head] | 🟢 Low / 🟡 Medium / 🔴 High |**

&#x20;

**\*\*Source:\*\* ⚠️ PROXY (HTML signals only — lab measurement requires Lighthouse/CrUX)**

&#x20;

**\*\*Lab Data Found:\*\* \[Any PageSpeed/CWV data from web\_search — cite source. Or: ❌ UNAVAILABLE]**

&#x20;

**### 3.2 Mobile-Friendliness**

&#x20;

**| Check | Status | Notes |**

**|-------|--------|-------|**

**| Viewport meta | ✅ / ❌ | |**

**| Touch targets < 44px | ✅ / ⚠️ | \[N] instances found |**

**| Font size < 16px | ✅ / ⚠️ | \[findings] |**

**| Horizontal scroll risk | ✅ / ⚠️ | \[findings] |**

&#x20;

**\*\*Source:\*\* ⚠️ PROXY**

&#x20;

**---**

&#x20;

**## 4. ACCESSIBILITY (WCAG 2.1)**

&#x20;

**### 4.1 Alt Text**

&#x20;

**- Total `<img>` elements: \[N]**

**- Missing alt attribute: \[N] ❌**

**- Empty alt (decorative): \[N] ✅ (acceptable)**

**- Non-descriptive alt: \[N] ⚠️ (e.g., "image", "photo")**

&#x20;

**\*\*WCAG Level:\*\* \[A] — Critical if any non-decorative images missing alt**

**\*\*Source:\*\* 🔍 SCRAPED**

&#x20;

**### 4.2 ARIA \& Landmarks**

&#x20;

**| Check | Status | Notes |**

**|-------|--------|-------|**

**| `<main>` landmark | ✅ / ❌ | |**

**| `<nav>` landmark | ✅ / ❌ | |**

**| `<header>` / `<footer>` | ✅ / ❌ | |**

**| Buttons with aria-label | ✅ / ⚠️ / ❌ | \[N] unlabeled |**

**| Form inputs with `<label>` | ✅ / ⚠️ / ❌ | \[N] unlabeled |**

**| ARIA role misuse | ✅ / ⚠️ | \[findings or NONE] |**

&#x20;

**\*\*WCAG Level:\*\* \[A/AA] per finding**

**\*\*Source:\*\* 🔍 SCRAPED**

&#x20;

**### 4.3 Color \& Contrast**

&#x20;

**- Suspicious light color values in styles: \[findings or NONE DETECTED]**

**- \*\*Note:\*\* Contrast ratios require visual rendering — ⚠️ PROXY only**

&#x20;

**### 4.4 Keyboard \& Focus**

&#x20;

**- `tabindex="-1"` on interactive elements: \[N] — \[OK / REVIEW NEEDED]**

**- `outline: none/0` detected: \[YES ❌ / NO ✅]**

&#x20;

**\*\*WCAG Level:\*\* \[AA]**

**\*\*Source:\*\* 🔍 SCRAPED**

&#x20;

**---**

&#x20;

**## 5. MARKET INTELLIGENCE**

&#x20;

**### 5.1 Traffic Estimates**

&#x20;

**| Metric | Value | Source |**

**|--------|-------|--------|**

**| Est. Monthly Visits | \[N] or ❌ UNAVAILABLE | 🌐 / 🔌 |**

**| Traffic Trend | \[Growing / Declining / Stable / UNKNOWN] | 🌐 / 🔌 |**

**| Top Traffic Source | \[Organic / Direct / Referral / UNKNOWN] | 🌐 / 🔌 |**

**| Domain Authority / DR | \[N] or ❌ UNAVAILABLE | 🌐 / 🔌 |**

&#x20;

**### 5.2 Organic SEO Signals**

&#x20;

**| Metric | Value | Source |**

**|--------|-------|--------|**

**| Est. Organic Keywords | \[N] or UNKNOWN | 🌐 / 🔌 |**

**| Top Keyword (approx.) | \[keyword] | 🌐 / 🔌 |**

**| Backlink Profile | \[Strong / Moderate / Weak / UNKNOWN] | 🌐 |**

&#x20;

**### 5.3 SERP Feature Ownership**

&#x20;

**| Feature | Status |**

**|---------|--------|**

**| Featured Snippet | ✅ Owns / ❌ Not owned / 🔍 Opportunity |**

**| Local Pack | ✅ / ❌ / N/A |**

**| People Also Ask | 🔍 Present in SERP |**

**| Sitelinks | ✅ / ❌ |**

**| Knowledge Panel | ✅ / ❌ |**

&#x20;

**\*\*Source:\*\* 🌐 WEB SEARCH**

&#x20;

**### 5.4 Competitive / Reputation Signals**

&#x20;

**\[2–4 bullet points from web\_search findings on brand reputation, mentions, review signals.]**

&#x20;

**---**

&#x20;

**## 6. SWOT ANALYSIS**

&#x20;

**> Synthesize all four pillars into strategic context.**

&#x20;

**| | \*\*Helpful\*\* | \*\*Harmful\*\* |**

**|---|---|---|**

**| \*\*Internal\*\* | \*\*STRENGTHS\*\* | \*\*WEAKNESSES\*\* |**

**| | • \[S1] | • \[W1] |**

**| | • \[S2] | • \[W2] |**

**| | • \[S3] | • \[W3] |**

**| \*\*External\*\* | \*\*OPPORTUNITIES\*\* | \*\*THREATS\*\* |**

**| | • \[O1] | • \[T1] |**

**| | • \[O2] | • \[T2] |**

**| | • \[O3] | • \[T3] |**

&#x20;

**---**

&#x20;

**## 7. PRIORITIZED RECOMMENDATIONS**

&#x20;

**### 🔴 Critical (Fix Immediately)**

**1. \[Issue] — \[Why critical] — \[How to fix]**

&#x20;

**### 🟡 High Priority (Next Sprint)**

**1. \[Issue] — \[Why high] — \[How to fix]**

&#x20;

**### 🟢 Quick Wins (Low Effort / High Impact)**

**1. \[Issue] — \[How to fix]**

&#x20;

**### 💡 Strategic Opportunities**

**1. \[Opportunity] — \[Rationale]**

&#x20;

**---**

&#x20;

**## 8. AUDIT LIMITATIONS \& CONFIDENCE NOTES**

&#x20;

**- \*\*Tools used:\*\* web\_fetch, web\_search\[, MCP: list if used]**

**- \*\*CWV data:\*\* Proxy signals only. Recommend running PageSpeed Insights for lab data.**

**- \*\*Link check:\*\* Sampled (\[N] links). Recommend Screaming Frog or Sitebulb for full crawl.**

**- \*\*Market data:\*\* \[Source-dependent confidence note]**

**- \*\*Accessibility:\*\* Static HTML analysis only. Recommend axe DevTools or WAVE for full WCAG audit.**

&#x20;

**---**

&#x20;

**\*Generated by 360° Pre-Audit Skill · Claude · \[Date]\***

**```**

