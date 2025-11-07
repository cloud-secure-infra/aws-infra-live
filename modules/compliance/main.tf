resource "aws_glue_catalog_database" "compliance_db" {
  name = "${var.project}-${var.environment}-compliance-db"
}

resource "aws_glue_crawler" "compliance_crawler" {
  name          = "${var.project}-${var.environment}-compliance-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.compliance_db.name
  s3_target {
    path = "s3://${var.bucket_name}/reports/"
  }

  configuration = jsonencode({
    Version = 1.0
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
  })

  schedule = "cron(0 3 * * ? *)" # Run daily at 3 AM UTC
}

resource "aws_athena_workgroup" "compliance_wg" {
  name = "${var.project}-${var.environment}-compliance-wg"

  configuration {
    result_configuration {
      output_location = "s3://${var.bucket_name}/athena-results/"
    }
    enforce_workgroup_configuration = true
  }
}
