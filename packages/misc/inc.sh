#!/bin/bash

function install_test_tools {
    # postman
    sudo snap install postman

    # k6
    if ! command -v k6 &> /dev/null
    then
        sudo gpg -k
        sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
        echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
        sudo apt-get update && sudo apt-get install k6 -y
    fi
}

function test_test_tools {
    echo "no tests for test_tools"
}