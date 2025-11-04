# -------------------------------------------
# Outputs for IAM Module
# -------------------------------------------

output "github_oidc_role_arn" {
  description = "IAM role ARN used by GitHub Actions for OIDC authentication"
  value       = aws_iam_role.github_oidc_role.arn
}
