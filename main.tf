terraform {
  required_version = ">= 1.4.0"

  required_providers {
    netlify = {
      source  = "netlify/netlify"
      version = ">= 0.2.3"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
  }
}

provider "netlify" {
  # Provided via Terraform var or env NETLIFY_TOKEN. Do not hardcode.
  token = var.netlify_token
}

# Random suffix for unique site names
resource "random_pet" "suffix" {
  length = 2
}

locals {
  site_name = coalesce(var.site_name, "tf-netlify-${random_pet.suffix.id}")
}

# Netlify deploy key that will be added as a read-only deploy key in your VCS
resource "netlify_deploy_key" "this" {}

# Create the Netlify site and connect it to your Git repo
resource "netlify_site" "this" {
  name = local.site_name

  repo {
    deploy_key_id = netlify_deploy_key.this.id
    provider      = "github"        # or "gitlab" or "bitbucket"
    repo_path     = var.repo_path   # e.g. "your-username/terraform-netlify-site"
    repo_branch   = var.repo_branch # e.g. "main"
    command       = var.build_command
    dir           = var.publish_dir
  }
}

# Optional build hook to trigger deploys manually
resource "netlify_build_hook" "manual_trigger" {
  site_id = netlify_site.this.id
  branch  = var.repo_branch
  title   = "manual-deploy"
}
