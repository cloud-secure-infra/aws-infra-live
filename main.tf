#############################################
# Root Terraform Configuration
#############################################
data "aws_caller_identity" "current" {}

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
  region = var.region
}


provider "aws" {
  alias  = "grafana_singapore"
  region = "ap-southeast-1"
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



module "kms" {
  source                  = "./modules/kms"
  github_actions_role_arn = "arn:aws:iam::661539128717:role/GitHubActionsFactoryRole"
}

module "observability" {
  source        = "./modules/observability"
  s3_bucket     = module.s3.metadata_bucket_name
  region        = var.region
  glue_role_arn = module.iam.glue_service_role_arn
}

module "s3" {
  source      = "./modules/s3"
  project     = "cloud-secure-infra"
  environment = "dev"
  owner       = "cloudops-team"
  cost_center = "CLOUDSEC001"
  region      = "ap-south-1"
}

# IAM Module (creates Glue service role)
module "iam" {
  source      = "./modules/iam"
  project     = "cloud-secure-infra"
  environment = "dev"
  github_repo = "os-hardening-orchestrator"
  owner       = "cloudops-team"
  cost_center = "CLOUDSEC001"
}

module "compliance" {
  source        = "./modules/compliance"
  bucket_name   = module.s3.metadata_bucket_name
  glue_role_arn = module.iam.glue_service_role_arn
  region        = var.aws_region
  environment   = var.environment
  project       = var.project
  depends_on    = [module.s3, module.iam]
}

module "opensearch" {
  source          = "./modules/opensearch"
  project         = var.project
  environment     = var.environment
  owner           = var.owner
  cost_center     = var.cost_center
  kms_key_id      = module.kms.kms_key_arn
  master_username = "admin"
  master_password = "SecurePass#2025!"
}

module "lambda_compliance_ingestor" {
  source = "./modules/lambda_compliance_ingestor"

  project             = var.project
  environment         = var.environment
  lambda_role_arn     = module.iam.lambda_execution_role_arn
  opensearch_endpoint = module.opensearch.opensearch_endpoint
  bucket_name         = module.s3.metadata_bucket_name
}


