##########################################
# Observability Stack — Glue + Athena
##########################################


# -----------------------------
# Glue Database
# -----------------------------
resource "aws_glue_catalog_database" "compliance_db" {
  name        = "hardened_compliance_db"
  description = "Glue database storing metadata and CVE reports for hardened OS images"
}

# -----------------------------
# Glue Crawler
# -----------------------------
resource "aws_glue_crawler" "compliance_crawler" {
  name          = "compliance-reports-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.compliance_db.name

  s3_target {
    path = "s3://${var.s3_bucket}/"
  }

  schedule = "cron(0 0 * * ? *)" # Runs every midnight UTC

  configuration = jsonencode({
    Version = 1.0
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
  })

  tags = {
    Environment = "dev"
    Component   = "observability"
  }
}

# -----------------------------
# Athena Workgroup
# -----------------------------
resource "aws_athena_workgroup" "compliance_wg" {
  name = "hardened_compliance_wg"

  configuration {
    enforce_workgroup_configuration = true
    result_configuration {
      output_location = "s3://${var.s3_bucket}/athena-results/"
    }
  }

  tags = {
    Environment = "dev"
    Component   = "observability"
  }
}

# -----------------------------
# Optional Glue Crawler Trigger
# -----------------------------
resource "aws_glue_trigger" "daily_crawler_trigger" {
  name     = "daily-crawler-trigger"
  type     = "SCHEDULED"
  schedule = "cron(0 0 * * ? *)"

  actions {
    crawler_name = aws_glue_crawler.compliance_crawler.name
  }

  depends_on = [aws_glue_crawler.compliance_crawler]
}
