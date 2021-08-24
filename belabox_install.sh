#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install python3-pip -y

sudo pip install ansible

ansible-playbook -K belabox.yml
