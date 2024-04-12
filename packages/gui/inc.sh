#!/bin/bash


function install_chrome {
    if ! command -v google-chrome-stable &> /dev/null
    then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        sudo apt --fix-broken install
        rm google-chrome-stable_current_amd64.deb
    fi
}


function install_editors {
    sudo snap install code --classic
    sudo snap install atom --classic
}
