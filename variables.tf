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

variable "github_repo" {
  description = "GitHub repository in org/repo format for OIDC trust"
  type        = string
  default     = "os-hardening-factory/os-hardening-factory"
}
