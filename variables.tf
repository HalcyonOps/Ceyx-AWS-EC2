# modules/compute/ec2/variables.tf

# Basic Configuration Variables
variable "create" {
  description = "Whether to create the EC2 instance."
  type        = bool
  default     = true
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use for the EC2 instance."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type        = string
}

variable "key_name" {
  description = "The key pair name to use for the EC2 instance."
  type        = string
}

# Metadata Options
variable "metadata_options" {
  description = "Metadata options for the EC2 instance."
  type = object({
    http_endpoint               = string
    http_tokens                 = string
    http_put_response_hop_limit = number
    instance_metadata_tags      = bool
  })
}

# EBS Optimization
variable "enable_ebs_optimization" {
  description = "Enable EBS optimization for the EC2 instance."
  type        = bool
  default     = true
}

# Tags
variable "tags" {
  description = "Additional tags to apply to the EC2 instance."
  type        = map(string)
  default     = {}
}

# Feature Toggles
variable "use_spot_instances" {
  description = "Whether to use Spot Instances for the EC2 deployment."
  type        = bool
  default     = false
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)."
  type        = string
}

variable "project" {
  description = "Project name for tagging and identification."
  type        = string
}

variable "owner" {
  description = "Owner of the EC2 instance."
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the EC2 instance."
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of Security Group IDs to attach to the EC2 instance."
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = string
  default     = ""
}

variable "user_data_base64" {
  description = "The base64 encoded user data to provide when launching the instance."
  type        = string
  default     = ""
}

variable "spot_price" {
  description = "The maximum price for Spot Instances."
  type        = string
  default     = ""
}
