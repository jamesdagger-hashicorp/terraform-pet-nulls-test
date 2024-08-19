variable "tfe_gcp_audience" {
  type        = string
  default     = ""
  description = "The audience value to use in run identity tokens if the default audience value is not desired."
}

variable "tfe_hostname" {
  type        = string
  description = "The hostname of the TFC or TFE instance you'd like to use with GCP"
}

variable "tfe_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "tfe_project_name" {
  type        = string
  default     = "Default Project"
  description = "The project under which a workspace will be created"
}

variable "gcp_project_id" {
  type        = string
  description = "The ID for your GCP project"
}

variable "github_repo" {
  description = ""
  type        = string
}

variable "github_oauth_token" {
  description = ""
  default     = ""
  type        = string
}
