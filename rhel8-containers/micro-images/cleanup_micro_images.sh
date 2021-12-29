# cleanup and remove containers from micro images and the images
#!/bin/bash
echo "grab the environment variables"
source ./vars.config
echo "list all containers"
podmand ps -a
echo "stop containers named $CONTAINER"
podman stop $CONTAINER
echo "remove containers named $CONTAINER"
podman rm $CONTAINER
echo "list container images"
podman images
echo "remove container images named $IMAGE"
podman rmi $IMAGE
echo "cleanup complete."
