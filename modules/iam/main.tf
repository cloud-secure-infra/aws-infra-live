# ===========================================
# IAM Module — Shared GitHub OIDC Role for All Pipelines
# ===========================================

# Fetch existing GitHub OIDC Provider
data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::661539128717:oidc-provider/token.actions.githubusercontent.com"
}

# Define OIDC trust policy for multiple GitHub repos
data "aws_iam_policy_document" "github_oidc_assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:cloud-secure-infra/aws-infra-live:*",
        "repo:os-hardening-factory/os-hardening-factory:*"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# Shared OIDC IAM role for Terraform + Docker builds
resource "aws_iam_role" "github_oidc_role" {
  name               = "GitHubOIDC-SharedDemoRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume.json

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Full admin permissions (demo only — remove in production)
resource "aws_iam_role_policy" "github_oidc_full_access" {
  name = "GitHubOIDC-FullAccess"
  role = aws_iam_role.github_oidc_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "FullAccessDemo"
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}
