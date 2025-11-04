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
  region = "us-east-1"
}

# Example: ECR repo for hardened images
module "ecr" {
  source = "./modules/ecr"
}

# Include the ECR module to provision repository
module "os_hardened_ecr" {
  source = "./modules/ecr"
}

output "os_hardened_ecr_url" {
  value = module.os_hardened_ecr.ecr_repository_url
}

# IAM role for GitHub OIDC trust (used by os-hardening-factory pipelines)
module "github_oidc_role" {
  source = "./modules/iam"
}

