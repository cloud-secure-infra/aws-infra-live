#############################################
# ECR Repository Module - OS Hardened Images
#############################################

resource "aws_ecr_repository" "os_hardened_images" {
  name                 = "os-hardened-images"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  # Merge global governance + project-level tags
  tags = merge(
    var.governance_tags,
    {
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      CostCenter  = var.cost_center
    }
  )
}

#############################################
# ECR Lifecycle Policy - Retain Last 10 Images
#############################################

resource "aws_ecr_lifecycle_policy" "retain_latest" {
  repository = aws_ecr_repository.os_hardened_images.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain last 10 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 25
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
