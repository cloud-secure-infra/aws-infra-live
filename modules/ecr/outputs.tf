output "os_hardened_base_ecr_url" {
  description = "ECR URL for base hardened images"
  value       = aws_ecr_repository.os_hardened_base.repository_url
}

output "os_hardened_images_ecr_url" {
  description = "ECR URL for derived hardened images"
  value       = aws_ecr_repository.os_hardened_images.repository_url
}
