#!/bin/bash

function install_nodejs {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    for ver in "${node_versions[@]}"; do
        nvm install $ver
    done
    nvm use 20
    nvm alias default 20
}

function test_nodejs {
    # sourcing nvm
    . ~/.nvm/nvm.sh
    check_status $? "nvm"

    function do_test_nodejs {
        dir="$rootdir/packages/sdks/nodejs/tests"
        node_version=$1
        nvm use $node_version > /dev/null 2>&1 \
            && cd $dir/node$node_version \
            && npm i > /dev/null 2>&1 \
            && npm run start > /dev/null 2>&1
        check_status $? "node$node_version"
        cd $rootdir
    }

    for ver in "${node_versions[@]}"; do
        do_test_nodejs $ver
    done
}