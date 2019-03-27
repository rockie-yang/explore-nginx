#!/bin/bash

docker run -it --name nginx --rm -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx:1.15
