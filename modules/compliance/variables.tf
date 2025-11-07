variable "bucket_name" {
  description = "Name of the S3 bucket that stores compliance scan data"
  type        = string
}

variable "glue_role_arn" {
  description = "IAM Role ARN for Glue service"
  type        = string
}

variable "region" {
  description = "AWS Region for resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}
