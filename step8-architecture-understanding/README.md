docker run -it --name nginx --rm -p 8080:80 -v $(pwd)/nginx-2-worker-process.conf:/etc/nginx/nginx.conf nginx:1.15


