variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

variable "github_repo" {
  description = "List of GitHub repositories allowed to assume the OIDC role"
  type        = list(string)
}