# Adding software to containers

Red Hat Universal Base Image (UBI) are build from RHEL content. Add software via yum on UBI & UBI-init; Add software via microdnf on UBI-minimal. UBI provides a set of pre-build language runtime container images: Python, Perl, Node.js, Ruby, etc.

Installing software in running containers adds packages temporarily, not saved to the container image. 

To make change persist, you must build the image from a Containerfile.


It also matters if you are adding software to a UBI container from a subscribed host or un-subscribed host, because the RHEL Base and AppStream repositories are enabled inside the standard UBI along with the UBI repos. Installing RH packages outside of RH UBI repos can limit ability to distribute container outside subscribed systems.

## Adding software to standard UBI container
1. pull and run an container image
1. list all enabled repos
1. list all installed packages
1. add a package to the container
1. to add software from UBI repo, disable all yum repos except UBI
1. to add software not in the UBI repo, do not disable any repos
1. to add software in a different host repo, enable the repo you need
```
podman run -it --name myubi registry.access.redhat.com/ubi8/ubi
yum repolist
rpm -qa
yum install --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos bzip2
yum install --enablerepo=codeready-builder-for-rhel-8-x86_64-rpms python38-devel
yum install zsh
```

## Adding software to a minimal UBI container
1. pull and run a container image
1. list all enabled repos
1. list all installed packages
1. to add software from UBI repo, DO NOT disable any repos
1. to add package from a different host repo, enable the repo you need
```
podman run -it --name myubimin registry.access.redhat.com/ubi8/ubi-minimal
microdnf repolist
rpm -qa
microdnf install bzip2
microdnf install --enablerepo=codeready-builder-for-rhel-8-x86_64-rpms python38-devel
```

## Building UBI-based images
Create a UBI-based web server from a Containerfile using Buildah. You MUST disable all non-UBI yum repos to ensure you can redistribute the container.

1. Create the Containerfile
1. Build the container image
1. Pull and Run the container image
1. Verify using curl
```
vim Containerfile
***CONTAINERFILE***
FROM registry.access.redhat.com/ubi8/ubi
USER root
LABEL maintainer="David Marcus"
# update image
RUN yum update --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos -y && rm -rf /var/cache/yum
RUN yum install --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos httpd -y && rm -rf /var/cache/yum
# add default webpage and expose port
RUN echo "The web server is running" > /var/www/html/index.html
EXPOSE 80
# start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"] 
***CONTAINERFILE***

buildah bud -t davidmarcus/webserver .
podman run -d --name myweb -p 8081:80 davidmarcus/webserver
curl http://localhost/index.html
```

IMPORTANT: For UBI-minimal, use microdnf instead of YUM
```
RUN microdnf update -y && rm -rf /var/cache/yum
```

## Runtime images
Based on App Streams offer container images that you can use as basis for container builds. Includes: Python, Ruby, s2-core, s2i-base, .NET Core, PHP.
