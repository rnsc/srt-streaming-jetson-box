#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install -y --no-install-recommends ansible

ansible-playbook -K belabox.yml
