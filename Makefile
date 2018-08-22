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
apply-infra:
	cd terraform/env/$(ENV) &&\
		terraform apply "$(ENV)-infra.plan"

# Destroy existing infrastructure
# WARNING: This is dangerous!!!
destroy:
	cd terraform/env/$(ENV) &&\
		terraform destroy --force
