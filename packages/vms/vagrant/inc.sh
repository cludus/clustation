#!/bin/bash

function install_vagrant {
    if ! command -v vagrant &> /dev/null
    then
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install vagrant -y

        # vagrant libvirt
        sudo apt install libvirt-dev -y
        vagrant plugin install vagrant-libvirt
        echo "export VAGRANT_DEFAULT_PROVIDER=libvirt" >> ~/.bashrc
        source ~/.bashrc
    fi
}

function test_vagrant {
    cd "vagrant_tests" \
        && vagrant up > /dev/null 2>&1 \
        && vagrant destroy -f > /dev/null 2>&1
    check_status $? "vagrant"
    cd $rootdir
}