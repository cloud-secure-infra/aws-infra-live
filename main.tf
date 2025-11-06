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
  project     = var.project
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  governance_tags = {
    ManagedBy  = "Terraform"
    Compliance = "CIS-Baseline"
  }
}

#############################################
# IAM Role Module - GitHub OIDC Integration
#############################################

module "github_oidc_role" {
  source      = "./modules/iam"
  project     = var.project
  environment = var.environment
  github_repo = var.github_repo
  owner       = var.owner
  cost_center = var.cost_center
}

#############################################
# S3 Module - Image Metadata & Governance Store
#############################################

module "image_metadata_s3" {
  source      = "./modules/s3"
  project     = var.project
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center

  governance_tags = {
    ManagedBy  = "Terraform"
    Compliance = "CIS-Benchmark"
  }
}

module "kms" {
  source                  = "./modules/kms"
  github_actions_role_arn = "arn:aws:iam::661539128717:role/GitHubActionsFactoryRole"
}

