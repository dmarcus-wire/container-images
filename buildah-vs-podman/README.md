# Buildah vs. Podman for Containers

## Main differences
1. buildah images are smaller
1. buildah doesn't require a container runtime to build images
1. buildah images are more secure because it doesnt inject build software (yum, make, gcc, etc.)
1. build images from scratch, a container, or another image

## Basic functions
1. install buildah
1. get images and containers
1. run commands in a container
1. build an image from a Containerfile
1. inspect images and containers
1. modify containers
1. create images from scratch
1. push containers
1. remove images and containers

```
# install buildah 
yum install -y buildah

# list images
buildah images

# build an images from UBI
buildah from registry.access.redhat.com/ubi8/ubi

# list images and containers
buildah images 
buildah containers

# run commands inside containers
build run ubi-working-container cat /etc/redhat-release

# build images
vim Containerfile
***START***
FROM registry.access.redhat.com/ubi8.ubi
RUN echo "This container works" > /usr/local/bin/myecho && chmod 755 /usr/local/bin/myecho
ENTRYPOINT "/usr/local/bin/myecho"
***END***

buildah bud -t myecho .
podman run --name myecho localhost/myecho
```
