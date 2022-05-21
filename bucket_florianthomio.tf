variable "florianthomio_domain_name" {
  type        = string
  description = "The domain name for the website."
  default = "florianthom.io"
}

variable "florianthomio_redirect_to_domain_name" {
  type        = string
  description = "The domain name this domain should redirect to."
  default = "florianthom.com"
}

variable "florianthomio_bucket_name" {
type        = string
  description = "Name of the s3-bucket"
  default     = "florianthom.io"
}

variable "florianthomio_common_tags" {
  description = "Common tags you want applied to all components."
  default = {Project = "florianthom.io"}
}

# --------------------------------------------

# S3 bucket for website.
resource "aws_s3_bucket" "florianthomio_www_bucket" {
  bucket = "www.${var.florianthomio_bucket_name}"
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.florianthomio_bucket_name}" })

  website {
    redirect_all_requests_to = "https://www.${var.florianthomio_redirect_to_domain_name}"
  }

  tags = var.florianthomio_common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "florianthomio_root_bucket" {
  bucket = var.florianthomio_bucket_name
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = var.florianthomio_bucket_name })

  website {
    redirect_all_requests_to = "https://www.${var.florianthomio_domain_name}"
  }

  tags = var.florianthomio_common_tags
}