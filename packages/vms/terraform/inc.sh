#!/bin/bash

function install_terraform {
    if ! command -v terraform &> /dev/null
    then
        sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
        wget -O- https://apt.releases.hashicorp.com/gpg | \
            gpg --dearmor | \
            sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
        gpg --no-default-keyring \
            --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
            --fingerprint

        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
            https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
            sudo tee /etc/apt/sources.list.d/hashicorp.list

        sudo apt-get install terraform -y
    fi
}

function test_terraform {
    dir="$rootdir/packages/vms/terraform/tests"
    cd $dir && \
        terraform init -input=false > /dev/null 2>&1 \
        && terraform apply -input=false -auto-approve > /dev/null 2>&1 \
        && terraform destroy -input=false -auto-approve > /dev/null 2>&1
    check_status $? "terraform"
}
