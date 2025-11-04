variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in org/repo format for OIDC trust"
  type        = string
}

variable "owner" {
  description = "Owner or responsible person/team for this resource"
  type        = string
}

variable "cost_center" {
  description = "Cost center or billing tag for governance"
  type        = string
}

variable "governance_tags" {
  description = "Map of standard governance tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy   = "Terraform"
    Compliance  = "CIS-Benchmark"
  }
}