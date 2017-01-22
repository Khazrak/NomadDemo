#!/bin/bash
mkdir -p logs
consul agent -dev -bind=172.17.8.101 -client=172.17.8.101 >> logs/consul.txt &
