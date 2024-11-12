# modules/compute/ec2/variables.tf

#------------------------------------------------------------------------------
# General Configuration
#------------------------------------------------------------------------------
variable "create" {
  description = "Whether to create an EC2 instance"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "project" {
  description = "Project name for tagging and identification"
  type        = string
}

variable "owner" {
  description = "Owner of the EC2 instance"
  type        = string
}

#------------------------------------------------------------------------------
# Instance Configuration
#------------------------------------------------------------------------------
variable "ami_id" {
  description = "ID of the AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  validation {
    condition = contains([
      "c4", "c5", "c6", "d2", "g3", "g4", "i3", "m4", "m5", "m6",
      "p2", "p3", "r4", "r5", "r6", "x1", "x1e"
    ], split(".", var.instance_type)[0])
    error_message = "Selected instance type must support EBS optimization."
  }
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch the instance in"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance"
  type        = string
}

#------------------------------------------------------------------------------
# Storage Configuration
#------------------------------------------------------------------------------
variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "additional_ebs_volumes" {
  description = "Additional EBS volumes to attach to the instance"
  type = list(object({
    device_name = string
    volume_size = number
    volume_type = string
  }))
  default = []
}

variable "enable_ebs_optimization" {
  description = "Enable EBS optimization for the instance. Required for certain instance types."
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# Security Configuration
#------------------------------------------------------------------------------
variable "security_group_ids" {
  description = "List of Security Group IDs to attach to the instance"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile to associate with the instance"
  type        = string
  default     = null
}

variable "metadata_options" {
  description = "Metadata options for the instance"
  type = object({
    http_endpoint               = string
    http_put_response_hop_limit = number
    instance_metadata_tags      = string
  })
  default = {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
}

variable "security_level" {
  description = "Security level classification for the instance"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "high", "critical"], var.security_level)
    error_message = "Security level must be one of: standard, high, critical"
  }
}

variable "backup_policy" {
  description = "Backup policy type for the instance (none, standard, enhanced)"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["none", "standard", "enhanced"], var.backup_policy)
    error_message = "Backup policy must be one of: none, standard, enhanced"
  }
}

#------------------------------------------------------------------------------
# Instance Type Specific Configuration
#------------------------------------------------------------------------------
variable "use_spot_instances" {
  description = "Whether to use Spot Instances"
  type        = bool
  default     = false
}

variable "spot_price" {
  description = "Maximum price for Spot Instances"
  type        = string
  default     = null
}

variable "use_dedicated_host" {
  description = "Whether to use a Dedicated Host"
  type        = bool
  default     = false
}

variable "dedicated_host_id" {
  description = "ID of the Dedicated Host to launch the instance on"
  type        = string
  default     = null
}

variable "use_capacity_reservation" {
  description = "Whether to use Capacity Reservation"
  type        = bool
  default     = false
}

variable "capacity_reservation_id" {
  description = "ID of the Capacity Reservation to use"
  type        = string
  default     = null
}

#------------------------------------------------------------------------------
# Additional Configuration
#------------------------------------------------------------------------------
variable "user_data" {
  description = "User data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "cpu_credits" {
  description = "CPU credits option for T-series instances"
  type        = string
  default     = "standard"
}
