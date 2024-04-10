#!/bin/bash

rootdir=$(readlink -f "$0")
rootdir=$(dirname "$rootdir")
rootdir="$rootdir/tests"

source ./config.sh

red='\033[0;31m'
green='\033[0;32m'
clear='\033[0m'

cd $rootdir
source ~/.bashrc
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH=$PATH:~/.local/bin


# tests node 
test_node 4
test_node 6
test_node 8
test_node 10
test_node 12
test_node 14
test_node 16
test_node 18
test_node 20

# tests java
test_java 8
test_java 11
test_java 17
test_java 21

# tests python
test_python "3.8"
test_python "3.9"
test_python "3.10"
test_python "3.11"
test_python "3.12"

# tests dotnet
test_dotnet 6
test_dotnet 7
test_dotnet 8

# test golang
test_go 1.18
test_go 1.19
test_go 1.20
test_go 1.21
test_go 1.22

# IDEs and Editors
test_command code
test_command intellij-idea-ultimate
test_command clion
test_command datagrip
test_command goland
test_command pycharm-professional
test_command webstorm
test_command rider
test_command postman

# virtualization tools
test_vagrant
test_docker
test_lxc

# kubernetes tools
test_k3d
test_kind

# test terraform
test_terraform