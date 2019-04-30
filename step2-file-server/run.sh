#!/bin/bash

docker rm -f nginx

docker run -d --name nginx --rm -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx:1.15

sleep 2

open http://localhost:8080