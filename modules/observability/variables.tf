variable "region" {
  description = "AWS region for Glue and Athena resources"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket name containing compliance and observability data"
  type        = string
}

variable "glue_role_arn" {
  description = "IAM role ARN used by AWS Glue Crawler to access S3"
  type        = string
}
