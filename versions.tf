terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    #     aws = {
    #       source  = "hashicorp/aws"
    #       version = "5.56.1"
    #     }

  }
}