
terraform {
 required_version = ">= 1.5.0"
  backend "s3" {
    bucket         = "sid28jenkinsmumbai"
    key            = "project1/terraform.tfstate"
    region         = "eu-north-1"
  }
}


