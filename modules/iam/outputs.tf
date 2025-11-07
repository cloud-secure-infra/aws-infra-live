output "github_oidc_role_arn" {
  description = "IAM Role ARN for GitHub OIDC"
  value       = aws_iam_role.github_oidc_role.arn
}

output "glue_service_role_arn" {
  description = "ARN of the IAM role used by AWS Glue service"
  value       = aws_iam_role.glue_service_role.arn
}

output "lambda_exec_role_arn" {
  value = aws_iam_role.lambda_exec_role.arn
}

output "lambda_execution_role_arn" {
  description = "IAM Role ARN for Lambda execution"
  value       = aws_iam_role.lambda_execution_role.arn
}

