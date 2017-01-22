#!/bin/bash
mkdir logs
sudo nomad agent -config serverboot.hcl > logs/server.txt &
