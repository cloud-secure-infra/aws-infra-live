
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

output "os_hardened_base_ecr_url" {
  value = module.os_hardened_ecr.os_hardened_base_ecr_url
}

output "os_hardened_images_ecr_url" {
  value = module.os_hardened_ecr.os_hardened_images_ecr_url
}

output "cosign_kms_key_arn" {
  description = "KMS ARN used for image signing"
  value       = module.kms.kms_key_arn
}
