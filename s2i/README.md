# Source-to-Image (S2I)

provides an alternative to Containerfiles to create new container images. 

Works in openshift or standalone.

Creates slimmer images with fewer layers.

## Process
1. start container from base image `builder image`
	- contais prog. lang. runtimes, dev tools, compilers, etc.
1. fetch app code (usually from Git)
1. send app code to container
1. builds the app binary files inside container
1. saves the container as new container image
