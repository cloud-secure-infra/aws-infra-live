# ============================================================
# Terraform Variables — Governance, Tagging, and Metadata
# ============================================================

region      = "ap-south-1"
environment = "dev"

# Governance & Tagging
project     = "cloud-secure-infra"
owner       = "manivarma"
cost_center = "COST-OPS-001"

# GitHub OIDC (used for IAM module trust)
github_repo = "os-hardening-factory/os-hardening-factory"
