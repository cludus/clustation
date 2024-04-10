#!/bin/bash


function install_virtualization {
    sudo apt install cpu-checker -y
    sudo apt install qemu-kvm libvirt-daemon-system libguestfs-tools virt-manager virt-top -y
    sudo adduser $USER libvirt

    grep -q '#security_driver = "selinux"' ~/.bashrc
    if [[ $? != 0 ]];
    then
        sudo sed -i 's|#security_driver = "selinux"|security_driver = "none"|g' /etc/libvirt/qemu.conf
    fi
    
    sudo systemctl enable --now libvirtd
    sudo systemctl start libvirtd
}

function download_imgs {

    function do_download_img {
        if ! test -f "/var/lib/libvirt/images/$2"; then
            sudo wget "$1/$2" -O "/var/lib/libvirt/images/$2"
        else
           echo "file $2 exists" 
        fi
    }

    do_download_img "http://cloud-images.ubuntu.com/noble/current" "noble-server-cloudimg-amd64.img"
    do_download_img "http://cloud-images.ubuntu.com/jammy/current" "jammy-server-cloudimg-amd64.img"
    do_download_img "http://cloud-images.ubuntu.com/focal/current" "focal-server-cloudimg-amd64-disk-kvm.img"
}
