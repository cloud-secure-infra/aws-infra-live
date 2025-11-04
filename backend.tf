terraform {
  backend "s3" {
    bucket         = "cloud-secure-infra-terraform-state"
    key            = "aws-infra-live/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
