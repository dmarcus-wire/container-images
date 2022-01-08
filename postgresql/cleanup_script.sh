# cleanup script for postgresql
#!/bin/bash
echo "grab the environment variables"
source ./vars.config

echo "list all the containers named $CONTAINER"
podman ps -a | grep $CONTAINER

echo "remove the $CONTAINER"
podman rm -f $CONTAINER

echo "remove the $VOLUME"
rm -rv $VOLUME
