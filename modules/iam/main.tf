# ===========================================
# IAM Module - GitHub OIDC Trust + Full Access (Demo)
# ===========================================

data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::661539128717:oidc-provider/token.actions.githubusercontent.com"
}

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
      values   = ["repo:os-hardening-factory/os-hardening-factory:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_oidc_role" {
  name               = "GitHubOIDC-ECRPushRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume.json

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Grant full access for demo (can tighten later)
resource "aws_iam_role_policy" "github_oidc_full_access" {
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