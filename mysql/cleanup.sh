# cleanup containers and images
echo "grab the environment variables"
source ./vars.config

echo "remove the containers"
podman rm -rf $CONTAINER

echo "after 5 seconds remove the image"
podman rmi $IMAGE

