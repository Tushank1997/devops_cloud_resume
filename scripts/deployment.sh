#!/bin/bash

#checkout infra repository
cd cloud_resume

#initialize terrafrom providers
terraform init

#apply terrafrom infrastructure
terraform apply --auto-approve
