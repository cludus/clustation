#/bin/bash

#TODO: user jq or yq to parse json or yaml config file
node_versions=(20 18 16 14 12 10 8 6 4)
java_versions=(21 17 11 8)
declare -A java_versions_map=([21]=21.0.2-amzn [17]=17.0.10-amzn [11]=11.0.22-amzn [8]=8.0.402-amzn)
python_versions=(3.12 3.11 3.10 3.9 3.8)
dotnet_versions=(8.0)
go_versions=(1.22 1.21 1.20 1.19 1.18)
