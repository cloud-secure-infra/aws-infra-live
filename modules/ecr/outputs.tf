# -------------------------------------------
# Outputs for ECR Module
# -------------------------------------------

output "os_hardened_ecr_url" {
  value       = aws_ecr_repository.os_hardened_images.repository_url
  description = "ECR repository URL for os-hardened-images"
}

output "os_hardened_base_ecr_url" {
  value       = aws_ecr_repository.os_hardened_base.repository_url
  description = "ECR repository URL for os-hardened-base"
}
