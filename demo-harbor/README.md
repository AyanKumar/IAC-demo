# Infrastructure demo
 This repo installs Harbor registry repo.
 https://goharbor.io/
 
 Harbor is an open source registry that 
 secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as   trusted
 
  I have concentrated more on TDD with infrastructure and deploying a simple app.
  You can find the architectural diagram under Diagram folder.
# Tools used:
  1. Packer : For builing image for harbor. http://packer.io/
  2. Terraform: For deploying resources in AWS. https://www.terraform.io/
  3. Conftest: For unit testing .tf files in order to enforce policies and checks. (https://www.conftest.dev/)
  4. Terratest: For end to end testing which will verify post the resources are deployed whether the dns url is accessible and resturn the correct statusCode.(https://terratest.gruntwork.io/)
  
 
 # Pre-requisite:
   You must have a valid AWS account.
   Your must create a hosted zone in AWS Route53 before proceeding with the deployment automation.



# Steps to deploy it in AWS :

# 1. Create base image using packer.
   https://www.packer.io/
   Install packer and then run the following command from the demo-harbor/ami folder. Make sure to set AWS credentials in environment variable:

   packer build --var-file=setting-aws.json image.json
   
   This command will create a base image. You will find a new image in the AMI of your region.


# 2. Terraform TDD.
   
   # Unit Testing:
   I have used Conftest (https://www.conftest.dev/) for unit testing and enforcing policies.
   It uses rego language
   I have created a Makefile 
   To run unit tests run : make unit.
   
   
   # Contract testing:
   I have used this to test the the variables are properly set and to test some overall logic.
   To run contract testing run:  make contract.

   # Integration testing or end to end testing:
    I have used Terratest(https://terratest.gruntwork.io/) to do terraform init, terraform apply and terraform destroy. It also checks if the external url is accessible and it return the correct status code. To run integration testing run: make integration.
    
   # To Deploy the infrastructure.
      Run: make apply to deploy the infrastructure. This will in turn cann terraform apply
    
    
   # After the infrasturucture is deployed, you can access the horbor server using the dns. This is the landing page you will see:
    ![image](https://user-images.githubusercontent.com/13837679/110481059-2af21c00-810d-11eb-8b59-ad9ce4d2b5b0.png)

   

   
