# IAC-demo
Infrastructure demo

This repo installs Harbor registry repo.

Harbor is an open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted

Steps to deploy it in AWS :

Create base image using packer. https://www.packer.io/ Install packer and then run the following command from the demo-harbor/ami folder. Make sure to set AWS credentials in environment variable:

packer build --var-file=setting-aws.json image.json

This command will create a base image. You will find a new image in the AMI of your region.

Terraform TDD.

Unit Testing: I have used Conftest (https://www.conftest.dev/) for unit testing and enforcing policies. It uses rego language I have created a Makefile To run unit tests run make unit.

Contract testing: I have used this to test the the variables are properly set and to test some overall logic. To run contract testing run make contract.

Integration testing or end to end testing: This testing I have terraform apply to provision the resource and then have used Terratest for testing that resource has been properly created. To run integration testing, run make integration
