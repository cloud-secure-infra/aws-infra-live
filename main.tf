#############################################
# Root Terraform Configuration
#############################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#############################################
# ECR Module - OS Hardening Factory
#############################################

module "os_hardened_ecr" {
  source      = "./modules/ecr"
  project     = "os-hardening-factory"
  environment = var.environment
}

#############################################
# IAM Role Module - GitHub OIDC Integration
#############################################

module "github_oidc_role" {
  source      = "./modules/iam"
  project     = "os-hardening-factory"
  environment = var.environment
  github_repo = var.github_repo
}
