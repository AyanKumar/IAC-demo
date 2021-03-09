TFPLAN = .tfplan

init:
	terraform init

unit:
	conftest test -p test/unit/vpc.rego vpc.tf
	conftest test -p test/unit/subnet.rego subnet.tf
	conftest test -p test/unit/igw.rego igw.tf
	conftest test -p test/unit/ec2.rego ec2.tf
	conftest test -p test/unit/securitygroup.rego securitygroup.tf
	terraform validate
	terraform fmt -recursive
	
contract:
	terraform plan -out $(TFPLAN) -var-file=terraform.tfvars
	terraform show -json $(TFPLAN) > $(TFPLAN).json
	conftest test -p test/contract/logic.rego $(TFPLAN).json
	
integration:
	cd test/intergration; go test -v -timeout 30m
	
apply:
	terraform apply
	
clean: 
	terraform destroy --force
	
