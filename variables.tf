variable "harness_endpoint" {
  type    = string
  default = "https://app.harness.io/gateway"
}

variable "harness_account_id" {
  type = string
}

variable "harness_platform_api_key" {
  type      = string
  sensitive = true
}

variable "org_id" {
  type    = string
  default = "default"
}

variable "project_id" {
  type    = string
  default = "technical_exercise"
}

variable "workspace_name" {
  description = "Base workspace name; each workspace is named <workspace_name>_<environment>."
  type        = string
}

variable "environments" {
  type    = list(string)
  default = ["dev", "test", "uat", "prod"]
}

variable "provisioner_type" {
  type    = string
  default = "awscdk"
}

variable "repository" {
  type    = string
  default = null
}

variable "repository_branch" {
  type    = string
  default = null
}

variable "repository_path" {
  type    = string
  default = null
}

variable "repository_connector" {
  type    = string
  default = null
}

variable "provider_connector" {
  description = "AWS connector reference used to deploy."
  type        = string
  default     = null
}

variable "cost_estimation_enabled" {
  type    = bool
  default = false
}

variable "plugin_awscdk_language" {
  type    = string
  default = "python"
}

variable "plugin_awscdk_language_version" {
  type    = string
  default = "3.11"
}

variable "plugin_awscdk_package_manager" {
  type    = string
  default = "pip"
}

variable "plugin_awscdk_package_manager_version" {
  type    = string
  default = "22.3"
}

variable "plugin_tf_version" {
  description = "PLUGIN_TF_VERSION override. Also used as the workspace configuration (provisioner) version if it is in supported_provisioner_versions, otherwise default_provisioner_version is used."
  type        = string
  default     = "2.1108.0"
}

variable "supported_provisioner_versions" {
  description = "Versions Harness hard-checks for the workspace configuration version."
  type        = list(string)
  default     = ["2.1125.0", "2.1108.0", "2.1107.0", "2.1139.0", "2.1134.0", "2.1128.1"]
}

variable "default_provisioner_version" {
  description = "Configuration version used when plugin_tf_version is not in supported_provisioner_versions."
  type        = string
  default     = "2.1139.0"
}

variable "config_language_version" {
  description = "Language version in the workspace configuration. Harness hard-checks this against the CDK version (e.g. 3.12 or 3.13); PLUGIN_AWSCDK_LANGUAGE_VERSION can still override it at runtime."
  type        = string
  default     = "3.12"
}

variable "config_package_manager_version" {
  description = "Package manager version in the workspace configuration; PLUGIN_AWSCDK_PACKAGE_MANAGER_VERSION can still override it at runtime."
  type        = string
  default     = "26.0"
}
