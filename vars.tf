# variable "netlify_token" {
#   description = "Netlify personal access token. Set in HCP workspace as env NETLIFY_TOKEN."
#   type        = string
#   sensitive   = true
# }

variable "site_name" {
  description = "Optional custom Netlify subdomain. Random if null."
  type        = string
  default     = null
}

variable "repo_path" {
  description = "Git repo path in your VCS, e.g. 'username/repo'."
  type        = string
  default     = "Bigmanuel01/terraform-netlify-site"
}


