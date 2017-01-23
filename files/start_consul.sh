#!/bin/bash
consul agent -server -bind=IP \
-client=IP -data-dir=/tmp/consul -bootstrap-expect 3 >> logs/consul.txt &
