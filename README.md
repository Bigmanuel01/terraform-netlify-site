Got it 👍 Thanks for pointing that out. Here’s the cleaned-up **README without inline code** — just explanations, setup steps, and usage.

---

# 🚀 Terraform + Netlify Site Deployment

This project provisions and deploys a static website on **Netlify** using **Terraform** for infrastructure management and **GitHub Actions** for CI/CD.

It demonstrates how to make your Terraform configuration **re-runnable**, so `terraform init/plan/apply` works reliably with fresh credentials.

---

## 🛠 Requirements

Before running this project, ensure you have:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- A [Netlify account](https://www.netlify.com/)
- A [Netlify Personal Access Token](https://docs.netlify.com/cli/get-started/#obtain-a-token)
- An [HCP Terraform (Terraform Cloud) account](https://app.terraform.io/) and API token

---

## 📂 Project Structure

- **main.tf** → Terraform configuration for Netlify + HCP
- **site/** → Your static website files
- **.github/workflows/deploy.yml** → GitHub Actions workflow for CI/CD

---

## ⚙️ How It Works

This project separates **site provisioning** from **site deployment**:

1. **Provisioning (Terraform)**

   - Running Terraform creates a new Netlify site with a unique subdomain.
   - At this point, the site exists but is empty (no content).

2. **Deployment (CI/CD)**

   - A GitHub Actions workflow runs on every push.
   - It uses `netlify-cli` to deploy the files in `./site` to the Netlify site created by Terraform.
   - This ensures your site content is always up-to-date.

---

## 🔑 Required Secrets

In your GitHub repo, go to:
**Settings → Secrets and variables → Actions → New repository secret**

Add the following:

- `NETLIFY_AUTH_TOKEN` → your Netlify Personal Access Token
- `TF_API_TOKEN` → your HCP Terraform API Token

---

## ✅ Usage

### Local

Run the usual Terraform workflow:

- `terraform init`
- `terraform plan`
- `terraform apply`

This creates the Netlify site (empty).

### CI/CD

Push your changes to GitHub:

- `git add .`
- `git commit -m "Deploy site"`
- `git push origin main`

The GitHub Actions workflow will automatically:

1. Provision infrastructure in HCP Terraform
2. Deploy the static site with Netlify CLI

---

## 📦 Outputs

After running Terraform, you will get:

- **live_site_url** → The live Netlify URL (example: `https://terraform-challenge-abc123.netlify.app`)
- **netlify_site_id** → Used by Netlify CLI for deployment
- **netlify_site_name** → The Netlify subdomain name

---
