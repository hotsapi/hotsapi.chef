# Hotsapi deploy cookbook

This repo is used to deploy [HotsApi](https://github.com/poma/hotsapi).

# Installation

* SSH into a clean Ubuntu 16.04 installation
* Clone a chef repo `git clone https://github.com/poma/hotsapi.chef.git`
* `cd hotsapi.chef`
* Create a chef config file `cp chef.example.json chef.json`
* Modify `chef.json` if needed (test server should be able to start without any modifications)
* Run chef `sudo ./bootstrap.sh`
