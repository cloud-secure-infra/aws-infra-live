# Output the ARN of the GitHub OIDC role
output "github_oidc_role_arn" {
  value = module.github_oidc_role.aws_iam_role_github_oidc_role_arn
}
