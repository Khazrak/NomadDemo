#!/bin/bash
mkdir -p logs
sudo nomad agent -config client.hcl > logs/server.txt &
