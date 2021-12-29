# creates a volume, adds a test file and runs a container 
#!/bin/bash
echo "grab the environment variables"
source ./vars.config
echo "create a persistent volume"
podman volume create $VOLUME
echo "display information about the volume"
podman volume inspect $VOLUME
echo "display only the new mount point"
podman volume inspect $VOLUME --format {{.Mountpoint}}
echo "create a test file"
echo "Hello from inside the container" >> $MOUNT/host.txt
echo "Run a UBI 8 container mounted to the volume"
podman run -it --name $CONTAINER -d -v $VOLUME:/containervolume1 registry.access.redhat.com/ubi8/ubi /bin/bash
