# -------------------------
# IAM / OIDC / KMS Outputs
# -------------------------
output "github_oidc_role_arn" {
  description = "IAM Role ARN for GitHub OIDC integration"
  value       = module.github_oidc_role.github_oidc_role_arn
}

output "cosign_kms_key_arn" {
  description = "KMS ARN used for image signing"
  value       = module.kms.kms_key_arn
}

# -------------------------
# S3 / ECR Outputs
# -------------------------
output "metadata_bucket_name" {
  description = "Name of the S3 bucket for storing image metadata"
  value       = module.s3.metadata_bucket_name
}

output "metadata_bucket_arn" {
  description = "ARN of the S3 bucket for storing image metadata"
  value       = module.s3.metadata_bucket_arn
}

output "os_hardened_base_ecr_url" {
  description = "Base ECR repo URL for OS-hardened base images"
  value       = module.os_hardened_ecr.os_hardened_base_ecr_url
}

output "os_hardened_images_ecr_url" {
  description = "ECR repo URL for OS-hardened image variants"
  value       = module.os_hardened_ecr.os_hardened_images_ecr_url
}

# -------------------------
# Observability (Glue + Athena)
# -------------------------
output "glue_database_name" {
  description = "Glue database name for compliance data"
  value       = module.observability.glue_database_name
}

output "glue_crawler_name" {
  description = "Glue crawler name for compliance data"
  value       = module.observability.glue_crawler_name
}

output "athena_workgroup_name" {
  description = "Athena workgroup used for compliance queries"
  value       = module.observability.athena_workgroup_name
}



