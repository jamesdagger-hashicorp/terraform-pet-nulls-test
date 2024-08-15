# data "tfe_oauth_client" "default" {
#   count            = var.oauth_token_id != null ? 1 : 0
#   organization = var.tfe_organization
#   service_provider = "github"
# }

resource "tfe_oauth_client" "default" {
  count            = var.oauth_token_id == null ? 1 : 0
  organization     = var.tfe_organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.oauth_token
  service_provider = "github"
}

locals {
  oauth_token_id = var.oauth_token_id == null ? tfe_oauth_client.default[0].oauth_token_id : var.oauth_token_id
}

resource "tfe_project" "default" {
  name = "perftest"
}

resource "tfe_workspace" "workspaces" {
  count                 = var.workspace_count
  name                  = "perftest-${count.index + 1}"
  organization          = var.tfe_organization
  project_id            = tfe_project.default.id
  queue_all_runs        = true
  auto_apply            = true
  force_delete          = true
  file_triggers_enabled = false
  vcs_repo {
    branch         = "main"
    identifier     = "nhsy-hcp/terraform-pet-nulls-test"
    oauth_token_id = local.oauth_token_id

  }
}
