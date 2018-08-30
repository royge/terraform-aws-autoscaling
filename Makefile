# Initialize terraform modules
init:
	cd terraform/env/$(ENV) &&\
		terraform init

validate:
	cd terraform/env/$(ENV) &&\
		terraform validate

# Create a plan for infrastructure template
plan:
	cd terraform/env/$(ENV) &&\
		terraform plan -out=$(ENV)-infra.plan

# Apply
apply:
	cd terraform/env/$(ENV) &&\
		terraform apply "$(ENV)-infra.plan"

# Destroy existing infrastructure
# WARNING: This is dangerous!!!
destroy:
	cd terraform/env/$(ENV) &&\
		terraform destroy --force

# Before running this test, make sure to have `tf.example.com` certificate
# added in `us-east-1` region of you AWS account.
# If you have existing certificate you can modify `domain` and `awsRegion`
# variable values in the `autoscaling_test.go` file.
test:
	go test -v -run TestAutoscaling ./test -count=1
