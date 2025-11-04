# =========================================================
# IAM Module — GitHub OIDC Trust + Full Admin (Demo Purpose)
# =========================================================

# --- Fetch GitHub OIDC Provider ---
data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::661539128717:oidc-provider/token.actions.githubusercontent.com"
}

# --- Create Dynamic Assume Role Policy for Multiple GitHub Repos ---
data "aws_iam_policy_document" "github_oidc_assume" {
  statement {
    sid    = "GitHubOIDCTrust"
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    # Trust both repos dynamically
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [for repo in var.github_repo : "repo:${repo}:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# --- IAM Role for GitHub Actions (Shared Across Repos) ---
resource "aws_iam_role" "github_oidc_role" {
  name               = "GitHubOIDC-ECRPushRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume.json

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# --- Full Access Policy (Demo Only — Replace in Prod) ---
resource "aws_iam_role_policy" "github_oidc_full_access" {
  name = "GitHubOIDC-FullAccess"
  role = aws_iam_role.github_oidc_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "FullAccess"
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}
