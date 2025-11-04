###############################################
# ROOT MODULE OUTPUTS
###############################################

# -------------------------------------------
# IAM Module Outputs
# -------------------------------------------
output "github_oidc_role_arn" {
  description = "ARN of the GitHub OIDC role created in the IAM module"
  value       = module.github_oidc_role.github_oidc_role_arn
}

# -------------------------------------------
# ECR Module Outputs
# -------------------------------------------
output "os_hardened_ecr_url" {
  description = "ECR repository URL for hardened OS images"
  value       = module.os_hardened_ecr.os_hardened_ecr_url
}

output "os_hardened_base_ecr_url" {
  description = "ECR repository URL for base hardened images"
  value       = module.os_hardened_ecr.os_hardened_base_ecr_url
}
