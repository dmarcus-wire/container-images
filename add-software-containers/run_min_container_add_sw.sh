# bash script to pull an image, run a container and add software
#!/bin/bash
echo "grab environment variables"
source ./vars.config
echo "pull a standard UBI image and run a container"
podman run -dt --name $MINCONTAINER registry.access.redhat.com/ubi8/ubi-minimal
echo "wait 10 seconds"
sleep 10
echo "list running containers"
podman ps
echo "list all repos in the container"
podman exec $CONTAINER microdnf repolist
echo "check if bzip2 is installed"
podman exec $CONTAINER rpm -qa | grep bzip2
echo "install software in a running Standard UBI container from UBI repo"
podman exec $MINCONTAINER microdnf install bzip2
echo "list if bzip2 installed"
rpm -qa | grep bzip2
