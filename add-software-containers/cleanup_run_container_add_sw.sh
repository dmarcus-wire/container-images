# cleanups containers and images
#!/bin/bash
echo "grab environment variables"
source ./vars.config
echo "list all containers"
podman ps -a
echo "remove all containers named $CONTAINER or $MINCONTAINER"
podman rm -f $CONTAINER $MINCONTAINER
echo "wait 5 seconds"
sleep 5
podman rmi -a
echo "wait 5 seconds"
sleep 5
echo "list all containers"
podman ps -a
echo "list all images"
podman images
