# source
# https://www.alexhyett.com/terraform-s3-static-website-hosting#aim-for-this-terraform-project
# https://github.com/alexhyett/terraform-s3-static-website

# goals
# S3 bucket that hosts our website files for our www subdomain
# S3 bucket that serves as the redirect to our www subdomain (I will explain later)
# SSL wildcard certificate validated for our domain that automatically renews.

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

# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404/index.html"
  }

  tags = var.common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name })

  website {
    redirect_all_requests_to = "https://www.${var.domain_name}"
  }

  tags = var.common_tags
}