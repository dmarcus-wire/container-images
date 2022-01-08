# bash script for wildfly
#!/bin/bash

echo "set env variables"
CONTAINER=wildfly
POD=my_pod
VOLUME=persistence
FILE=wildfly.log

echo "list images"
podman images

echo "create pod"
podman pod create --name $POD -p 8080:8080 -p 9990:9990

echo "list pods"
podman ps -a --pod

echo "create local volume"
mkdir -pv /home/admin/git/all-about-containers/practice/$VOLUME

echo "set file context"
sudo semanage fcontext -a -t container_file_t '/home/admin/git/all-about-containers/practice$VOLUME(/.*)?'

echo "apply the selinux changes"
sudo restorecon -Rv /home/admin/git/all-about-containers/practice/$VOLUME

echo "list SELinux type on volume"
ls -ldZ /home/admin/git/all-about-containers/practice/$VOLUME

echo "create wildfly container in existing pod"
podman run -d --name $CONTAINER -e WILDFLY_PASSWORD=my_password --pod $POD -v /home/admin/git/all-about-containers/practice/$VOLUME:/bitnami/wildfly bitnami/wildfly:latest

echo "after 5 seconds check running containers"
sleep 5
podman ps 

echo "after 5 seconds export logs from wildfly to a file"
touch $FILE
podman logs $CONTAINER >> $FILE
