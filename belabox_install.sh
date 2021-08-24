#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install python3-pip -y

sudo pip3 install ansible==2.10

printf "Please input your user's password to continue:\n"

ansible-playbook -K belabox.yml
