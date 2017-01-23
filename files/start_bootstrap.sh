#!/bin/bash
sudo nomad agent -config serverboot.hcl > logs/server.txt &
