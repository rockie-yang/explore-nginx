# explore-nginx


openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/example.key -out /etc/nginx/ssl/example.crt

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout example.key -out example.crt


docker run -it --rm -p 8080:80 -p 8443:443 -v $(pwd)/www.example.com.conf:/etc/nginx/conf.d/www.example.com.conf -v $(pwd)/example.key:/etc/nginx/ssl/example.key -v $(pwd)/example.crt:/etc/nginx/ssl/example.crt -v $(pwd)/html:/usr/share/nginx/html nginx:1.15


[NGINX + HTTPS 101: The basics & getting started](https://www.slideshare.net/NicholasSullivan/nginx-https-101-the-basics-getting-started)
[Performance-Tuning NGINX Open Source and NGINX Plus](https://youtu.be/YEdhuC2muOE)


nginx -V

docker run -it --name nginx2 --rm -p 8080:80 nginx:1.15

https://openresty.org/download/agentzh-nginx-tutorials-en.html

## nginx variable

### basic variable define
 
    set $a "hello world";  
    
    set $b "$a, ${a}";
    
    
### $ dollar escape

    geo $dollar {
        default "$";
    }
    
    server {
        listen 8080;
    
        location /test {
            echo "This is a dollar sign: $dollar";
        }
    }    
    
### variable scope
    
nginx variable is visible to the entire configurations, even across different virtual server configurations.
regardless the place where it is declared.

while the variable initialization might not exact same as expected. 
Nginx variables are bound to each request handled by Nginx,
    
    server {
        listen 8080;
    
        location /foo {
            echo "foo = [$foo]";
        }
    
        location /bar {
            set $foo 32;
            echo "foo = [$foo]";
        }
    }
    
    $ curl 'http://localhost:8080/foo'
    foo = []
    
    $ curl 'http://localhost:8080/bar'
    foo = [32]
    
    $ curl 'http://localhost:8080/foo'
    foo = []
    
We can see that the assignment operation is only performed in requests that access location /bar, 
since the corresponding set directive is only used in that location. When requesting the /foo interface, 
we always get an empty value for the $foo variable because that is what we get when accessing an uninitialized variable.


### **Internal redirection** will keep the variable stacks. 


    server {
        listen 8080;
    
        location /foo {
            set $a hello;
            echo_exec /bar;
        }
    
        location /bar {
            echo "a = [$a]";
        }
    }
    
    $ curl localhost:8080/foo
    a = [hello]
    
    
### $uri & $request_uri(none-decoded URI)

    location /test {
        echo "uri = $uri";
        echo "request_uri = $request_uri";
    }
    
    $ curl 'http://localhost:8080/test'
    uri = /test
    request_uri = /test
    
    $ curl 'http://localhost:8080/test?a=3&b=4'
    uri = /test
    request_uri = /test?a=3&b=4
    
    $ curl 'http://localhost:8080/test/hello%20world?a=3&b=4'
    uri = /test/hello world
    request_uri = /test/hello%20world?a=3&b=4
    
### Variables(case insensitive) with Infinite Names 

    location /test {
        echo "name: $arg_name";
        echo "class: $arg_class";
    }
    
    $ curl 'http://localhost:8080/test'
    name:
    class:
    
    $ curl 'http://localhost:8080/test?name=Tom&class=3'
    name: Tom
    class: 3
    
    $ curl 'http://localhost:8080/test?name=hello%20world&class=9'
    name: hello%20world
    class: 9
    
    $ curl 'http://localhost:8080/test?NAME=Marry'
    name: Marry
    class:
    
    $ curl 'http://localhost:8080/test?Name=Jimmy'
    name: Jimmy
    class:

### Rewrite args in proxy

    server {
        listen 8080;
    
        location /test {
            set $args "foo=1&bar=2";
            proxy_pass http://127.0.0.1:8081/args;
        }
    }
    
    server {
        listen 8081;
    
        location /args {
            echo "args: $args";
        }
    }
    
    $ curl 'http://localhost:8080/test?blah=7'
    args: foo=1&bar=2