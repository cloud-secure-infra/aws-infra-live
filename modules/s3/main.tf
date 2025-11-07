#############################################
# S3 Module — Image Metadata & Changelogs
#############################################

resource "aws_s3_bucket" "image_metadata" {
  bucket = "cloud-secure-infra-dev-image-metadata-ap-south-1"

  tags = merge(
    var.governance_tags,
    {
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      CostCenter  = var.cost_center
      Compliance  = "CIS-Benchmark"
      ManagedBy   = "Terraform"
    }
  )

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.image_metadata.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.image_metadata.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.image_metadata.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "athena_quicksight_access" {
  bucket = aws_s3_bucket.image_metadata.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAthenaAccess"
        Effect = "Allow"
        Principal = {
          Service = [
            "athena.amazonaws.com",
            "quicksight.amazonaws.com"
          ]
        }
        Action = [
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.image_metadata.arn}",
          "${aws_s3_bucket.image_metadata.arn}/*"
        ]
      }
    ]
  })
}

