variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, stage, prod)"
  type        = string
}

variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository (org/repo) used for OIDC trust"
  type        = string
}

#############################################
# Governance & Tagging Variables
#############################################

variable "owner" {
  description = "Primary owner or team responsible for the resource"
  type        = string
  default     = "cloudops-team"
}

variable "cost_center" {
  description = "Cost center or business unit for chargeback"
  type        = string
  default     = "CC1001"
}

variable "governance_tags" {
  description = "Map of standard governance tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy  = "Terraform"
    Compliance = "CIS-Benchmark"
  }
}
