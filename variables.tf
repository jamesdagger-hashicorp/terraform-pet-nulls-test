## Variables file

variable "prefix" {
  type    = string
  default = "simple"
}

variable "instances" {
  type    = number
  default = 3
}

variable "token" {
  type = string
  sensitive = true
  #populate from cli var
}