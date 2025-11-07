output "glue_database_name" {
  description = "Glue database name for compliance reports"
  value       = aws_glue_catalog_database.compliance_db.name
}

output "glue_crawler_name" {
  description = "Glue crawler name for compliance reports"
  value       = aws_glue_crawler.compliance_crawler.name
}

output "athena_workgroup_name" {
  description = "Athena workgroup name for compliance queries"
  value       = aws_athena_workgroup.compliance_wg.name
}
