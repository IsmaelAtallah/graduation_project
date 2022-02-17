#!/bin/bash

terraform init

terraform apply -auto-approve

ansible-playbook -i ../../ansible/Inventory ../../ansible/grad.yml