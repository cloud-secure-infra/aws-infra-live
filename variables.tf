# -------------------------------------------
# Global Variables for Terraform Root Module
# -------------------------------------------

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, qa, prod)"
  type        = string
  default     = "dev"
}


variable "project" {
  description = "Project name for tagging and identification"
  type        = string
  default     = "cloud-secure-infra"
}