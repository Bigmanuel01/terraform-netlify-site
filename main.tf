terraform {
  required_providers {
    netlify = {
      source  = "AegirHealth/netlify"
      version = "0.6.12"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  cloud {
    # Replace with your HCP Terraform organization name
    organization = "terraform-netlify-site"

    workspaces {
      # Replace with your HCP Terraform workspace name
      name = "netlify-site"
    }
  }
}

# This provider block configures the Netlify connection.
# The `access_token` is retrieved from an environment variable.
# We will use this provider to create and manage the site.
provider "netlify" {
  token = var.netlify_token
}

# environment variable or a workspace variable in HCP Terraform.
variable "netlify_token" {
  type        = string
  description = "Your Netlify Personal Access Token"
  sensitive   = true
}

# A variable for a custom site name prefix.
# This makes it easy to customize the site's Netlify subdomain.
variable "site_name_prefix" {
  type        = string
  description = "A unique prefix for your Netlify site name."
  default     = "terraform-challenge"
}

# The random provider is used here to generate a unique string.
# This ensures that the Netlify subdomain is unique on every run,
# preventing naming conflicts.
resource "random_string" "unique_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "netlify_site" "my_unique_site" {
  name = "${var.site_name_prefix}-${random_string.unique_suffix.result}"
}


