# Cludus Workstation

Opinionated software responsible of preparing a workstation for optimal development with a wide pool of technologies

# Installation

This setup is intended to be used in kubuntu (for now), usually in a bare-metal machine, but can be used with a vm as well.

To install all software with one script run the following

    sudo apt update && sudo apt install curl wget git-all -y
    # ssh-keygen
    # cat ~/.ssh/id_rsa.pub
    # add public key to github in UserIcon -> Settings -> SH and GPG keys
    git clone git@github.com:cludus/workstation.git
    cd workstation
    ./workstation install

to test run the following script

    ./workstation test
