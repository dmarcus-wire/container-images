# usage ./run_micro_http.sh
#!/bin/bash
# grab environment variables
source ./vars.config
echo "Pull and build the registry.access.redhat.com/ubi8/ubi-micro image"
microcontainer=$(buildah from registry.access.redhat.com/ubi8/ubi-micro)
echo "Mount a working container root filesystem"
micromount=$(buildah mount $microcontainer)
echo "Install the httpd service to the micromount directory"
# yum install \
    --installroot $micromount \
    --releasever 8 \
    --setopt install_weak_deps=false \
    --nodocs -y \
    httpd
# yum clean all \
    --installroot $micromount
echo "Unmount the root file system on the working container"
buildah umount $microcontainer
echo "Create the ubi-micro-httpd image from a working container"
buildah commit $microcontainer ubi-micro-httpd
echo "Display details about the ubi-micro-httpd image"
podman images ubi-micro-httpd
