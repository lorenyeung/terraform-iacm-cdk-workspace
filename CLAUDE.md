create terraform code here that creates 4 harness IACM CDK workspaces. the name of the workspace should be a single TF var, and then underscore + environment. 
environments should be based on a list, start with dev,test,uat,prod but configurable.

take in the following PLUGIN variables against the workspace env var section and apply:
PLUGIN_AWSCDK_LANGUAGE=python
PLUGIN_AWSCDK_LANGUAGE_VERSION=3.11
PLUGIN_AWSCDK_PACKAGE_MANAGER=pip
PLUGIN_AWSCDK_PACKAGE_MANAGER_VERSION=22.3
PLUGIN_TF_VERSION=2.1108.0
 
they should also be terraform variables.


---

## Session context (as built, 2026-10-12)

Implemented the above as Terraform using the `harness/harness` provider (`harness_platform_workspace`, `for_each` over `var.environments`). Validated with `terraform validate` and a dummy-credential `plan` (4 to add). Nothing applied.

### Files
- `versions.tf` – provider + required versions; provider auth via `harness_endpoint`, `harness_account_id`, `harness_platform_api_key` (sensitive).
- `variables.tf` – all inputs (below).
- `main.tf` – `local.plugin_env_vars` map of the 5 PLUGIN vars, applied to every workspace through a `dynamic "environment_variable"` block (`value_type = "string"`). Per the original request the PLUGIN values are env vars, not the provider's `provisioner_config` block.
- `outputs.tf` – `workspace_identifiers` map (env => identifier).
- `terraform.tfvars.example` – copy to `terraform.tfvars` (gitignored).
- `.gitignore` – Terraform state, `.terraform/`, `*.tfvars`, plans, overrides; keeps `*.tfvars.example` and `.terraform.lock.hcl`.

### Variables
- Naming: `workspace_name` (required, no default) + `environments` (default `["dev","test","uat","prod"]`) → identifier/name `<workspace_name>_<env>`.
- Scope: `org_id` (default `default`), `project_id` (default `technical_exercise`).
- Repo: `repository`, `repository_branch`, `repository_path`, `repository_connector`, `provider_connector` (AWS connector) – all default `null`; must be supplied before apply. `repository_commit`/`repository_sha` intentionally not exposed (conflict with branch).
- Other: `provisioner_type` (default `awscdk`), `cost_estimation_enabled` (false).
- Configuration version: Harness hard-checks the workspace configuration (`provisioner_version`). It is derived, not a variable: equals `plugin_tf_version` if that is in `supported_provisioner_versions` (2.1125.0, 2.1108.0, 2.1107.0, 2.1139.0, 2.1134.0, 2.1128.1), otherwise `default_provisioner_version` (2.1139.0). `PLUGIN_TF_VERSION` env var always carries the user's value as-is.
- PLUGIN vars: `plugin_awscdk_language` (python), `plugin_awscdk_language_version` (3.11), `plugin_awscdk_package_manager` (pip), `plugin_awscdk_package_manager_version` (22.3), `plugin_tf_version` (2.1108.0).

### Notes
- Pass the API key via `export TF_VAR_harness_platform_api_key="$claudekey"`; never put it in a file. Account ID: `WqS38aeyQjayoqy6mzwceA`.
- Still needed before apply: `workspace_name`, repo/connector values, `provider_connector`. Confirm with the user before `terraform apply`.
- Git: repo is `lorenyeung/terraform-iacm-cdk-workspace`, branch `main`; `.gitignore` was created but not committed.
- Workspace configuration (`provisioner_config` block) is hard-checked by Harness: python 3.11 is rejected for CDK 2.1108.0 (supported 3.12/3.13). So config uses `config_language_version` (3.12) and `config_package_manager_version` (26.0, from existing `cdk_s3_site`), while the PLUGIN_* env vars keep the user's values (3.11 / 22.3) as runtime overrides.
- Applied 2026-10-12: 4 workspaces created (myapp_dev/test/uat/prod). Harness validates that the repo connector exists (and repo name is non-empty); the repo itself is not checked when a real connector (`account.ghconnectoracc`) is used, so `my-cdk-repo` is a placeholder. No AWS connector set.
