data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid     = "AllowRoot"
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowGitHubActionsRole"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.github_actions_role_arn]
    }
    actions = [
      "kms:DescribeKey",
      "kms:GetPublicKey",
      "kms:Sign"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "cosign" {
  description              = var.description
  deletion_window_in_days  = 30
  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "ECC_NIST_P256"
  policy                   = data.aws_iam_policy_document.kms_policy.json

  # ⚠️ Rotation not supported for asymmetric keys
  enable_key_rotation = false

  tags = {
    Name = var.key_name
  }
}


resource "aws_kms_alias" "cosign_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.cosign.key_id
}
