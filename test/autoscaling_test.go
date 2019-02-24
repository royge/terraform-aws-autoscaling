package main

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

// TestAutoscaling tests /terraform/modules/autoscaling/ module
func TestAutoscaling(t *testing.T) {
	t.Parallel()
	uniqueID := random.UniqueId()
	name := fmt.Sprintf("terratest-%s", uniqueID)

	// Change this domain value to the one you registered in your ACM
	// certificate.
	domain := "terraformtest.io"

	// Choose a region in which you have the certificate of the domain.
	awsRegion := "ap-southeast-1"

	data, teardown := setup(t, awsRegion, uniqueID)
	defer teardown()

	terraformOptions := &terraform.Options{
		TerraformDir: "../",

		Vars: map[string]interface{}{
			"region":              awsRegion,
			"name":                name,
			"health_check_target": "HTTP:80/",
			"ami_names": []string{
				"ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*",
			},
			"ami_owners":             []string{"099720109477"},
			"instance_type":          "t2.micro",
			"domain":                 domain,
			"key_name":               data["key_name"].(string),
			"subnets":                data["subnets"].([]string),
			"security_groups":        []string{data["internal_sg"].(string)},
			"public_security_groups": []string{data["public_sg"].(string)},
		},
	}

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	elbDNS := terraform.Output(t, terraformOptions, "default_elb_dns")

	// It can take a minute or so for the Instance to boot up, so retry a few times
	maxRetries := 30
	timeBetweenRetries := 5 * time.Second

	// Verify that we get back a 200 OK with the expected "Hello Terraform!"
	http_helper.HttpGetWithRetry(
		t,
		"http://"+elbDNS,
		200,
		"Hello Terraform!",
		maxRetries,
		timeBetweenRetries,
	)
}

func setup(t *testing.T, awsRegion string, uniqueID string) (map[string]interface{}, func()) {
	name := fmt.Sprintf("terratest-%s", uniqueID)
	terraformOptions := &terraform.Options{
		TerraformDir: "royge/networking/aws",

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

	terraform.InitAndApply(t, terraformOptions)

	subnets := []string{
		terraform.Output(t, terraformOptions, "primary_subnet_id"),
		terraform.Output(t, terraformOptions, "secondary_subnet_id"),
	}

	// Create an EC2 KeyPair that we can use for SSH access
	keyPairName := fmt.Sprintf("terratest-ssh-example-%s", uniqueID)
	keyPair := aws.CreateAndImportEC2KeyPair(t, awsRegion, keyPairName)

	teardown := func() {
		aws.DeleteEC2KeyPair(t, keyPair)
		terraform.Destroy(t, terraformOptions)
	}

	internalSg := terraform.Output(t, terraformOptions, "internal_sg_id")
	publicSg := terraform.Output(t, terraformOptions, "public_sg_id")

	return map[string]interface{}{
		"subnets":     subnets,
		"internal_sg": internalSg,
		"public_sg":   publicSg,
		"key_name":    keyPairName,
	}, teardown
}
