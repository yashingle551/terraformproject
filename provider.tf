terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "1.5.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1"

}

