#!/bin/bash

function install_java {
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"

    sudo sed -i 's|sdkman_auto_answer=false|sdkman_auto_answer=true|g' ~/.sdkman/etc/config

    for ver in "${java_versions[@]}"; do
        sdk_version=${java_versions_map[$java_version]}
        sdk install java $sdk_version
    done

    sdk install groovy 4.0.20
    sdk install gradle 8.7
    sdk install maven 3.9.6
    sdk install liquibase 4.27.0

    source ~/.bashrc
    def_sdk_version=${java_versions_map[21]}
    sdk default java $def_sdk_version
    sdk default groovy 4.0.20
    sdk default gradle 8.7
    sdk default maven 3.9.6
    sdk default liquibase 4.27.0
}

function test_java {
    java_version=$1
    sdk_version=${java_versions_map[$java_version]}
    sdk use java $sdk_version > /dev/null 2>&1 \
        && cd java_tests/mvn-jdk$java_version \
        && mvn install > /dev/null 2>&1
    check_status $? "java$java_version"
    cd $rootdir
}