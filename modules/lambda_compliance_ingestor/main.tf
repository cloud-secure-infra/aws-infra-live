resource "aws_lambda_function" "compliance_ingestor" {
  function_name = "${var.project}-compliance-ingestor-${var.environment}"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  # ✅ Use the zipped file now
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      BUCKET_NAME         = var.bucket_name
      OPENSEARCH_ENDPOINT = var.opensearch_endpoint
      INDEX_NAME          = "compliance-reports"
    }
  }

  timeout = 60
  memory_size = 128
}
