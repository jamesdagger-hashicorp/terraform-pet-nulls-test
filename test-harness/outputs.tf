output "perf_workspaces" {
  value = tfe_workspace.workspaces[*].id
}

output "oauth_token_id" {
  value = local.oauth_token_id
}
