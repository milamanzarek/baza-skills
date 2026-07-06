# Weight Presets by Business Category

These presets override the default scoring weights in `SKILL.md Step 3`.
Use whichever row matches the client's business type most closely.

---

## Weight Table

| Business Type | Income | ICP Match | Density | Education | Competitor Gap | Proximity |
|---|---|---|---|---|---|---|
| **Default** | 0.30 | 0.25 | 0.15 | 0.10 | 0.15 | 0.05 |
| **Youth Sports / Recreation** | 0.25 | 0.30 | 0.15 | 0.10 | 0.15 | 0.05 |
| **Private Education / Tutoring** | 0.25 | 0.25 | 0.10 | 0.25 | 0.10 | 0.05 |
| **Home Services (cleaning, landscaping)** | 0.30 | 0.20 | 0.20 | 0.05 | 0.20 | 0.05 |
| **Health & Wellness (gym, yoga, therapy)** | 0.25 | 0.20 | 0.25 | 0.10 | 0.15 | 0.05 |
| **Event Services (catering, photo, DJ)** | 0.30 | 0.15 | 0.20 | 0.05 | 0.25 | 0.05 |
| **Personal Services (salon, coaching)** | 0.25 | 0.20 | 0.25 | 0.05 | 0.20 | 0.05 |
| **Children's Enrichment (camps, classes)** | 0.20 | 0.35 | 0.15 | 0.15 | 0.10 | 0.05 |

---

## ICP Match Dimension — by Business Type

The "ICP Match" metric measures different demographics depending on the service.

| Business Type | Primary ICP Signal | Secondary ICP Signal |
|---|---|---|
| Youth Sports / Recreation | % households with children under 18 | Median parent age 30–50 |
| Private Education / Tutoring | % households with school-age children (6–17) | % Bachelor's+ (parent education) |
| Home Services | % owner-occupied housing | Median home value |
| Health & Wellness | Age 25–54 population % | Dual-income households |
| Event Services | % married households | Median HH income |
| Personal Services | Female population 25–54 | Disposable income proxy |
| Children's Enrichment | % families with children 3–12 | % Bachelor's+ |

---

## Income Scoring Calibration by Metro Tier

Adjust scoring thresholds based on metro cost-of-living.

| Metro Tier | Examples | "High Income" Threshold | "Premium" Threshold |
|---|---|---|---|
| **Tier 1** (VHCOL) | NYC, SF, LA, Boston, Seattle | >$150K median HH | >$200K |
| **Tier 2** (HCOL) | Chicago, DC, Miami, Denver, Austin | >$100K median HH | >$140K |
| **Tier 3** (MCOL) | Phoenix, Atlanta, Tampa, Portland | >$80K median HH | >$110K |
| **Tier 4** (LCOL) | Memphis, Tulsa, Cleveland | >$65K median HH | >$90K |

When scoring income, calibrate the 0–10 scale to the metro tier. A $120K zip in Memphis is a 10;
a $120K zip in San Francisco is a 5.

---

## Competitor Gap — Search Instructions

Run these searches to estimate competitor density per zip:

```
Google Maps: "[service type] [zip code]"
Google Maps: "[service type] near [neighborhood name]"
Yelp: "[service category]" → filter by zip
```

Count results within 5-mile radius. Weight by quality:
- Established business (3+ years, 50+ reviews) = 1.5 competitors
- New or weak business (<10 reviews, <1 year) = 0.5 competitors
- Large chain / franchise = 2.0 competitors (harder to displace)

---

## Specialty Notes

### Youth Sports / Fencing / Martial Arts
- Weight school proximity heavily: families self-sort near good elementary/middle schools
- Check for Y/YMCA, recreation center, community center density — these are indirect competitors
- Private school density is a strong proxy for high-income family concentration
- After-school program market window: target zips with high % of working parents (dual income)

### Home Services
- Prioritize owner-occupied rates and median home values over pure income
- New construction neighborhoods often outperform on willingness-to-pay
- HOA density (inferrable from zip-level housing data) signals organized, reachable audience

### Private Education
- Highly correlated with parental education level — weight Bachelor's+ heavily
- Cross-reference with state school rating data: low-rated public schools drive private tutoring demand
- Summer program demand spikes in high-income zips regardless of school quality

---

## Quick Reference: Census Reporter URL Pattern

For any US zip code, pull the profile directly:
```
https://censusreporter.org/profiles/86000US[ZIPCODE]-[ZIPCODE]/
```
Example for zip 10001:
```
https://censusreporter.org/profiles/86000US10001-10001/
```

Key tables available on each profile page:
- Population & demographics
- Income distribution
- Households & families
- Housing
- Education

---

## Output Enhancement: Narrative Framing by Finding Type

Use these templates when writing strategic recommendations:

**Underserved High-Income Zip:**
> "ZIP [XXXXX] ([neighborhood]) ranks #[N] in opportunity score but receives zero current marketing investment. With median household income of $[X] and [Y]% families with children, this zip represents an estimated [Z] households in your ICP — all currently unaware of your service."

**Over-invested Low-Score Zip:**
> "ZIP [XXXXX] currently receives [marketing/outreach effort] but scores [X]/100 on opportunity — primarily due to [lower income / competitor saturation / low family density]. Reallocating this spend to [higher-scoring zip] could improve CAC by an estimated [X–Y]%."

**ICP Mismatch:**
> "Your stated ICP is [profile]. However, your current service zip codes average [X]% families with children and $[Y] median income — [above/below] your target. This suggests [you're over-serving a premium segment / underserving the audience that would most benefit]."