
terraform {
 required_version = ">= 1.5.0"
  backend "s3" {
    bucket         = "dipeshdevops4stroage "
    key            = "yash/terraform.tfstate"
    region         = "eu-north-1"
  }
}
