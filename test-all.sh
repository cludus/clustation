#!/bin/bash

rootdir=$(readlink -f "$0")
rootdir=$(dirname "$rootdir")
rootdir="$rootdir/tests"

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

declare -A java_versions=([21]=21.0.2-amzn [17]=17.0.10-amzn [11]=11.0.22-amzn [8]=8.0.402-amzn)

function check_status {
    status=$1
    test_name=$2
    if [ $status -ne 0 ]; then 
        printf "${red}$test_name failed${clear}\n" 
    else 
        printf "${green}$test_name successful${clear}\n" 
    fi
}

function test_node {
    node_version=$1
    nvm use $node_version > /dev/null 2>&1 \
        && cd node_tests/node$node_version \
        && npm i > /dev/null 2>&1 \
        && npm run start > /dev/null 2>&1
    check_status $? "node$node_version"
    cd $rootdir
}

function test_java {
    java_version=$1
    sdk_version=${java_versions[$java_version]}
    sdk use java $sdk_version > /dev/null 2>&1 \
        && cd java_tests/mvn-jdk$java_version \
        && mvn install > /dev/null 2>&1
    check_status $? "java$java_version"
    cd $rootdir
}

function test_python {
    python_version=$1
    cd "python_tests/python$python_version" \
        && $(readlink $(pyenv which python)) . > /dev/null 2>&1
    check_status $? "python$python_version"
    cd $rootdir
}

function test_dotnet {
    dotnet_version=$1
    cd "dotnet_tests/DotNetTest$dotnet_version" \
        && dotnet build > /dev/null 2>&1 \
        && dotnet run > /dev/null 2>&1
    check_status $? "dotnet$dotnet_version"
    cd $rootdir
}

function test_go {
    go_version=$1
    cd "go_tests/go_test$go_version" \
        && go build > /dev/null 2>&1 \
        && ./go_test_app > /dev/null 2>&1
    check_status $? "go$go_version"
    cd $rootdir
}

function test_command {
    if ! [ -x "$(command -v $1)" ]; then
        printf "${red}$1 is not installed${clear}\n" 
    else 
        printf "${green}$1 is installed${clear}\n" 
    fi
}

function test_vagrant {
    cd "vagrant_tests" \
        && vagrant up > /dev/null 2>&1 \
        && vagrant destroy -f > /dev/null 2>&1
    check_status $? "vagrant"
    cd $rootdir
}

function test_docker {
    docker run  -it hello-world > /dev/null 2>&1
    check_status $? "docker"
}

function test_lxc {
    ct_name=lxc-test-ct
    lxc launch ubuntu:22.04 $ct_name > /dev/null 2>&1 \
        && lxc stop $ct_name > /dev/null 2>&1 \
        && lxc delete $ct_name > /dev/null 2>&1
    check_status $? "lxc"
}

function test_k3d {
    cluster=k3dtestcluster1
    k3d cluster create $cluster > /dev/null 2>&1 \
        && kubectl get nodes > /dev/null 2>&1 \
        && k3d cluster delete $cluster > /dev/null 2>&1
    check_status $? "k3d"
}

function test_kind {
    cluster=kindtestcluster1
    kind create cluster --name $cluster > /dev/null 2>&1 \
        && kubectl get nodes > /dev/null 2>&1 \
        && kind delete cluster --name $cluster > /dev/null 2>&1
    check_status $? "kind"
}

function test_terraform {
    cd terraform_tests && \
        terraform init -input=false > /dev/null 2>&1 \
        && terraform apply -input=false -auto-approve > /dev/null 2>&1 \
        && terraform destroy -input=false -auto-approve > /dev/null 2>&1
    check_status $? "terraform"
}

# test git
git clone https://github.com/go-nv/goenv ./github-test > /dev/null 2>&1
check_status $? "git"
rm -rf ./github-test

# test curl
curl https://www.google.com/ > /dev/null 2>&1
check_status $? "curl"

# test wget
wget https://www.google.com/ -O test1 > /dev/null 2>&1
check_status $? "wget"
rm -rf test1

# sourcing nvm
. ~/.nvm/nvm.sh
check_status $? "nvm"

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

# sourcing sdkman
. ~/.sdkman/bin/sdkman-init.sh
check_status $? "sdkman"

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