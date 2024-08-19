## Variables file

variable "prefix" {
  type    = string
  default = "simple"
}

variable "instances" {
  type    = number
  default = 3
}

# variable "project_id" {
#   description = "The project ID to deploy resources into"
#   type        = string
# }