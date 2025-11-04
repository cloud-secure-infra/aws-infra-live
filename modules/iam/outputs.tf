output "github_oidc_role_arn" {
  description = "IAM Role ARN for GitHub OIDC"
  value       = aws_iam_role.github_oidc_role.arn
}
