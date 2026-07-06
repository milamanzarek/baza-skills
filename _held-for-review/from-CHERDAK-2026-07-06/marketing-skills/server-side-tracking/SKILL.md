name: server-side-tracking
description: >
  Guides the full setup of server-side GA4 tracking via a GTM server container: Cloud Run
  deployment (GCP primary, AWS/Azure as variants), GA4 server-side tag and trigger config,
  minimum instance settings, and verification via GA4 Realtime. Ends with a client handoff
  doc. Trigger immediately when the user mentions server-side tracking, GTM server container,
  Cloud Run GTM, sGTM, GA4 server-side setup, or setting up tracking for a new client. Also
  trigger for any request to verify, debug, or document an existing server-side tracking setup.
---

# Server-Side Tracking Setup Skill

Guides a complete server-side GA4 tracking setup from any entry point through to a verified,
documented deployment. GCP (Cloud Run) is the primary path. AWS and Azure variants are in
`references/cloud-variants.md`.

---

## Step 0: Establish Entry Point

Before doing anything, ask the user one question to identify where they are:

> "What do you already have in place? For example: GA4 property, GTM web container, GTM server
> container, Cloud Run deployment — or are we starting from zero?"

Then map their answer to the correct entry point below:

| They have | Start at |
|---|---|
| Nothing | Step 1 |
| GA4 property only | Step 2 |
| GA4 + GTM web container | Step 3 |
| GA4 + GTM web + server container (not deployed) | Step 4 |
| Everything deployed, needs verification | Step 6 |
| Everything deployed + verified, needs handoff doc | Step 7 |

Also collect at intake (ask together with entry point question if not obvious):
- Client name / project name (for handoff doc)
- Cloud provider preference (GCP default — ask only if they mention a different provider)
- Domain the GTM server container will run on (e.g., `metrics.clientdomain.com`)
- GA4 Measurement ID (format: `G-XXXXXXXXXX`)

---

## Step 1: GA4 Property Setup

1. Go to **Google Analytics → Admin → Create Property**
2. Property name: `[Client Name] - Production`
3. Reporting time zone + currency: match client's business location
4. Create a **Web data stream** for the client's domain
5. Copy the **Measurement ID** (`G-XXXXXXXXXX`) — needed in Steps 3 and 5
6. Under **Data Stream → Configure tag settings**:
   - Disable "Page changes based on browser history events" if using a SPA framework
   - Enable "Enhanced measurement" only for events the client actually needs

**Output of this step:** Measurement ID confirmed and recorded.

---

## Step 2: GTM Web Container Setup

1. Go to **Google Tag Manager → Create Account**
   - Account name: `[Client Name]`
   - Container name: `[Client Domain]` (e.g., `www.clientdomain.com`)
   - Target platform: **Web**
2. Install the GTM snippet on the client's site (head + body tags)
3. Verify GTM is firing: open GTM Preview mode, load the client site, confirm `gtm.js` appears in the Summary panel

**Output of this step:** GTM Web Container ID (`GTM-XXXXXXX`) confirmed.

---

## Step 3: GTM Server Container Creation

1. In GTM, go to **Admin → Create Container**
   - Container name: `[Client Name] - Server`
   - Target platform: **Server**
2. GTM will generate a **Server Container Config string** — copy it (needed for deployment)
3. Do NOT provision via GTM's built-in "Quick Setup" — use manual Cloud Run deployment (Step 4) for cost control and minimum instance configuration

**Output of this step:** Server Container Config string copied.

---

## Step 4: Cloud Run Deployment (GCP — Primary Path)

> For AWS or Azure, see `references/cloud-variants.md` before proceeding.

### Prerequisites
- GCP project created and billing enabled
- `gcloud` CLI installed and authenticated (`gcloud auth login`)
- Cloud Run API enabled: `gcloud services enable run.googleapis.com`

### Deploy the sGTM container

```bash
gcloud run deploy gtm-server \
  --image gcr.io/cloud-tagging-10302018/gtm-cloud-image:stable \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars CONTAINER_CONFIG=[PASTE_SERVER_CONTAINER_CONFIG_STRING] \
  --min-instances 1 \
  --max-instances 4 \
  --memory 512Mi \
  --cpu 1 \
  --port 8080
```

**Replace:** `[PASTE_SERVER_CONTAINER_CONFIG_STRING]` with the string from Step 3.

### Minimum instances — why this matters

`--min-instances 1` prevents cold starts. Without it, the first hit after idle period will be
dropped or delayed, causing data loss. For high-traffic clients, increase to 2.

**Cost note:** 1 minimum instance on Cloud Run ≈ $10–15/month at low traffic. Set
`--max-instances` based on expected traffic peaks. 4 is a safe default for most clients.

### After deployment

