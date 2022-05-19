terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

# source
# https://www.alexhyett.com/terraform-s3-static-website-hosting#aim-for-this-terraform-project

# goals
# S3 bucket that hosts our website files for our www subdomain
# S3 bucket that serves as the redirect to our www subdomain (I will explain later)
# SSL wildcard certificate validated for our domain that automatically renews.
