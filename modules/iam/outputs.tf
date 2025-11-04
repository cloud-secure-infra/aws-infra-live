output "github_oidc_role_arn" {
  description = "ARN of the IAM Role trusted by GitHub OIDC provider"
  value       = aws_iam_role.github_oidc_role.arn
}
