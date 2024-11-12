resource "aws_spot_instance_request" "this" {
  count                       = var.create && var.use_spot_instances ? 1 : 0
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = false

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

  # IAM Instance Profile as Input Variable
  iam_instance_profile = var.iam_instance_profile

  # Security group configuration
  vpc_security_group_ids = var.security_group_ids

  # User data configuration with proper encoding
  user_data                   = var.user_data != "" ? base64encode(var.user_data) : null
  user_data_replace_on_change = true

  # Root volume configuration with encryption
  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    tags                  = local.common_tags
  }

  # Additional EBS volumes if specified
  dynamic "ebs_block_device" {
    for_each = var.additional_ebs_volumes
    content {
      device_name           = ebs_block_device.value.device_name
      volume_size           = ebs_block_device.value.volume_size
      volume_type           = ebs_block_device.value.volume_type
      encrypted             = true
      delete_on_termination = true
      tags                  = local.common_tags
    }
  }

  # Spot instance specific settings
  spot_price                     = var.spot_price
  spot_type                      = "persistent"
  wait_for_fulfillment           = true
  instance_interruption_behavior = "terminate"

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true # Prevent accidental deletion
    ignore_changes = [
      # Prevent unintended changes to sensitive configurations
      user_data,
      user_data_base64,
    ]
  }

  # Required tags plus additional custom tags
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-${var.project}-spot-instance"
    },
    var.additional_tags
  )
}
