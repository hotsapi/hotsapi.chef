# Hotsapi deploy cookbook

This repo is used to deploy [HotsApi](https://github.com/poma/hotsapi).

# Installation

* SSH into a clean Ubuntu 16.04 installation
* Clone a chef repo `git clone https://github.com/poma/hotsapi.chef.git`
* `cd hotsapi.chef`
* Modify a config file with your `.env` values `cp chef.example.json chef.json && vi chef.json`
* Run chef `./bootstrap.sh`
