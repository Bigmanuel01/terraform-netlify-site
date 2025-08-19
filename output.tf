output "live_site_url" {
  description = "The URL of the live Netlify site."
  value       = "https://${netlify_site.my_unique_site.name}.netlify.app"
}

output "netlify_site_id" {
  value       = netlify_site.my_unique_site.id
  description = "The Netlify site ID, used for deployments."
}

output "netlify_site_name" {
  value       = netlify_site.my_unique_site.name
  description = "The Netlify site subdomain name."
}
