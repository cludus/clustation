#!/bin/bash

function install_lxc {
    snap install lxd --channel=latest/stable
    sudo adduser $USER lxd
    lxc storage create local dir
    lxc profile device add default root disk path=/ pool=local
}

function test_lxc {
    ct_name=lxc-test-ct
    lxc launch ubuntu:22.04 $ct_name > /dev/null 2>&1 \
        && lxc stop $ct_name > /dev/null 2>&1 \
        && lxc delete $ct_name > /dev/null 2>&1
    check_status $? "lxc"
}