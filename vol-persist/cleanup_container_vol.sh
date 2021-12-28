# cleanup container and volume
echo "grab the environment variables"
source ./vars.config
echo "list all containers"
podman ps -a
echo "stop and force remove containers named $CONTAINER"
podman rm -rf $CONTAINER
echo "list images"
podman images
echo "remove images name $IMAGE"
podman rmi -a
echo "remove the volume"
podman volume rm $VOLUME
