# source
# https://www.alexhyett.com/terraform-s3-static-website-hosting#aim-for-this-terraform-project
# https://github.com/alexhyett/terraform-s3-static-website

# goals
# S3 bucket that hosts our website files for our www subdomain
# S3 bucket that serves as the redirect to our www subdomain (I will explain later)
# SSL wildcard certificate validated for our domain that automatically renews.

terraform {
  required_version = "~> 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "yourdomain-terraform"
    key    = "prod/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}
