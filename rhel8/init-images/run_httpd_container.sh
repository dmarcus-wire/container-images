# script runs and starts a container using the Contiainerfile
#!/bin/bash
echo "grab the environment variables"
source ./vars.config
echo "podman run command"
podman run -d --name=${CONTAINER} -p 8081:80 httpd-approved
echo "wait 9 seconds"
sleep 9
echo "list running containers"
podman ps
echo "check the default web page"
curl localhost:8081/index.html
