#!/bin/bash

function install_dotnet {
    for ver in "${dotnet_versions[@]}"; do
        sudo apt-get install -y dotnet-sdk-$ver
    done
}

function test_dotnet {
    dotnet_version=$1
    cd "dotnet_tests/DotNetTest$dotnet_version" \
        && dotnet build > /dev/null 2>&1 \
        && dotnet run > /dev/null 2>&1
    check_status $? "dotnet$dotnet_version"
    cd $rootdir
}