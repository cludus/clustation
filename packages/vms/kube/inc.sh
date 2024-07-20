#!/bin/bash

function install_kubernetes {
    if ! command -v kubectl &> /dev/null
    then
        # kubectl
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        chmod +x kubectl
        sudo mv kubectl /usr/local/bin
    fi

    # k3d
    if ! command -v k3d &> /dev/null
    then
        curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
    fi

    # kind
    if ! command -v kind &> /dev/null
    then
        [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
        chmod +x ./kind
        sudo mv ./kind /usr/local/bin/kind
    fi

    # k3sup
    if ! command -v k3sup &> /dev/null
    then
        curl -sLS https://get.k3sup.dev | sh
        sudo mv k3sup /usr/bin/
    fi
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

function install_kubernetes {
    test_k3d
    test_kind
}
