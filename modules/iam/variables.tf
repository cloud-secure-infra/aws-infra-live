###############################################
# IAM MODULE - INPUT VARIABLES
###############################################

# -------------------------------------------------------------------
# GitHub Repository for OIDC Trust
# -------------------------------------------------------------------
variable "github_repo" {
  description = <<EOT
The GitHub repository in 'org/repo' format that will assume this IAM role
via GitHub OIDC. This controls which repo can run Terraform or push to ECR.
Example: "cloud-secure-infra/aws-infra-live"
EOT
  type        = string
  default     = "cloud-secure-infra/aws-infra-live"
}

# -------------------------------------------------------------------
# Project Metadata for Tagging
# -------------------------------------------------------------------
variable "project" {
  description = "Project name used for tagging AWS resources managed by Terraform."
  type        = string
  default     = "os-hardening-factory"
}

# -------------------------------------------------------------------
# Environment Metadata for Tagging
# -------------------------------------------------------------------
variable "environment" {
  description = "Environment identifier for tagging (e.g., dev, demo, staging, prod)."
  type        = string
  default     = "demo"
}
