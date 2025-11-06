output "kms_key_arn" {
  description = "The ARN of the KMS signing key"
  value       = aws_kms_key.cosign.arn
}

output "kms_alias_arn" {
  description = "The ARN of the KMS key alias"
  value       = aws_kms_alias.cosign_alias.arn
}
