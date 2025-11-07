

output "opensearch_dashboard_url" {
  value = aws_opensearch_domain.compliance_dashboard.dashboard_endpoint
}


output "aws_opensearch_domain_endpoint" {
  description = "The endpoint of the OpenSearch domain"
  value       = aws_opensearch_domain.compliance_dashboard.endpoint
}

output "aws_opensearch_domain_arn" {
  description = "The ARN of the OpenSearch domain"
  value       = aws_opensearch_domain.compliance_dashboard.arn
}

# OpenSearch domain endpoint
output "opensearch_endpoint" {
  description = "Endpoint URL of the OpenSearch domain"
  value       = aws_opensearch_domain.compliance_dashboard.endpoint
}
