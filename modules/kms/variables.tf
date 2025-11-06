variable "description" {
  type        = string
  description = "Description for the KMS key"
  default     = "KMS key for container signing (cosign)"
}

variable "key_name" {
  type        = string
  description = "Name tag for the key"
  default     = "cosign-signing"
}

variable "alias_name" {
  type        = string
  description = "Alias name for the KMS key"
  default     = "cosign-signing"
}

variable "github_actions_role_arn" {
  type        = string
  description = "IAM role ARN for GitHub Actions OIDC to sign images"
}
