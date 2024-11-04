# Unit Test for EC2 Module

variables {
  instance_type = "t3.medium"
  ami_id        = "ami-0abcdef1234567890"
}

run "validate_instance_type" {
  command = plan

  assert {
    condition     = aws_instance.this.instance_type == var.instance_type
    error_message = "EC2 instance type does not match the expected value."
  }

  assert {
    condition     = aws_instance.this.ami == var.ami_id
    error_message = "EC2 AMI ID does not match the expected value."
  }
}
