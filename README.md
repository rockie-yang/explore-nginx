# explore-nginx


openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/example.key -out /etc/nginx/ssl/example.crt

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout example.key -out example.crt


docker run -it --rm -p 8080:80 -p 8443:443 -v $(pwd)/www.example.com.conf:/etc/nginx/conf.d/www.example.com.conf -v $(pwd)/example.key:/etc/nginx/ssl/example.key -v $(pwd)/example.crt:/etc/nginx/ssl/example.crt -v $(pwd)/html:/usr/share/nginx/html nginx:1.15


nginx -V

docker run -it --name nginx2 --rm -p 8080:80 nginx:1.15