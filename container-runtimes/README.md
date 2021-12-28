# runc and crun container runtimes

## runc 
- lightweight and portable container runtime
- OCI spec
- shares low-level code with Docker, but not dependent
- supports linux namespace
- supports live migration
- portable performance profiles
- full support for SELinux
- supports control groups (cgroups), seccomp, etc.

## crun
- fast and low-memory footprint 
- OCI spec
- written in C
- 50x smaller and 2x faster than runc binary
- set minimal number of processes
- sharing files by group for rootless containers
- control stdout and stderr of OCI hooks
- 
