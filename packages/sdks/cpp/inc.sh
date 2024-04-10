#!/bin/bash


function install_cpp {
    function do_install_cpp {
        sudo apt install -y build-essential
        sudo apt install software-properties-common

        grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -q "ubuntu-toolchain-r/test"
        if [[ $? != 0 ]];
        then
            sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
        fi

        sudo apt install gcc-9 g++-9 gcc-9-base gcc-9-doc libstdc++-9-dev libstdc++-9-doc -y
        sudo apt install gcc-10 g++-10 gcc-10-base gcc-10-doc libstdc++-10-dev libstdc++-10-doc -y
        sudo apt install gcc-11 g++-11 gcc-11-base gcc-11-doc libstdc++-11-dev libstdc++-11-doc -y
        sudo apt install gcc-12 g++-12 gcc-12-base gcc-12-doc libstdc++-12-dev libstdc++-12-doc -y
        sudo apt install gcc-13 g++-13 gcc-13-base gcc-13-doc libstdc++-13-dev libstdc++-13-doc -y
        sudo apt install make cmake pkg-config -y

        sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130 --slave /usr/bin/g++ g++ /usr/bin/g++-13 --slave /usr/bin/gcov gcov /usr/bin/gcov-13
    }

    function do_install_opengl {
        sudo apt-get install mesa-utils libglu1-mesa-dev freeglut3-dev mesa-common-dev -y
        sudo apt-get install libglew-dev libglfw3-dev libglm-dev -y
        sudo apt-get install libao-dev libmpg123-dev -y
    }

    do_install_cpp
    do_install_opengl
}

function test_cpp {
    function do_test_gcc {
        dir="$rootdir/packages/sdks/cpp/tests"
        cd "$dir/gcc13" \
            && mkdir -p build \
            && cd build \
            && cmake .. > /dev/null 2>&1 \
            && make > /dev/null 2>&1 \
            && ./gcc13test > /dev/null 2>&1
        check_status $? "gcc13"
        cd $rootdir
    }

    do_test_gcc
}