# terraform-iacm-cdk-workspace

Terraform that creates Harness IACM AWS CDK workspaces, one per environment.

- Workspaces are named `<workspace_name>_<env>` for each entry in `environments` (default `dev`, `test`, `uat`, `prod`).
- Each workspace gets the `PLUGIN_AWSCDK_*` and `PLUGIN_TF_VERSION` environment variables, driven by Terraform variables (defaults: python 3.11, pip 22.3, TF 2.1108.0).
- The workspace configuration version follows `plugin_tf_version` when it is one of Harness's supported versions (2.1125.0, 2.1108.0, 2.1107.0, 2.1139.0, 2.1134.0, 2.1128.1); otherwise it falls back to 2.1139.0.
- Repository, branch, path and connectors are also variables.

## Files
| File | Purpose |
|---|---|
| `versions.tf` | Provider and Terraform versions, provider auth |
| `variables.tf` | All inputs |
| `main.tf` | `harness_platform_workspace` resources |
| `outputs.tf` | Workspace identifiers |
| `terraform.tfvars.example` | Example values |

## Usage
```sh
cp terraform.tfvars.example terraform.tfvars   # edit values
export TF_VAR_harness_platform_api_key="<api key>"
terraform init
terraform plan
terraform apply
```
