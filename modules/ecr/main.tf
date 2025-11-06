#############################################
# ECR Repository Module - OS Hardened Images
#############################################

# Base Hardened Image Repository
resource "aws_ecr_repository" "os_hardened_base" {
  name                 = "os-hardened-base"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    var.governance_tags,
    {
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      CostCenter  = var.cost_center
      Compliance  = "CIS-Benchmark"
      RepoType    = "Base"
    }
  )
}

# Derived / Application-Specific Hardened Image Repository
resource "aws_ecr_repository" "os_hardened_images" {
  name                 = "os-hardened-images"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    var.governance_tags,
    {
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      CostCenter  = var.cost_center
      Compliance  = "CIS-Baseline"
      RepoType    = "Derived"
    }
  )
}

#############################################
# ECR Lifecycle Policies
#############################################

# Base repo — keep last 5 images
resource "aws_ecr_lifecycle_policy" "retain_base_latest" {
  repository = aws_ecr_repository.os_hardened_base.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain last 5 base images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# Derived repo — keep last 25 images
resource "aws_ecr_lifecycle_policy" "retain_derived_latest" {
  repository = aws_ecr_repository.os_hardened_images.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain last 25 derived images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 25
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
