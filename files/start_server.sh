#!/bin/bash
sudo nomad agent -config server.hcl > logs/server.txt &
