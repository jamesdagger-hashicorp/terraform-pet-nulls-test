output "gcp_workload_identity_pool_id" {
  value = google_iam_workload_identity_pool.tfe.workload_identity_pool_id
}

output "gcp_project_number" {
  value = data.google_project.project.number
}

output "gcp_workload_provider_id" {
  value = google_iam_workload_identity_pool_provider.tfe.workload_identity_pool_provider_id
}

output "gcp_service_account_email" {
  value = google_service_account.tfe.email
}

output "gcp_project_id" {
  value = var.gcp_project_id
}