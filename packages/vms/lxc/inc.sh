#!/bin/bash

function install_lxc {
    sudo apt install lxc
}

function test_lxc {
    ct_name=lxc-test-ct
    lxc-launch ubuntu:22.04 $ct_name > /dev/null 2>&1 \
        && lxc-stop $ct_name > /dev/null 2>&1 \
        && lxc-delete $ct_name > /dev/null 2>&1
    check_status $? "lxc"
}
