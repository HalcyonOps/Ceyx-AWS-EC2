locals {
  required_tags = {
    Environment   = var.environment
    Project       = var.project
    Owner         = var.owner
    ManagedBy     = "terraform"
    SecurityLevel = var.security_level
    BackupPolicy  = var.backup_policy
  }

  common_tags = merge(
    local.required_tags,
    var.additional_tags
  )
}
