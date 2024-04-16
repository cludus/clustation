#!/bin/bash

function install_qemuagent {
    sudo apt update && sudo apt -y install qemu-guest-agent \
        && systemctl enable qemu-guest-agent \
        && systemctl start qemu-guest-agent \
        && systemctl status qemu-guest-agent
}

function test_qemuagent {

}
