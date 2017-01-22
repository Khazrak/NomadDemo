#!/bin/bash
sudo sed -i -e "s/.*nomad.*/$(ip addr show eth1 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*) $(hostname)/" /etc/hosts
