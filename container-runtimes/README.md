# runc and crun container runtimes
What is a container runtime? Simply, it's a software that can host containers atop a host operating system (aka Container Engine).

## runc 
- written in Go language
- used by Podman, Buildah, CRI-O to launch containers
- runc reads the runtime spec, configs the linux kernel and starts the container
- lightweight and portable container runtime
- OCI complaint (default)
- shares low-level code with Docker, but not dependent
- supports linux namespace
- supports live migration
- portable performance profiles
- full support for SELinux
- supports control groups (cgroups), seccomp, etc.

## crun
- written in C
- lower-level and interaces with kernel better
- lightweight, so it compiles to a smaller size, thus has a low-memory footprint 
- OCI compliant
- written in C
- 50x smaller and 2x faster than runc binary
- set minimal number of processes
- sharing files by group for rootless containers
- control stdout and stderr of OCI hooks
- running older versions of systemd
- a C library used by other programs
- extensibility
- portability

## running containers
With runc and crun, containers are configured using bundles. A bundle for container is a directory that includes:
1. a specification file `config.json` 
1. a root file system that contains the contents of the container

## procedure to create a container in runc or crun
1. pull the container image
1. export the image to a .tar archive
1. create the `bundle/rootfs` directory
1. extract the rhel.tar archive into the `bundle/rootfs` 
1. create the `config.json` spec file for the bundle using -b dir
1. create the instance of a container and name it uniquely to the host
1. start the container using the `<runtime> start <unique_container_name>
1. verification list containers start by runtime
```
podman pull registry.access.redhat.com/ubi8/ubi
podman export $(podman create registry.access.redhat.com/ubi8/ubi) > rhel.tar
mkdir -p bundle/rootfs
tar -C bundle/rootfs -xf rhel.tar
<runtime> spec -b bundle
vim bundle/config.json
<runtime> create -b bundle/ myubi
<runtime> start myubi
<runtime> list
```

## temporarily change the runtime
1. pull the container image
1. change the runtime using the --runtime option
1. verification checking the OCI <runtime>
```
podman pull registry.access.redhat.com/ubi8/ubi
podman run --name=myubi -dt --runtime=<runtime> ubi8
podman ps -a
podman inspect myubi --format "{{.OCIRuntime}}"
```

## permenantly changing the runtime
1. edit the containers.conf file
1. verification via run and inspect
```
vim /etc/containers/containers.conf
[engine]
runtime ="<runtime>"

podman run --name=myubi -dt ubit8 bash
podman inspect myubi --format "{{.OCIRuntime}}"
```

## references
1. https://www.redhat.com/sysadmin/introduction-crun
1. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/assembly_working-with-containers_building-running-and-managing-containers#con_the-runc-container-runtime_assembly_working-with-containers

