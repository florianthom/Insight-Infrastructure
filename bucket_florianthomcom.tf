variable "florianthomcom_domain_name" {
  type        = string
  description = "The domain name for the website."
  default = "florianthom.com"
}

variable "florianthomcom_bucket_name" {
type        = string
  description = "Name of the s3-bucket"
  default     = "florianthom.com"
}

variable "florianthomcom_common_tags" {
  description = "Common tags you want applied to all components."
  default = {Project = "florianthom.com"}
}

# --------------------------------------------

# S3 bucket for website.
resource "aws_s3_bucket" "florianthomcom_www_bucket" {
  bucket = "www.${var.florianthomcom_bucket_name}"
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.florianthomcom_bucket_name}" })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.florianthomcom_domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404/index.html"
  }

  tags = var.florianthomcom_common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "florianthomcom_root_bucket" {
  bucket = var.florianthomcom_bucket_name
  acl    = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = var.florianthomcom_bucket_name })

  website {
    redirect_all_requests_to = "https://www.${var.florianthomcom_domain_name}"
  }

  tags = var.florianthomcom_common_tags
}