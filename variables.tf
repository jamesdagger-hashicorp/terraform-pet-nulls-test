## Variables file

variable "prefix" {
  type    = string
  default = "simple"
}

variable "instances" {
  type    = number
  default = 3
}

variable "gcp_project_id" {
  type    = string
}