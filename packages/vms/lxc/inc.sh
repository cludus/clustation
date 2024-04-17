#!/bin/bash

function install_lxc {
    sudo apt install lxc -y

    if ! test -f ~/.config/lxc/default.conf; then
        user_id=$(grep $USER /etc/subuid | awk -F ":" '{print $2,$3}')
        group_id=$(grep $USER /etc/subgid | awk -F ":" '{print $2,$3}')

        mkdir -p ~/.config/lxc
        echo "lxc.id_map = u 0 $user_id" > ~/.config/lxc/default.conf
        echo "lxc.id_map = g 0 $group_id" >> ~/.config/lxc/default.conf
        echo "lxc.network.type = veth" >> ~/.config/lxc/default.conf
        echo "lxc.network.link = lxcbr0" >> ~/.config/lxc/default.conf
        echo "$USER veth lxcbr0 2" | sudo tee -a /etc/lxc/lxc-usernet        
    fi
}

function test_lxc {
    ct_name=lxc-test-ct
    lxc-launch ubuntu:22.04 $ct_name > /dev/null 2>&1 \
        && lxc-stop $ct_name > /dev/null 2>&1 \
        && lxc-delete $ct_name > /dev/null 2>&1
    check_status $? "lxc"
}
