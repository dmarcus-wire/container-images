# Building a container inside a Podman container

Privileged and unprivilged Podman containers.
- by default, Podman containers are unprivileged and cannot modify the OS on the host
- because, a container has very limited access to devices on the host
- privileged containers are given the same access as the user launching the container
- privileged containers disables security features that isolate the container from the host
- privileged containers cannot have more privileges than the account that launched them

## How to run a container in a container using Podman.  

This is similar to Docker-in-Docker (DIND). 

Why? 
1. lets you build images and start containers within already containerized environments.
1. allows you to run a pipeline inside a container to: stage a build, then builds the images, then runs the container

Caution: The --privileged option disables all security mechanisms, so they parent container is not isolated from the host. Red Hat recommends only using this option in trusted environments.

Uses Podman to build and run another container from within this container playing moon buggy game.

## Manual

1. log in to registry.redhat.io
1. pull and run a podman contaienr image
1. write a Containerfile
1. build the container
1. Run a new container based on moon-buggy
```
podman login registry.redhat.io
podman run --privileged --name podman_container -it registry.redhat.io/rhel8/podman /bin/bash
vim Containerfile
***START***
FROM registry.redhat.com/ubi8/ubi
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y install moon-buggy && yum clean all
CMD ["/usr/bin/moon-buggy"]
***END***
podman build -t moon-buggy .
play game
podman stop -a
podman rm -a
podman rmi 
exit
```

References:
1. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/assembly_running-skopeo-buildah-and-podman-in-a-container_building-running-and-managing-containers#proc_building-a-container-inside-a-podman-container_assembly_running-skopeo-buildah-and-podman-in-a-container
1. https://www.redhat.com/sysadmin/container-inside-container
1. https://www.redhat.com/sysadmin/podman-inside-container
