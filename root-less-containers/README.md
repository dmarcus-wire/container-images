# root less containers vs rootful

## Manual

```
# run a container as root user
sudo podman run --rm --name asroot -it registry.redhat.com/ubi8:latest /bin/bash

# check your user
whoami

# check your user id
id

# start a sleep process
sleep 1000

# new terminal check for the sleep process
sudo ps -ef | grep "sleep 1000"

# run another container as regular user
podman run --rm --name asuser -it registry.redhat.com/ubi8:latest /bin/bash

# check your user
whoami

# check your user id
id

# start a new sleep process
sleep 2000

# new terminal check for the sleep process
ps -ef | grep "sleep 2000"
```
