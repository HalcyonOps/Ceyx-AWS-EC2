# EC2 Module

A Terraform module to provision AWS EC2 instances with configurable security groups, adhering to security best practices and organizational standards.

## Overview

This module creates EC2 instances with:
- Specified AMI and instance type
- Placement within designated subnets
- Security groups with controlled inbound and outbound traffic
- Optional SSH key association

## Usage

```terraform
module "ec2" {
    source = "./modules/compute/ec2"
    create = true
    name = "my-ec2-instance"
    environment = "prod"
    project = "Ceyx"
    owner = "DevOps Team"
    vpc_id = "vpc-12345678"
    subnet_id = "subnet-12345678"
    instance_type = "t3.medium"
    ami_id = "ami-0abcdef1234567890"
    associate_public_ip_address = false
    tags = {
        Department = "Engineering"
        CostCenter = "12345"
    }
}
```

## Example

Check out the [examples](../../examples/) directory for practical implementation examples.

## Testing

Ensure all tests pass by running:

```bash
terraform init -backend=false
terraform validate
```

## License

This module is licensed under the [Apache License 2.0](../../LICENSE).

## Contributing

Please refer to our [Contributing Guide](../../CONTRIBUTING.md) for details on how to contribute to this module.
