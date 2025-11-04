# ===========================================
# IAM Module - GitHub OIDC Trust + Full Access (Demo)
# ===========================================

# Fetch existing GitHub OIDC Provider
data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::661539128717:oidc-provider/token.actions.githubusercontent.com"
}

# Build the OIDC trust relationship dynamically
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
      values   = ["repo:${var.github_repo}:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# -------------------------------------------
# Create IAM Role for GitHub OIDC Workflows
# -------------------------------------------
resource "aws_iam_role" "github_oidc_role" {
  name               = "GitHubOIDC-ECRPushRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume.json

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# -------------------------------------------
# Attach Full Admin Policy (Demo Purpose Only)
# -------------------------------------------
resource "aws_iam_role_policy" "github_oidc_admin_policy" {
  name = "GitHubOIDC-FullAccess"
  role = aws_iam_role.github_oidc_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

# Grant full IAM + ECR permissions for demo pipelines
resource "aws_iam_role_policy" "ecr_push_policy" {
  name = "ECRPushPolicy"
  role = aws_iam_role.github_oidc_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "FullECRAccess"
        Effect   = "Allow"
        Action   = [
          "ecr:*",
          "iam:*",
          "sts:*",
          "logs:*",
          "cloudwatch:*"
        ]
        Resource = "*"
      }
    ]
  })
}

