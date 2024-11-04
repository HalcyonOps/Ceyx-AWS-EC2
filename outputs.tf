output "instance_ids" {
  description = "List of EC2 Instance IDs"
  value       = [for instance in aws_instance.this : instance.id]
}

output "instance_public_ips" {
  description = "List of EC2 Instance Public IPs"
  value       = [for instance in aws_instance.this : instance.public_ip]
}

output "instance_private_ips" {
  description = "List of EC2 Instance Private IPs"
  value       = [for instance in aws_instance.this : instance.private_ip]
}

output "instance_security_group_ids" {
  description = "List of EC2 Instance Security Group IDs"
  value       = [for instance in aws_instance.this : instance.vpc_security_group_ids]
}
