# cleanup containers and images
echo "grab the environment variables"
source ./vars.config
echo "remove the images"
buildah rmi $BUILDAH $PODMAN
