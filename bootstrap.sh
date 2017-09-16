#!/bin/bash
apt install -y git curl
if ! type berks > /dev/null; then
    curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk
fi
berks vendor ./cookbooks
chef-client -z -j $(pwd)/chef.json
