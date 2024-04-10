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