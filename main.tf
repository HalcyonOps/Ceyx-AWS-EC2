resource "aws_instance" "this" {
  count                       = var.create ? 1 : 0
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

  # Root Block Device with Encryption
  root_block_device {
    volume_size = 8
    encrypted   = true
  }

  # Tags
  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
  }
}
