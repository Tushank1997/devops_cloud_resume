#!bin/bash

#downloading remote tfstate file into runner machine's copied git repository
aws s3 cp s3://tfstate-bucket-1.0/terraform-backend.tfstate cloud_resume/

#changing directory to git repository
cd cloud_resume

#intializing terraform providers
terraform init

#destroying terraform resources 
terraform destroy --auto-approve