# Enables the required services in the project.
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "services" {
  for_each = toset([
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com",
    "iamcredentials.googleapis.com"
  ])
  service                    = each.value
  disable_dependent_services = false
  disable_on_destroy         = false
}

# Creates a workload identity pool to house a workload identity
# pool provider.
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool
resource "google_iam_workload_identity_pool" "tfe" {
  provider                  = google-beta
  workload_identity_pool_id = "tfe-wi-demo"

  lifecycle {
    prevent_destroy = true
  }
}

# Creates an identity pool provider which uses an attribute condition
# to ensure that only the specified Terraform Cloud workspace will be
# able to authenticate to GCP using this provider.
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider
resource "google_iam_workload_identity_pool_provider" "tfe" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.tfe.workload_identity_pool_id
  workload_identity_pool_provider_id = "tfe-wi-demo"
  attribute_mapping = {
    "google.subject"                        = "assertion.sub",
    "attribute.aud"                         = "assertion.aud",
    "attribute.terraform_run_phase"         = "assertion.terraform_run_phase",
    "attribute.terraform_project_id"        = "assertion.terraform_project_id",
    "attribute.terraform_project_name"      = "assertion.terraform_project_name",
    "attribute.terraform_workspace_id"      = "assertion.terraform_workspace_id",
    "attribute.terraform_workspace_name"    = "assertion.terraform_workspace_name",
    "attribute.terraform_organization_id"   = "assertion.terraform_organization_id",
    "attribute.terraform_organization_name" = "assertion.terraform_organization_name",
    "attribute.terraform_run_id"            = "assertion.terraform_run_id",
    "attribute.terraform_full_workspace"    = "assertion.terraform_full_workspace",
  }
  oidc {
    issuer_uri = "https://${var.tfe_hostname}"
  }
  #   attribute_condition = "assertion.sub.startsWith(\"organization:${var.tfe_organization_name}:project:${var.tfe_project_name}:workspace:${var.tfe_workspace_name}\")"
  attribute_condition = "assertion.sub.startsWith(\"organization:${var.tfe_organization_name}:project:${var.tfe_project_name}:\")"

  lifecycle {
    prevent_destroy = true
  }
}

# Creates a service account that will be used for authenticating to GCP.
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "tfe" {
  account_id   = "tfe-wi-demo"
  display_name = "Terraform Enterprise WI Service Account"
}

# Allows the service account to act as a workload identity user.
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_service_account_iam_member" "tfe" {
  service_account_id = google_service_account.tfe.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tfe.name}/*"

  depends_on = [
    google_iam_workload_identity_pool_provider.tfe
  ]
}

# Updates the IAM policy to grant the service account permissions
# within the project.
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "tfe" {
  for_each = toset([
    "roles/viewer"
  ])
  project = var.gcp_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.tfe.email}"
}
