terraform {
  cloud {

    organization = "terraform-netlify-site"

    workspaces {
      name = "netlify-site"
    }
  }
}

