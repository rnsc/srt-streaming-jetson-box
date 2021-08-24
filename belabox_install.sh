#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install ansible

ansible-playbook -K belabox.yml
