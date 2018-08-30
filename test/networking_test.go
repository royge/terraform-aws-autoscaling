package main

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

// TestNetworking tests /terraform/modules/networking/ module
func TestNetworking(t *testing.T) {
	t.Parallel()

	uniqueID := random.UniqueId()
	name := fmt.Sprintf("terratest-%s", uniqueID)
	awsRegion := aws.GetRandomRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "../terraform/modules/networking",

		Vars: map[string]interface{}{
			"region": awsRegion,
			"name":   name,
			"cidr_blocks": []string{
				"10.0.0.0/16",
				"10.0.1.0/24",
				"10.0.2.0/24",
			},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
