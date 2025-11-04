# ===========================================
# IAM Module - GitHub OIDC Trust + Full Access (with Governance Tags)
# ===========================================

# Fetch existing GitHub OIDC Provider
data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::661539128717:oidc-provider/token.actions.githubusercontent.com"
}

# Build OIDC trust dynamically
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

  tags = merge(
    var.governance_tags,
    {
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      CostCenter  = var.cost_center
      ManagedBy   = "Terraform"
    }
  )
}

# -------------------------------------------
# Attach Full Access Policy (Demo Purpose)
# -------------------------------------------
resource "aws_iam_role_policy" "github_oidc_full_access" {
  name = "GitHubOIDC-FullAccess"
  role = aws_iam_role.github_oidc_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "FullDemoAccess"
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}
