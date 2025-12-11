terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"  # Changed from ~> 5.0 to ~> 6.0
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}