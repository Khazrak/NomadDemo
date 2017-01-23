#!/bin/bash
sudo nomad agent -config client.hcl > logs/server.txt &
