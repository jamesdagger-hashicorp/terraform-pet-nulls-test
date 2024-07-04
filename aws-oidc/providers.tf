terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.56.0"
    }
  }
}

provider "tfe" {
  hostname = var.tfe_hostname
  organization = var.tfe_organization
  token = var.token
}

provider "aws" {
  region = "ap-southeast-2"
}