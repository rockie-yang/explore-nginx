#!/bin/bash

docker rm -f nginx

docker run -d --rm --name nginx -p 8443:443 \
    -v $(pwd)/https.conf:/etc/nginx/conf.d/https.conf \
    -v $(pwd)/example.key:/etc/nginx/ssl/example.key \
    -v $(pwd)/example.crt:/etc/nginx/ssl/example.crt nginx:1.15 &

sleep 2

open https://localhost:8443