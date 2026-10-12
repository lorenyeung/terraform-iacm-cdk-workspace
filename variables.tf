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

variable "provisioner_version" {
  type    = string
  default = null
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
  type    = string
  default = "2.1108.0"
}
