variable "env" {
  description = "Current environment"
  type        = string
  default     = "production"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
  default = "florianthom.com"
}

variable "bucket_name" {
  description = "Name of the s3-bucket"
  type        = string
  default     = "florianthom.com"
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
  default = {Project = "florianthom.com"}
}