# Containers

Why containers?

efficiently deliver new instances of the same software to new environments without unnecessary overhead:
- developer laptops
- shared development environments in private or public namespaces
- on internal quality assurance environments 
- on dynamically provisioning/de in the cloud
- on gold environments in the cloud
- on disaster recovery environments

## Definitions
1. Container: a linux process
1. Container States: rest (a set of files on disk) and running (just another Linux process)
1. Container Image: set of files defining a container at rest. Types include: App (what end users consume), Base (the image that has no parent), Builder (include everything but developers code), Deployer (runs, deploys or manages other containers), Intermediate (any container image that relies on a base image), Intermodal (serve both app and builder images), System (super privileged run before the Runtime/Orchestrator)
1. Container Image Formats: Docker, Appc, LXD, OCI
1. Container Image Layers: files in a parent-child relationship that represent changes between itself and the parent layer. Built manually, which each commit creating a new layer or via Containerfile/Dockerfile, each directive creates a new layer. LXD uses a single layer, docker and RKT use OCI-based images based on multiple layers
1. Open Container Initiative "OCI": industry standard governing Containers layers and metadata for interoperability; later unified security scanning, signing, building and moving.
1. Container Engine: accepts input from user/orchestrator, pulls the Container Image from a Registry, unpacks/decompress the Container Image on disk, prepares the mountpoint and metadata, calls the Container Runtime, which turns them into a Container. (ENGINE DOESN'T ACTUALLY RUN THE CONTAINER). Engines include Docker, CRI-O, Railcar, RKT, LXC
1. Contianer Runtime: lower level component used in a Container Engine, consumes the mountpoint, metedata, communicates with the kernel, sets up cgroups, SElinux policies, etc. (ACTUALLY RUNS THE CONTAINER) Includes: runc (OCI default), crun, railcar, katacontainers. 
1. Container Host: is the system the runs the containerized processes (aka containers)
1. Orchestrator: dynamically schedules container workloads among a cluster of computers (distributed computing) and provides standard app definition files (kube yaml, docker compose, etc.) Handles large number of Container Hosts, manages individual Container states (rest, run, restart, scale up/down), manages Container Hosts (fail, network, reboot), manages Container Engines (corruption, restart).  
1. Registry: a store for Containers at rest both publically and locally (aka fancy file server) hosted on a server accessible via DNS and Port. (IMPLICIT TRUST)
1. Repository: the location of the container image, the layers that make it up and the metadata. Format is typically registry_server/namespace/repository:tag
1. Tag: a tool for image builders to communicate which layers are best to consume or versions. Not mandatory, just best practice.
1. Namespace: used in Registries or Kernels. On Registries, a tool for separating groups of repositories (e.g. username, organization, logical, products, etc.). In kernels, enable each container to have it's own mountpoint, network interface, user identifiers, process identifiers, etc. 
1. Containers: the smallest unit you can manage with Podman, Skopeo and Buildah tools 
1. Pods: the smallest comput units you can create, deploy and manage made up of 1:n containers. 

Often teams start with a Container Host and pull some Container Images from a Registry. They customize, push and pull to a Registry Server to share with others. Then, they want to wire a few containers together and deploy them as a unit. At some point, they want to push thta unit into a pipeline (Dev > QA > Prod), which is where an Orchestration tool enters. 

source: https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction#containers_101

## Types of container images
1. Red Hat Enterprise Linux Base Images (RHEL base images)
1. Red Hat Universal Base Images (UBI images)

### Type Features
- Both are built from portions of Red Hat Enterprise Linux (RHEL)
- Both are supported and provide reliability, security, performance and lifecycles

### Type Differences
- UBI images are designed for any application that runs on RHEL
- UBI images feature: init system (to install RPM packges like httpd, vsftpd), yum (to add and update software with yum, yum-config-manager, yumdownloader) utilities (to tar, dmidecode, gzip, getfacl, etc.)
- UBI images allow you to share the contianer image with others. They are 'Redistributable'
- UBI images are designed to be a foundation for cloud-native and web-app use cases developed in containers
- UBI images come in 4 offerings: micro, minimal, standard, init
- UBI micro images (`ubi-micro`) feature: smallest possible image, excludes package manager, dependencies, etc. "Distroless" container image.
- UBI minimal images (`ubi-minimal`) feature: small size (92M on disk, 32M compressed), microdnf (instead of full yum), does not include some RHEL packages (systemd, python, shell, etc.)
- UBI init images (`ubi8-init`) feature: contain systemd, usefule for building images to run web or file server.
- UBI standard images feature: includes RHEL packages to manage systemd services (systemd, python, shell, etc)
- UBI images provide a set of associated YUM repositories: ubi-8-baseos, ubi-8-appstream

## installing container tools

### subscribing your system

```
# registry with your Red Hat username and password
subscription-manager register

# auto-subscribe
subscription-manager attach --auto

# install container tools
yum module install -y container-tools

# install the podman-docker package to replace docker commands with podman commands
yum install -y podman-docker
```

## Tools

### Skopeo
- inspect images on remote registries without downloading the entire image and layers
- copy images, signing images, syncing them and converting across formats and compression

### Podman
- manage containers and volumes mounted to them
- pods made from groups of containers
- by default, Podman contaienrs are unprivileged and cannot modify the host OS 
- privileged containers, set via podman run --privileged is: given the same access to devices as the user launching the container, disables security features that isolate the container.
- less privileges, you can run the more secure by setting the following
```
$ podman run --name=unprivileged_podman --security-opt label=disable --user podman --device /dev/fuse registry.access.redhat.com/rhel8/podman podman run ubi8 echo hello
```

### Buildah
Differs from `podman build`
- No container runtime nor daemon is required
- You can build based on another container or start with an empty image
- allows for smaller images. because it doesnt include build tools inside the image
- without build tools: reduces size of images, increases security excluding software (gcc, yum,  make, etc.), uses fewer resources to transport
- mount/un working container root filesystem


