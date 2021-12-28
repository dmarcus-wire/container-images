# container-images

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

