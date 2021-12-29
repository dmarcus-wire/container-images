# graceful stop and clean of the httpd container
#!/bin/bash
echo "source the environment variables"
source ./vars.config
echo "list of running containers"
podman ps
echo "graceful stop of $CONTAINER"
podman stop $CONTAINER
echo "wait for 5 seconds"
sleep 5
echo "list of all containers"
podman ps -a
echo "remove containers named $CONTAINER"
podman rm $CONTAINER
echo "wait for 5 seconds"
sleep 5
echo "list all containers"
podman ps -a
