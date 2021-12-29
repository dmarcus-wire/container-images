# cleanup pods and containers created from script
# list all pods and containers
echo "grab the environment variables"
source ./vars.config
echo "all pods"
podman ps -a --pod
echo "all containers"
podman ps -a 
echo "clean pods named $POD and containers named $CONTAINER"
podman pod rm $POD
echo "verify pods and container cleaned"
podman ps -a --pod
podman ps -a
