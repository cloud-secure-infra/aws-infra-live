output "os_hardened_ecr_url" {
  description = "ECR repository URL for os-hardened-images"
  value       = module.os_hardened_ecr.os_hardened_ecr_url
}

output "github_oidc_role_arn" {
  description = "IAM Role ARN for GitHub OIDC integration"
  value       = module.github_oidc_role.github_oidc_role_arn
}

output "metadata_bucket_name" {
  description = "S3 bucket for storing image metadata"
  value       = module.image_metadata_s3.metadata_bucket_name
}

output "metadata_bucket_arn" {
  description = "ARN of the S3 bucket storing image metadata"
  value       = module.image_metadata_s3.metadata_bucket_arn
}
