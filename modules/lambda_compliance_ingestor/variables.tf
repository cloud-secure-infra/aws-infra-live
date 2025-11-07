variable "project" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, qa, prod)"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for the Lambda function"
  type        = string
}

variable "opensearch_endpoint" {
  description = "Endpoint of the OpenSearch domain for ingestion"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for compliance data"
  type        = string
}
