#!/bin/bash
mkdir logs
sudo nomad agent -config server.hcl > logs/server.txt &
