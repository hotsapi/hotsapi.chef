#!/bin/bash
apt install -y git wget
wget https://packages.chef.io/files/stable/chefdk/2.1.11/ubuntu/16.04/chefdk_2.1.11-1_amd64.deb
dpkg -i chefdk_2.1.11-1_amd64.deb
berks vendor ./cookbooks
chef-client -z -j $(pwd)/chef.json