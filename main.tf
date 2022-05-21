# source
# https://www.alexhyett.com/terraform-s3-static-website-hosting#aim-for-this-terraform-project
# https://github.com/alexhyett/terraform-s3-static-website

terraform {

  required_version = "~> 1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14"
    }
  }

#   backend "s3" {
#     bucket = "yourdomain-terraform"
#     key    = "prod/terraform.tfstate"
#     region =  var.region
#   }
}

provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "acm_provider"
  region = var.region
}