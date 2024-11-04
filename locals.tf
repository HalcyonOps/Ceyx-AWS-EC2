locals {
  common_tags = merge(
    {
      Environment = var.environment
      Project     = var.project
      Owner       = var.owner
    },
    var.tags
  )
}
