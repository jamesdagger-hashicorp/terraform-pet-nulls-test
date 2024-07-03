


resource "tfe_workspace" "workspaces" {
  count          = var.workspace_count
  name           = "perftest-${count.index + 1}"
  organization   = var.tfe_organization
  queue_all_runs = true
  auto_apply     = true
  force_delete   = true
  file_triggers_enabled = false
  vcs_repo {
    branch         = "main"
    identifier     = "hashi-demo-lab/pet-nulls-test"
    oauth_token_id = var.oauth_token_id
  }
}
