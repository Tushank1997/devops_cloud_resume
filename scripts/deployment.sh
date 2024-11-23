#!/bin/bash

#checkout infra repository
cd infra

#initialize terrafrom providers
terraform init

#apply terrafrom infrastructure
terraform apply --auto-approve
