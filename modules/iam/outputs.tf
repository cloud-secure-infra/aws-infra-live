output "github_oidc_role_arn" {
  description = "ARN of the GitHub OIDC IAM role"
  value       = aws_iam_role.github_oidc_role.arn
}
