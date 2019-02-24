# Initialize terraform modules
init:
	cd env/$(ENV) &&\
		terraform init

validate:
	cd env/$(ENV) &&\
		terraform validate

# Create a plan for infrastructure template
plan:
	cd env/$(ENV) &&\
		terraform plan -out=$(ENV)-infra.plan

# Apply
apply:
	cd env/$(ENV) &&\
		terraform apply "$(ENV)-infra.plan"

# Destroy existing infrastructure
# WARNING: This is dangerous!!!
destroy:
	cd env/$(ENV) &&\
		terraform destroy --force

test-prepare:
	cd test && go mod vendor

# Before running this test, make sure to have `terraformtest.io` certificate
# added in `ap-southeast-1` region of you AWS account.
# If you have existing certificate you can modify `domain` and `awsRegion`
# variable values in the `autoscaling_test.go` file.
.PHONY: test
test:
	go test -v -run TestAutoscaling ./test -count=1

docker:
	docker run -it \
		-v $(PWD):/infra \
		-w /infra \
		--rm \
		-e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		-e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		royge/terraform \
		/bin/sh
