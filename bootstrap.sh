#!/bin/bash
apt install -y git curl
if ! type berks > /dev/null; then
    if ! -f chefdk.deb; then
        curl https://packages.chef.io/files/stable/chefdk/2.2.1/ubuntu/16.04/chefdk_2.2.1-1_amd64.deb > chefdk.deb
    fi
    dpkg -i chefdk.deb
fi
berks vendor ./cookbooks
chef-client -z -j $(pwd)/chef.json
