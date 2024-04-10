#!/bin/bash

function install_ansible {
    if ! command -v ansible &> /dev/null
    then
        pip install --user ansible
    fi

    grep -q 'export PATH=$PATH:~/.local/bin' ~/.bashrc
    if [[ $? != 0 ]];
    then
        echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
        source ~/.bashrc
    fi
}

function test_ansible {
    dir="$rootdir/packages/vms/ansible/tests"
    cd $dir \
        && ansible-playbook -i inventory playbook.yml > /dev/null 2>&1
    check_status $? "ansible"
    cd $rootdir
}