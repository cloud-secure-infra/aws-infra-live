output "metadata_bucket_name" {
  description = "S3 bucket name for storing image metadata"
  value       = aws_s3_bucket.image_metadata.bucket
}

output "metadata_bucket_arn" {
  description = "ARN of the image metadata bucket"
  value       = aws_s3_bucket.image_metadata.arn
}

