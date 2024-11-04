resource "aws_instance" "spot" {
  count                       = var.use_spot_instances ? 1 : 0
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = false

  # Security Groups
  vpc_security_group_ids = var.security_group_ids

  # User Data
  user_data        = var.user_data
  user_data_base64 = var.user_data_base64

  # Metadata Options
  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = "required" # Enforce IMDSv2
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  # EBS Optimization
  ebs_optimized = var.enable_ebs_optimization

  # Detailed Monitoring
  monitoring = true

  # IAM Instance Profile
  iam_instance_profile = var.iam_instance_profile

  # Instance Market Options for Spot Instances
  instance_market_options {
    market_type = "spot"

    spot_options {
      max_price                      = var.spot_price != "" ? var.spot_price : null
      spot_instance_type             = "one-time"
      instance_interruption_behavior = "terminate"
    }
  }

  # Root Block Device with Encryption
  root_block_device {
    volume_size = 8
    encrypted   = true
  }

  # Tags
  tags = merge(
    {
      Environment = var.environment
      Project     = var.project
      Owner       = var.owner
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
  }
}
