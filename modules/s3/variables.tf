variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

variable "cost_center" {
  description = "Cost center for resource tracking"
  type        = string
}

variable "governance_tags" {
  description = "Common governance tags applied to all resources"
  type        = map(string)
  default     = {}
}
