variable "topnotchglobal_domain_name" {
  type        = string
  description = "The domain name for the website."
  default = "topnotch.global"
}

variable "topnotchglobal_redirect_to_domain_name" {
  type        = string
  description = "The domain name this domain should redirect to."
  default = "florianthom.com"
}

variable "topnotchglobal_bucket_name" {
type        = string
  description = "Name of the s3-bucket"
  default     = "topnotch.global"
}

variable "topnotchglobal_common_tags" {
  description = "Common tags you want applied to all components."
  default = {Project = "topnotch.global"}
}

# --------------------------------------------

# S3 bucket for website.
resource "aws_s3_bucket" "topnotchglobal_www_bucket" {
  bucket = "www.${var.topnotchglobal_bucket_name}"
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.topnotchglobal_bucket_name}" })

  website {
    redirect_all_requests_to = "https://www.${var.topnotchglobal_redirect_to_domain_name}"
  }

  tags = var.topnotchglobal_common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "topnotchglobal_root_bucket" {
  bucket = var.topnotchglobal_bucket_name
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = var.topnotchglobal_bucket_name })

  website {
    redirect_all_requests_to = "https://www.${var.topnotchglobal_domain_name}"
  }

  tags = var.topnotchglobal_common_tags
}