variable "tfe_hostname" {
  type    = string
  default = "tfe.simon-lynch.sbx.hashidemos.io"
}

variable "tfe_organization" {
  type    = string
  default = "apj"
}

variable "workspace_count" {
  type = number
}

variable "oauth_token" {
  type    = string
  default = null
}

variable "oauth_token_id" {
  type    = string
  default = null
}

variable "token" {
  type      = string
  sensitive = true
  default   = null
  #populate from cli var
}