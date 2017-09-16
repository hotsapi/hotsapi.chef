#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

apt install -y git curl
if ! type berks > /dev/null; then
    curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk
fi
berks vendor ./cookbooks
chef-client -z -j $(pwd)/chef.json
