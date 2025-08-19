# output "site_id" {
#   value       = netlify_site.this.id
#   description = "Netlify site ID"
# }

# output "site_name" {
#   value       = netlify_site.this.name
#   description = "Netlify site name"
# }

# output "live_url" {
#   value       = try(netlify_site.this.ssl_url, null)
#   description = "Live site URL (https)"
# }

# output "deploy_key_public" {
#   value       = netlify_deploy_key.this.public_key
#   description = "Add this as a read-only Deploy Key in your Git repo settings"
#   sensitive   = true
# }
