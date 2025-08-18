variable "netlify_token" {
  description = "Netlify personal access token. Set in HCP workspace as env NETLIFY_TOKEN."
  type        = string
  sensitive   = true
}

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

variable "repo_branch" {
  description = "Branch to deploy."
  type        = string
  default     = "main"
}

variable "build_command" {
  description = "Build command to run before deploy. Empty for plain HTML."
  type        = string
  default     = ""
}

variable "publish_dir" {
  description = "Directory to publish, e.g. '/' or '/build'."
  type        = string
  default     = "/"
}
