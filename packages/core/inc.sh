#!/bin/bash

function install_basic_tools {
    # network tools, git and some parsers
    printf "${iwhite}##################################################\n"
    printf "installing basic tools\n"
    printf "##################################################\n${clear}"

    # sudo apt update
    sudo apt install curl wget git-all net-tools iproute2 \
        netcat dnsutils iputils-ping iptables nmap tcpdump \
        traceroute openssl jq -y
    if ! [ -x "$(command -v yq)" ]; then
        snap install yq --channel=v3/stable
    fi

    # neovim :)
    if ! [ -x "$(command -v nvim)" ]; then
        sudo apt install neovim -y
    fi

    grep -q "alias vi=neovim" ~/.bashrc
    if [[ $? != 0 ]];
    then
        printf 'alias vi=neovim' >> ~/.bashrc
    fi

}

function check_status {
    status=$1
    test_name=$2
    if [ $status -ne 0 ]; then
        printf "${red}$test_name failed${clear}\n"
    else 
        printf "${green}$test_name successful${clear}\n" 
    fi
}

function test_command {
    if ! [ -x "$(command -v $1)" ]; then
        printf "${red}$1 is not installed${clear}\n" 
    else 
        printf "${green}$1 is installed${clear}\n" 
    fi
}

function test_basic_tools {
    # test git
    git clone https://github.com/go-nv/goenv ./github-test > /dev/null 2>&1
    check_status $? "git"
    rm -rf ./github-test

    # test curl
    curl https://www.google.com/ > /dev/null 2>&1
    check_status $? "curl"

    # test wget
    wget https://www.google.com/ -O /dev/null > /dev/null 2>&1
    check_status $? "wget"

    test_command jq
    test_command yq
    test_command nvim
}