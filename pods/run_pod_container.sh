# create a pod and run a container in the pod
#!/bin/bash
# grab the environment variables
echo "grab environment variables"
source ./vars.config
# list all pods
echo "listing all pods"
podman pod ps
# list all containers
echo "listing all containers"
podman ps -a
# list all container images
echo "list all images"
podman images
# create a pod
echo "create a pod"
podman pod create --name $POD
# list all pods
podman ps -a --pod
# create a container in the pod
echo "create a container in the pod"
podman run -dt --name $CONTAINER --pod $POD registry.access.redhat.com/ubi8/ubi /bin/bash
# list all running uods and containers
echo "list all running pods and containers"
podman pod ps && podman ps 
