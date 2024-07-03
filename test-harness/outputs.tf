output "perf_workspaces" {
    value = tfe_workspace.workspaces[*].id
}