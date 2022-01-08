# cleanup pods, containers and volumes
#!/bin/bash
echo "set env vars"
CONTAINER=container
POD=my_pod
VOLUME=persistence
FILE=wildfly.log

echo "remove pod and container"
podman pod stop $POD
sleep 3
podman pod rm $POD

echo "list pods"
podman ps -a --pod

echo "list containers"
podman ps -a 

echo "remove volume"
sudo rm -rf /home/admin/git/all-about-containers/practice/$VOLUME

echo "remove log file"
rm -f $FILE
