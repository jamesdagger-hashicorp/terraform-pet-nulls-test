## Variables file

variable "prefix" {
  type    = string
  default = "simple"
}

variable "instances" {
  type    = number
  default = 3
}

variable "project_id" {
  type    = string
}