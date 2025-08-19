# 🚀 Terraform + Netlify CI/CD Project

This project demonstrates how to use **Terraform** and **Netlify** together to provision and deploy a static website.
It is designed to be **re-runnable**: `terraform init/plan/apply` works from a fresh environment with no manual steps, and deployment is automated via GitHub Actions.

---

## 📌 Requirements

Before running this project, you need:

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- A [Netlify Personal Access Token](https://docs.netlify.com/cli/get-started/#obtain-a-token)
- A [GitHub Actions](https://docs.github.com/en/actions) runner (configured automatically in this repo)
- An account on [HCP Terraform](https://app.terraform.io/) (Terraform Cloud)
- [netlify-cli](https://docs.netlify.com/cli/get-started/) (required only in CI/CD, not locally)

---

## ⚙️ How It Works

This project separates **site provisioning** from **site deployment**:

### 1. Provisioning (Terraform)

- When you run `terraform apply` locally (or via CI), Terraform:

  - Creates a new Netlify site with a unique subdomain (using the `netlify_site` resource).
  - Generates a random suffix to ensure uniqueness (`terraform-challenge-abc123.netlify.app`).

- At this point, the site exists but has **no content** deployed yet.

### 2. Deployment (CI/CD)

- GitHub Actions takes over after provisioning.
- On every push:

  - Terraform runs to provision the site (if not already created).
  - The workflow uses **`netlify-cli`** and your `NETLIFY_AUTH_TOKEN` to deploy the static files in `./site` to the provisioned site.

- This ensures your site always reflects the latest repo state.

---

## 🖼️ Architecture Flow

```text
   ┌─────────────────┐
   │   GitHub Repo   │
   │ (Code + TF + CI)│
   └───────┬─────────┘
           │ Push (commit)
           ▼
   ┌───────────────────────────────┐
   │   GitHub Actions Workflow     │
   │  (terraform init/plan/apply)  │
   └───────────┬───────────────────┘
               │
               ▼
   ┌───────────────────────────────┐
   │  HCP Terraform (Remote State) │
   │   - Provisions Netlify site   │
   └───────────┬───────────────────┘
               │
               ▼
   ┌───────────────────────────────┐
   │      Netlify Infrastructure   │
   │   - Site created (subdomain)  │
   └───────────┬───────────────────┘
               │
               ▼
   ┌───────────────────────────────┐
   │     Netlify CLI (in CI/CD)    │
   │   - Deploy ./site directory   │
   └───────────┬───────────────────┘
               │
               ▼
   ┌───────────────────────────────┐
   │  Live Netlify Site            │
   │ https://<prefix>-<random>.app │
   └───────────────────────────────┘
```

---

## 🔑 Variables

| Variable           | Description                                    | Default               |
| ------------------ | ---------------------------------------------- | --------------------- |
| `netlify_token`    | Your Netlify Personal Access Token (sensitive) | n/a (set in GitHub)   |
| `site_name_prefix` | Prefix for the Netlify site name               | `terraform-challenge` |

---

## 📤 Outputs

After running Terraform, you’ll see:

- `live_site_url` → The public URL of the created Netlify site
- `netlify_site_id` → The unique ID of the site (used by deployments)
- `netlify_site_name` → The Netlify subdomain name

---

## ▶️ Usage

### Local (Provision Only)

```bash
terraform init
terraform plan
terraform apply
```

This will create the Netlify site, but **will not deploy files**.
The site will exist with a blank placeholder.

### CI/CD (Provision + Deploy)

Just push your code to GitHub:

```bash
git add .
git commit -m "update site"
git push
```

- The GitHub Actions workflow (`.github/workflows/terraform.yml`) will:

  - Run `terraform apply` in HCP Terraform
  - Deploy the contents of `./site` to Netlify via `netlify-cli`

---

## ✅ Re-runnable

This project is **idempotent**:

- Running `terraform apply` multiple times won’t break or duplicate resources.
- You can destroy and re-create the entire site with:

  ```bash
  terraform destroy
  terraform apply
  ```

---

## 🌍 Live Example

Once deployed, you can find the URL in the Terraform outputs:

```bash
terraform output live_site_url
```

Or view it directly in HCP Terraform workspace outputs.
