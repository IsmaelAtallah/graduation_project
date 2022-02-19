#!/bin/bash

terraform init

terraform apply -auto-approve -var-file=value.tfvars

ansible-playbook -i ../../ansible/Inventory ../../ansible/grad.yml
