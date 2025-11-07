variable "project" {}
variable "environment" {}
variable "owner" {}
variable "cost_center" {}
variable "kms_key_id" {}
variable "master_username" {
  description = "Admin username for OpenSearch Dashboard"
  type        = string
}
variable "master_password" {
  description = "Admin password for OpenSearch Dashboard"
  type        = string
  sensitive   = true
}
