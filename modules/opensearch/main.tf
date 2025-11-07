terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_opensearch_domain" "compliance_dashboard" {
  domain_name = "infraos-${var.environment}"

  engine_version = "OpenSearch_2.13"

  cluster_config {
    instance_type = "t3.small.search"
    instance_count = 2
    zone_awareness_enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 20
    volume_type = "gp3"
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = "arn:aws:kms:ap-south-1:661539128717:key/64c7e210-a1a0-40d3-80f9-8e7f8527cdf9"
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action   = "es:*"
        Resource = "*"
      }
    ]
  })

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = var.master_username
      master_user_password = var.master_password
    }
  }

  tags = {
    Name        = "${var.project}-opensearch"
    Environment = var.environment
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}
