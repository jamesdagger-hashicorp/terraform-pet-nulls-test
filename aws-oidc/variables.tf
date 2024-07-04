variable "tfe_hostname" {
  type        = string
  description = "hcp terraform cloud hostname"
  default     = "tfe.simon-lynch.sbx.hashidemos.io"
}

variable "tfe_organization" {
  type        = string
  description = "hcp terraform cloud hostname"
  default     = "apj"
}

variable "tfc_aws_audience" {
  type        = string
  description = "hcp terraform cloud aws audience"
  default     = "aws.workload.identity"
}

variable "tfe_project_id" {
  type        = string
  description = "tf cloud project id"
  default     = "prj-7bdNrhEUC5Abmh68"
}


variable "oidc_provider_client_id_list" {
  type        = list(string)
  description = "oidc provider client id list"
  default     = ["aws.workload.identity"]
}

variable "token" {
  type = string
  sensitive = true
  #populate from cli var
}