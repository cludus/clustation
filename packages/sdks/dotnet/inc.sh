#!/bin/bash

function install_dotnet {
    for ver in "${dotnet_versions[@]}"; do
        sudo apt-get install -y dotnet-sdk-$ver
    done
}

function test_dotnet {
    function do_test_dotnet {
        dir="$rootdir/packages/sdks/dotnet/tests"
        dotnet_version=$1
        cd "$dir/DotNetTest$dotnet_version" \
            && dotnet build > /dev/null 2>&1 \
            && dotnet run > /dev/null 2>&1
        check_status $? "dotnet$dotnet_version"
        cd $rootdir
    }

    for ver in "${dotnet_versions[@]}"; do
        do_test_dotnet $ver
    done
}