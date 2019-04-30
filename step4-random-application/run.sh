#!/bin/bash

docker rm -f serving

docker run -d --rm --name serving \
	  -p 3000:3000 \
	  -v $(pwd)/serving.js:/bin/serving.js \
	  node:11.12 node /bin/serving.js &

docker rm -f searching


docker run -d --rm --name searching \
	  -p 3001:3000 \
	  -v $(pwd)/serving.js:/bin/searching.js \
	  node:11.12 node /bin/searching.js &

sleep 2

open http://localhost:3000

open http://localhost:3001