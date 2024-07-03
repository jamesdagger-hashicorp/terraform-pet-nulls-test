variable "tfe_hostname" {
  type    = string
  default = "tfe.simon-lynch.sbx.hashidemos.io"
}

variable "tfe_organization" {
  type    = string
  default = "apj"
}

variable "workspace_count" {
  type    = number
  default = 100
}

variable "oauth_token_id" {
  type = string
}