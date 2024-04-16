# Cludus Workstation

Opinionated software responsible of preparing a workstation for optimal development with a wide pool of technologies

# Installation

This setup is intended to be used in kubuntu (for now), usually in a bare-metal machine, but can be used with a vm as well.

To install all software with one script run the following

    sudo apt update && sudo apt install git-all -y
    git clone https://github.com/cludus/workstation ~/.workstation
    ~/.workstation/workstation install

to test run the following script

    ./workstation test

to setup github ssh keys do the following

    # ssh-keygen
    # cat ~/.ssh/id_rsa.pub
    # add public key to github in UserIcon -> Settings -> SSH and GPG keys
