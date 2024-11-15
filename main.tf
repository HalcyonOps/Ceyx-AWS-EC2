resource "aws_instance" "this" {
  count                       = var.create ? 1 : 0
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = false

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # Enforce IMDSv2
    http_put_response_hop_limit = 1          # Restrict token propagation
    instance_metadata_tags      = "enabled"  # Enable instance tags in metadata
  }

  # EBS Optimization
  ebs_optimized = var.enable_ebs_optimization

  # Detailed Monitoring
  monitoring = true

  # IAM Instance Profile as Input Variable
  iam_instance_profile = var.iam_instance_profile

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes = [
      # Prevent unintended changes to sensitive configurations
      user_data,
      user_data_base64,
    ]
  }

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
    delete_on_termination = false # Prevent accidental data loss
    tags = merge(
      local.common_tags,
      {
        Name      = "${var.environment}-${var.project}-root-volume"
        Encrypted = "true"
      }
    )
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

  # Maintenance and recovery settings
  maintenance_options {
    auto_recovery = "default"
  }

  # Enclave options for sensitive workloads
  enclave_options {
    enabled = false
  }

  # Private DNS configuration
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
    hostname_type                     = "ip-name"
  }

  # Credit specification for T-series instances
  credit_specification {
    cpu_credits = var.cpu_credits
  }

  # Resource timeouts
  timeouts {
    create = "30m"
    update = "30m"
    delete = "1h"
  }

  # Required tags plus additional custom tags
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-${var.project}-instance"
    },
    var.additional_tags
  )
}
