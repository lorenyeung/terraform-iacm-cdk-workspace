locals {
  plugin_env_vars = {
    PLUGIN_AWSCDK_LANGUAGE                = var.plugin_awscdk_language
    PLUGIN_AWSCDK_LANGUAGE_VERSION        = var.plugin_awscdk_language_version
    PLUGIN_AWSCDK_PACKAGE_MANAGER         = var.plugin_awscdk_package_manager
    PLUGIN_AWSCDK_PACKAGE_MANAGER_VERSION = var.plugin_awscdk_package_manager_version
    PLUGIN_TF_VERSION                     = var.plugin_tf_version
  }

  provisioner_version = contains(var.supported_provisioner_versions, var.plugin_tf_version) ? var.plugin_tf_version : var.default_provisioner_version
}

resource "harness_platform_workspace" "this" {
  for_each = toset(var.environments)

  identifier = "${var.workspace_name}_${each.key}"
  name       = "${var.workspace_name}_${each.key}"
  org_id     = var.org_id
  project_id = var.project_id

  provisioner_type        = var.provisioner_type
  provisioner_version     = local.provisioner_version
  repository              = var.repository
  repository_branch       = var.repository_branch
  repository_path         = var.repository_path
  repository_connector    = var.repository_connector
  provider_connector      = var.provider_connector
  cost_estimation_enabled = var.cost_estimation_enabled

  provisioner_config {
    language                = var.plugin_awscdk_language
    language_version        = var.config_language_version
    package_manager         = var.plugin_awscdk_package_manager
    package_manager_version = var.config_package_manager_version
  }

  dynamic "environment_variable" {
    for_each = local.plugin_env_vars
    content {
      key        = environment_variable.key
      value      = environment_variable.value
      value_type = "string"
    }
  }
}
