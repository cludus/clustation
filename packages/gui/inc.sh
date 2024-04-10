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

function install_jetbrain_pro {
    sudo snap install intellij-idea-ultimate --classic
    sudo snap install rider --classic
    sudo snap install goland --classic
    sudo snap install pycharm-professional --classic
    sudo snap install webstorm --classic
    sudo snap install datagrip --classic
    sudo snap install clion --classic
    sudo snap install rubymine --classic
}

function install_jetbrain_comm {
    sudo snap install pycharm-community --classic
    sudo snap install intellij-idea-community --classic
}