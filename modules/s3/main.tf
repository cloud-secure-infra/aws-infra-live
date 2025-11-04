#############################################
# S3 Module — Image Metadata & Changelogs
#############################################

resource "aws_s3_bucket" "image_metadata" {
  bucket = "${var.project}-${var.environment}-image-metadata"

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
