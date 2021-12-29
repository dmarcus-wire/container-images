# Building a micro container iage using Buildah

## Manual
- pull and build the image
- mount the working dir
- install httpd service micromount
- unmount the root filesystem on the working container
- create the micro-httpd image from the working container

```
microcontainer=$(buildah from registry.access.redhat.com/ubi8/ubi-micro)
micromount=$(buildah mount $microcontainer)
yum install --installroot $micromount --releasever 8 --setopt install_weak_deps=false --nodocs -y httpd
yum clean all --installroot $micromount
build unmount $micrcontainer
buildah commit $microcontainer
podman images ubi-micro-httpd
```