1. Copy the **Cloud Run Service URL** (format: `https://gtm-server-xxxx-uc.a.run.app`)
2. Map a custom subdomain to it (required — GA4 won't accept the raw `.run.app` URL):
   - Add a CNAME record: `metrics.clientdomain.com` → Cloud Run URL
   - In Cloud Run → Custom Domains: map `metrics.clientdomain.com` to the service
   - Wait for SSL provisioning (5–30 min)

**Output of this step:** Server container URL live at `https://metrics.clientdomain.com`

---

## Step 5: GTM Tag + Trigger Configuration

### In the GTM Server Container:

**Tag: GA4 — Server-Side**
- Tag type: **Google Analytics: GA4**
- Measurement ID: `[G-XXXXXXXXXX]`
- Transport URL: `https://metrics.clientdomain.com` (the custom subdomain from Step 4)
- Trigger: **All Pages** (or custom trigger — see below)

**Trigger options:**

| Goal | Trigger type | Config |
|---|---|---|
| All pageviews | Page View | Fire on all pages |
| Specific events only | Custom Event | Event name matches regex: `page_view\|purchase\|add_to_cart` |
| Exclude internal traffic | Page View + Exception | Exclude IP range or `traffic_type` parameter |

### In the GTM Web Container:

**Tag: GA4 Configuration**
- Tag type: **Google Tag (GA4)**
- Measurement ID: `[G-XXXXXXXXXX]`
- Server container URL: `https://metrics.clientdomain.com`
- This routes hits from the browser through the server container

**Tag: GA4 Event — page_view** (if not using automatic collection)
- Tag type: **Google Analytics: GA4 Event**
- Event name: `page_view`
- Trigger: **All Pages**

Publish both containers after configuration.

---

## Step 6: Verification

Run all checks in this order. Do not skip to the handoff doc until all pass.

### Check 1 — Cloud Run health
```bash
curl -I https://metrics.clientdomain.com/healthz
```
Expected: `HTTP/2 200`

If you get a 404 or connection error:
- Confirm CNAME propagation: `dig metrics.clientdomain.com`
- Confirm Cloud Run custom domain mapping is active in GCP console

### Check 2 — sGTM container responding
```bash
curl "https://metrics.clientdomain.com/gtm.js?id=[GTM-SERVER-CONTAINER-ID]"
```
Expected: JavaScript response (not an error page)

### Check 3 — GA4 Realtime
1. Open **GA4 → Reports → Realtime**
2. Open the client site in a browser (not the same browser as GA4 — use incognito)
3. Navigate 2–3 pages
4. Confirm events appear in Realtime within 30 seconds

What to look for:
- `page_view` events firing ✓
- Event source shows server-side (not direct browser hit) ✓
- User location resolving correctly ✓

### Check 4 — GTM Preview mode (server container)
1. In GTM server container → **Preview**
2. Enter `https://metrics.clientdomain.com` as the URL
3. Load the client site
4. Confirm incoming requests appear in the server container preview panel
5. Confirm GA4 tag fires on each request

### Check 5 — No duplicate hits
- In GA4 Realtime, confirm `page_view` fires **once** per page load, not twice
- If duplicates appear: the web container GA4 tag is sending directly to GA4 AND through the server. Disable direct GA4 tag in the web container — only the server container should forward to GA4.

**All 5 checks passed?** → Proceed to Step 7.

---

## Step 7: Client Handoff Document

Generate a structured handoff doc using this template. Fill in all `[PLACEHOLDERS]`.

```markdown
# Server-Side Tracking Setup — [Client Name]
**Prepared by:** [Consultant Name]
**Date:** [Date]
**Status:** ✅ Verified and live

---

## What Was Set Up

| Component | Details |
|---|---|
| GA4 Property | [Property Name] — ID: [G-XXXXXXXXXX] |
| GTM Web Container | [Container Name] — ID: [GTM-XXXXXXX] |
| GTM Server Container | [Container Name] — ID: [GTM-XXXXXXX] |
| Cloud Provider | [GCP / AWS / Azure] |
| Server Container URL | https://metrics.[clientdomain.com] |
| Cloud Run Service | [Service name] — Region: [us-central1] |
| Min Instances | [1] — Max Instances: [4] |

---

## How It Works (Plain English)

When a visitor loads your website, the tracking tag in your browser sends data to YOUR
server (not directly to Google). Your server then forwards that data to Google Analytics.

This means:
- Ad blockers are less likely to block your tracking
- You control what data leaves your server
- User IP addresses are anonymized before reaching Google
- Page load speed is not affected

---

## What's Being Tracked

| Event | Trigger | Destination |
|---|---|---|
| page_view | Every page load | GA4 via server |
| [add_to_cart] | [Click on Add to Cart button] | GA4 via server |
| [purchase] | [Thank you page load] | GA4 via server |

---

## Monthly Cost Estimate

| Resource | Estimated Cost |
|---|---|
| Cloud Run (1 min instance, low traffic) | ~$10–15/month |
| Cloud Run additional instances (on demand) | Pay-per-use |
| GTM | Free |
| GA4 | Free (up to 10M events/month) |

---

## How to Verify It's Working

1. Go to [GA4 Property] → Reports → Realtime
2. Open your website in an incognito window
3. You should see your visit appear within 30 seconds

---

## Key Contacts & Access

| Role | Name | Access Level |
|---|---|---|
| GCP Project Owner | [PLACEHOLDER] | Owner |
| GTM Account Admin | [PLACEHOLDER] | Admin |
| GA4 Property Admin | [PLACEHOLDER] | Admin |

---

## If Something Breaks

| Symptom | First thing to check |
|---|---|
| No data in GA4 Realtime | Cloud Run service status in GCP Console |
| Sudden drop in traffic data | Cloud Run min instances — may have scaled to 0 |
| Duplicate events in GA4 | Web container sending directly to GA4 in parallel |
| SSL error on metrics subdomain | Custom domain mapping in Cloud Run Console |

---

*Generated with server-side-tracking skill. For setup questions, contact [Consultant Name].*
```

---

## Quick Reference: Common Errors

| Error | Cause | Fix |
|---|---|---|
| `403` on Cloud Run URL | Service not set to `--allow-unauthenticated` | Redeploy with the flag |
| Cold start data loss | `--min-instances 0` (default) | Set `--min-instances 1` |
| Duplicate hits in GA4 | Web container GA4 tag sending directly AND via server | Remove direct GA4 tag from web container |
| CNAME not resolving | DNS propagation lag | Wait 30 min; verify with `dig` |
| sGTM not receiving hits | Server container URL not set in web container GA4 tag | Check Transport URL field in GTM web tag |
| GA4 Realtime shows 0 | Server container published but GTM web container not published | Publish web container |