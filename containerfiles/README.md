# Containerfiles

Desribes the steps taken to assemble an image.

A containerfile provides a mechanism to customize and implement changes to a container using human readable commands without files generated by the OS.

A Containerfile can be a file named either Containerfile or Dockerfile. Both share the same syntax. Containerfile is the default name used by OCI compliant tools.

All container images should be built using `Containerfile`, in order to create a clean, lightweight set of image layers without log files, temporary files or other artifcats. Containerfiles are easy to share, version control, reuse, and extend.

Alternatively, `podman commit` allows image modification.

## Process
1. create working dir
1. write containerfile
1. build image with `podman build` or 'buildah bud'

## Child images
Extending images, child images, from another image, parent image, are easily done with Containerfiles. Using a high-quality parent image improves maintainability, if the parent is updated by it's author. 

Child Image Scenarios:
1. add new runtime libraries (db connectors)
1. include org.-wide customization (SSL certs)
1. add internal libraries for sharing 

Parent Image Scenarios:
1. trim container image sizes removing unused content (/usr/share/doc...man pages)
1. lock parent image to specific versions

## Parent image
Sources for content:

Red Hat Software Collections Library (RHSCL)
https://access.redhat.com/documentation/en/red-hat-software-collections/
- for developers who require the latest dev tools and standard RHEL release schedules don't fit

Red Hat Container Catalog (RHCC)
https://access.redhat.com/containers/
- reliable, tested, certified and curated collection of container images based on versions of RHEL

RHSCL Dockerfiles on GitHub
https://github.com/sclorg?q=-container
- CentOS-based equivalent container images 

Using Red Hat Software Collections Container Images
https://access.redhat.com/articles/1752723

Quay.io
https://quay.io/search
- advanced container repository from CoreOS for team collaboration

Docker Hub
https://hub.docker.com/
- anyone can create an account and publish images. no general assurances about quality and security.

Docker Library GitHub project
https://github.com/docker-library
- containerfiles for images built by Docker community

## podman commit
even though podman commit is straightforward for creating new images, it bloats size (keeping logs and process ID files in captured layers) as well as lack of traceability.
```
podman commit [OPTIONS] container [repository[:port]/]image_name[:tag]
```

## image change record
Identify which files (mounted to the container file system) were changed, created or deleted since the container was started.
- A = add files
- C = changed files
- D = deleted files

```
podman diff
podman inspect -f "{{range .Mounts}}{{println .Destination}}{{end}}" container


```
