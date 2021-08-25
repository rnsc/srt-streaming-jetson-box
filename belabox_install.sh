#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install python3-pip -y

sudo pip3 install ansible==2.10

ansible-playbook belabox.yml
