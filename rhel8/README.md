# pull the  ubi8 container image
```
podman pull regsitry.redhat.access.com/ubi8/ubi
```

# run the container
```
podman run -rm --name myubi8 registry.access.redhat.com/ubi8/ubi cat /etc/os-release
```
