output "os_hardened_ecr_url" {
  description = "ECR repository URL for os-hardened-images"
  value       = aws_ecr_repository.os_hardened_images.repository_url
}
