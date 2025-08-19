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


