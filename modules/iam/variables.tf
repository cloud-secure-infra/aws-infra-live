variable "project" {
  description = "Project name for tagging"
  type        = string
  default     = "cloud-secure-infra"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "github_repo" {
  description = "GitHub repository in org/repo format for OIDC trust"
  type        = list(string)
  default     = [
    "cloud-secure-infra/aws-infra-live",
    "os-hardening-factory/os-hardening-factory"
  ]
}
