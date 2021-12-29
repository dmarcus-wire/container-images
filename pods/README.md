# Pods

Every Podman pod includes an Infra container that holds the namespaces associated with the pod and allows Podman to connect other containers to it. As well, start and stop containers within the pod.

1. create an empty pod
1. list the pods
1. run a container named myubi in an existing pod
1. verification display running processes of the containers in the pod
1. diplay live stream of the resource usage
1. inspect the pod
1. remove the pod (auto-removes the containers)
```
podman pod create --name mypod
podman pod ps
podman ps -a --pod
podman run -dt --name myubi --pod mypod registry.access.redhat.com
podman ps -a --pod
podman pod top mypod
podman pod stats -a --no-stream
podman pod inspect mypod
podman pod stop mypod
podman pod rm mypod

```
