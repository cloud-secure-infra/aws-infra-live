###############################################
# IAM MODULE - INPUT VARIABLES
###############################################

variable "github_repo" {
  description = "GitHub repository in the format 'org/repo' used for OIDC trust"
  type        = string
  default     = "cloud-secure-infra/aws-infra-live"
}

variable "project" {
  description = "Project name for tagging resources"
  type        = string
  default     = "os-hardening-factory"
}

variable "environment" {
  description = "Environment name for tagging (e.g., dev, stage, prod)"
  type        = string
  default     = "demo"
}
