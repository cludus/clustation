#!/bin/bash


function install_go {
    grep -q "export GOENV_ROOT=" ~/.bashrc
    if [[ $? != 0 ]];
    then
        git clone https://github.com/go-nv/goenv.git ~/.goenv
        echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.bashrc
        echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.bashrc
        source ~/.bashrc
    fi
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"

    function do_install_go {
        ls ~/.goenv/versions/ | grep -q $1
        if [[ $? != 0 ]];
        then
            goenv install $1
        fi
    }

    for ver in "${go_versions[@]}"; do
        do_install_go $ver
    done

    goenv global ${go_versions[0]}

    grep -q 'eval "$(goenv init -)"' ~/.bashrc
    if [[ $? != 0 ]];
    then
        echo 'eval "$(goenv init -)"' >> ~/.bashrc
        echo 'export PATH="$GOROOT/bin:$PATH"' >> ~/.bashrc
        echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.bashrc
    fi

    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"
}

function test_go {
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"

    function do_test_go {
        dir="$rootdir/packages/sdks/go/tests"
        go_version=$1
        cd "$dir/go_test$go_version" \
            && go build > /dev/null 2>&1 \
            && ./go_test_app > /dev/null 2>&1
        check_status $? "go$go_version"
        cd $rootdir
    }

    for ver in "${go_versions[@]}"; do
        do_test_go $ver
    done
}
