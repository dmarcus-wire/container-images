# Sharing files between two containers

Use volumes to persist data in containers when the container is deleted or sharing between containers. The volume is a folder on the host machine that stores data.

## Advantages of volumes
1. can be shared among containers
1. easy to backup or migrate
1. do not increase the size of the container

## Manual
1. grab the environment variables
1. create the volume
1. display info about the volume
1. save the mount point to a variable
1. create a test file in the volume
1. run a container and map it to the volume
1. gracefully stop and remove the container and image
```
source ./vars.config
podman volume create $VOLUME
podman volume inspect $VOLUME
echo "Hello from inside the container" > $MNTPOINT/host.txt
podman run -it --name ubi1 -v $VOLUME:/containervolume1 registry.access.redhat.com/ubi8/ubi /bin/bash
ls /containervolume1
podman stop $CONTAINER
podman rm $CONTAINER
podman rmi $IMAGE
```

## Using Bash Automation
1. create the volume; pull, build and run the container image
1. gracefully stop and remove the container and container image
```
# creates the volume and the container
./run_container_vol.sh

# stop and remove the container and volume
./cleanup_container_vol.sh
```
