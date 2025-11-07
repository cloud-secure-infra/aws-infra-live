variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging (e.g., dev, prod)"
  type        = string
}

variable "owner" {
  description = "Owner of the resource (for governance and audit)"
  type        = string
}

variable "cost_center" {
  description = "Cost center for billing and tracking"
  type        = string
}

variable "governance_tags" {
  description = "Map of standard governance tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy  = "Terraform"
    Compliance = "CIS-Benchmark"
  }
}