#!/bin/bash

function install_python {
    sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev \
        libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libcurl4-openssl-dev \
        libssl-dev -y

    # rm -rf ~/.pyenv
    curl https://pyenv.run | bash

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    export PATH=$PATH:~/.local/bin

    grep -q "export PYENV_ROOT=" ~/.bashrc
    if [[ $? != 0 ]];
    then
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc
        echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
    fi
    source ~/.bashrc

    function do_install_python {
        ls ~/.pyenv/versions/ | grep -q $1
        if [[ $? != 0 ]];
        then
            pyenv install $1
        fi
    }

    for ver in "${python_versions[@]}"; do
        do_install_python $ver
    done

    pyenv global ${python_versions[0]}
    source ~/.bashrc
    python -m ensurepip --upgrade
}

function test_python {
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    export PATH=$PATH:~/.local/bin

    function do_test_python {
        dir="$rootdir/packages/sdks/python/tests"
        python_version=$1
        cd $dir/python$python_version \
            && $(readlink $(pyenv which python)) . > /dev/null 2>&1
        check_status $? "python$python_version"
        cd $rootdir
    }

    for ver in "${python_versions[@]}"; do
        do_test_python $ver
    done
}