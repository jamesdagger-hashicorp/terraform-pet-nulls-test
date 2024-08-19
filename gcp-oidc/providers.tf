provider "google" {
  project = var.gcp_project_id
  region  = "global"
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = "global"
}

provider "tfe" {
  hostname     = var.tfe_hostname
  organization = var.tfe_organization_name
}