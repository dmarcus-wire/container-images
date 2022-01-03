# Sharing files between two containers

Use volumes to persist data in containers when the container is deleted or sharing between containers. The volume is a folder on the host machine that stores data.

ephemeral container storage is not sufficient for apps that need to keep data beyond the lifetime of the container.

## Advantages of volumes
1. can be shared among containers
1. easy to backup or migrate
1. do not increase the size of the container

## Manual with mkdir
1. grab the environment variables
1. create the directory
1. the user running the process in the container MUST be capable of writing files to the dir. Set the numeric ID (UID) from the container. E.G. for MySQL the UID is 27. Podman unshare provides a session to execute commands with in the same user namespace as the process in the container.
1.  apply the container_file_t "$VOLUME(/.*)?"
1.  apply the policy that was set

```
source ./vars.config
mkdir -pv $VOLUME
podman unshare chown -R 27:27 $VOLUME
sudo semanage fcontext -at container_file_t $VOLUME
sudo restorecon -Rv $VOLUME
ls -ldZ $VOLUME
podman run -v $VOLUME:/var/lib/mysql registry.redhat.io/rhel8/mysql-80:1
```

## Manual with podman volumes
1. grab the environment variables
1. create the volume
1. set the permissions
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
