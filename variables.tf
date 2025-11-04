# ============================================
# Root Variables (for all modules)
# ============================================

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name for tagging and identification"
  type        = string
  default     = "cloud-secure-infra"
}

# 👇 Add this new one
variable "github_repo" {
  description = "List of GitHub repositories that can assume the OIDC role"
  type        = list(string)
  default = [
    "cloud-secure-infra/aws-infra-live",
    "os-hardening-factory/os-hardening-factory"
  ]
}
