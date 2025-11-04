resource "aws_ecr_repository" "os_hardened_images" {
  name                 = "os-hardened-images"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project = "os-hardening-factory"
    ManagedBy = "cloud-secure-infra"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.os_hardened_images.repository_url
}
