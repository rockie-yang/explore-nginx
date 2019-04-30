#!/bin/bash

docker pull nginx:1.15

docker rm -f nginx

docker run -d --name nginx --rm -p 8080:80 nginx:1.15 &

sleep 2

open http://localhost:8080