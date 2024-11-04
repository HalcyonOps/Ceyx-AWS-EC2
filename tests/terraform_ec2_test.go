// modules/compute/ec2/test/terraform_ec2_test.go

package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestEC2Module(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
        TerraformDir: "../",

        Vars: map[string]interface{}{
            "create":        true,
            "name":          "test-ec2",
            "environment":   "dev",
            "project":       "Ceyx",
            "vpc_id":        "vpc-12345678",
            "subnet_id":     "subnet-12345678",
            "instance_type": "t3.micro",
            "ami_id":        "ami-0abcdef1234567890",
        },

        NoColor: true,
    }

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    instanceID := terraform.Output(t, terraformOptions, "instance_id")
    assert.NotEmpty(t, instanceID)
}
