data "google_project" "project" {}

data "tfe_organization" "default" {
  name = var.tfe_organization_name
}

data "tfe_project" "default" {
  name         = var.tfe_project_name
  organization = var.tfe_organization_name
}
