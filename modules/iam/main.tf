############################################
# IAM Role for GitHub OIDC → ECR Push Access
############################################

# Data source: GitHub OIDC provider in AWS account
data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::661539128717:oidc-provider/token.actions.githubusercontent.com"
}

# IAM Role for GitHub Actions (os-hardening-factory)
resource "aws_iam_role" "github_oidc_role" {
  name = "GitHubOIDC-ECRPushRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            # Trust only this repo under os-hardening-factory org
            "token.actions.githubusercontent.com:sub" = "repo:os-hardening-factory/os-hardening-factory:*"
          }
        }
      }
    ]
  })
}

# Policy granting push rights to ECR
resource "aws_iam_role_policy" "ecr_push_policy" {
  name = "ECRPushPolicy"
  role = aws_iam_role.github_oidc_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      }
    ]
  })
}

# Output the role ARN for reference
output "aws_iam_role_github_oidc_role_arn" {
  value = aws_iam_role.github_oidc_role.arn
}
