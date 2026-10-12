output "workspace_identifiers" {
  value = { for env, ws in harness_platform_workspace.this : env => ws.identifier }
}
