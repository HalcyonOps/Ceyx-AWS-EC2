provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  vpc_id = module.vpc.vpc_id
}

# Example of variable definitions
variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

# Example of outputs
output "vpc_id" {
  description = "The ID of the VPC created by the vpc module."
  value       = module.vpc.vpc_id
}

output "ec2_instance_ids" {
  description = "The IDs of the EC2 instances created by the ec2_instance module."
  value       = module.ec2_instance.instance_ids
}
