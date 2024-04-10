# Cludus Workstation

Opinionated software responsible of preparing a workstation for optimal development with a wide pool of technologies

# Installation

This setup is intended to be use in kubuntu (for now), usually in a bare-metal machine, but can be used with a vm as well.

To install all software with one script run the following

    sudo apt install curl wget git-all -y
    git clone https://github.com/cludus/workstation
    cd workstation
    ./workstation install

to test run the following script

    ./workstation test
