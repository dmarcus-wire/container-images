# creates an image from Containerfile and runs pod
echo "grab environment variables"
source ./vars.config
echo "build the containerfile with buildah"
buildah bud -t $BUILDAH .
echo "wait 5 seconds"
sleep 5
echo "build the containerfile with podman"
podman build -t $PODMAN .
echo "wait 5 seconds"
sleep 5
echo "print image details"
buildah images $BUILDAH 
buildah images $PODMAN
