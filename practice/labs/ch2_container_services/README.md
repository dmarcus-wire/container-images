# Containerized Services

1. use quay.io to start a new httpd container in the background
1. forward port 8080 on the host to port 80 in the container
1. test the apache server
1. customize the index.html to display 'Hello World'

```
$ podman login quay.io
$ podman search quay.io/redhattraining/httpd-parent:2.4
$ ^search^pull
$ podman images
$ podman run -d --name httpd-basic -p 8080:80 quay.io/redhattraining/httpd-parent:2.4
$ curl 127.0.0.1:8080
$ vim index.html
> Hello World
$ podman cp ./index.html httpd-basic:/var/www/html/
$ curl 127.0.0.1:8080
```
