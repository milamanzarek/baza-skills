# Cloud Variants — AWS and Azure

Read this file when the user is deploying the GTM server container on AWS or Azure instead of GCP.
The GTM server container image, GTM configuration, and all verification steps (SKILL.md Steps 5–7)
are identical across all providers. Only the deployment commands and custom domain mapping differ.

---

## AWS — Cloud Run Equivalent: AWS App Runner

### Prerequisites
- AWS account with billing enabled
- AWS CLI installed and authenticated (`aws configure`)
- ECR (Elastic Container Registry) access or use public image directly

### Deploy via AWS App Runner

```bash
# Create App Runner service using GTM's public Docker image
aws apprunner create-service \
  --service-name gtm-server \
  --source-configuration '{
    "ImageRepository": {
      "ImageIdentifier": "gcr.io/cloud-tagging-10302018/gtm-cloud-image:stable",
      "ImageRepositoryType": "ECR_PUBLIC",
      "ImageConfiguration": {
        "Port": "8080",
        "RuntimeEnvironmentVariables": {
          "CONTAINER_CONFIG": "[PASTE_SERVER_CONTAINER_CONFIG_STRING]"
        }
      }
    },
    "AutoDeploymentsEnabled": false
  }' \
  --instance-configuration '{
    "Cpu": "1 vCPU",
    "Memory": "2 GB"
  }'
```

**Note on minimum instances:** App Runner does not support a true min-instances=0 cold start
problem the same way Cloud Run does — it keeps at least one instance warm by default.
However, for high-traffic clients, configure **Auto Scaling** with a minimum of 2:

```bash
aws apprunner create-auto-scaling-configuration \
  --auto-scaling-configuration-name gtm-server-scaling \
  --min-size 2 \
  --max-size 10 \
  --max-concurrency 100
```

### Custom Domain on AWS

1. In **App Runner Console** → your service → **Custom domains** → **Link domain**
2. Add `metrics.clientdomain.com`
3. AWS will provide CNAME and certificate validation records — add both to DNS
4. Wait for validation (5–30 min)

### Cost estimate (AWS)
- App Runner: ~$0.064/vCPU-hour + $0.007/GB-hour
- 1 vCPU / 2 GB, low traffic ≈ ~$15–25/month

---

## Azure — Cloud Run Equivalent: Azure Container Apps

### Prerequisites
- Azure subscription with billing enabled
- Azure CLI installed and authenticated (`az login`)
- Container Apps extension: `az extension add --name containerapp`

### Deploy via Azure Container Apps

```bash
# Create resource group
az group create \
  --name gtm-server-rg \
  --location eastus

# Create Container Apps environment
az containerapp env create \
  --name gtm-server-env \
  --resource-group gtm-server-rg \
  --location eastus

# Deploy the GTM container
az containerapp create \
  --name gtm-server \
  --resource-group gtm-server-rg \
  --environment gtm-server-env \
  --image gcr.io/cloud-tagging-10302018/gtm-cloud-image:stable \
  --target-port 8080 \
  --ingress external \
  --min-replicas 1 \
  --max-replicas 4 \
  --cpu 1.0 \
  --memory 2.0Gi \
  --env-vars CONTAINER_CONFIG=[PASTE_SERVER_CONTAINER_CONFIG_STRING]
```

**`--min-replicas 1`** is the Azure equivalent of `--min-instances 1` on GCP — required to
prevent scale-to-zero data loss.

### Custom Domain on Azure

1. In **Azure Portal** → Container App → **Custom domains** → **Add custom domain**
2. Add `metrics.clientdomain.com`
3. Azure provides a TXT record for domain verification and a CNAME target — add both to DNS
4. Select **Managed certificate** for automatic SSL
5. Wait for provisioning (10–30 min)

### Cost estimate (Azure)
- Container Apps: ~$0.000024/vCPU-second + $0.000003/GB-second
- 1 vCPU / 2 GB, 1 min replica, low traffic ≈ ~$12–20/month

---

## Cross-Provider Notes

| Feature | GCP Cloud Run | AWS App Runner | Azure Container Apps |
|---|---|---|---|
| GTM image source | `gcr.io/cloud-tagging-10302018/gtm-cloud-image:stable` | Same | Same |
| Min instance config | `--min-instances 1` | Min size in auto-scaling config | `--min-replicas 1` |
| Cold start risk | Yes if min=0 | Lower by default | Yes if min-replicas=0 |
| Custom domain SSL | Auto-provisioned | Manual validation records | Managed certificate option |
| Approx monthly cost (low traffic) | $10–15 | $15–25 | $12–20 |
| CLI tool | `gcloud` | `aws` | `az` |

After deploying on any provider, return to **SKILL.md Step 5** for GTM tag configuration —
it is identical regardless of cloud provider.