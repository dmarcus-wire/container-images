# UBI INIT Rootless Container Image

This section provides:
1. manual procedure for launching a ubi-init image
1. Container file for running a ubi-init image
1. Bash scripts for running and cleaning ubi-init image

## Manual
```
source ./vars.config
podman pull registry.access.redhat.com/ubi8/ubi-init
podman run -d --name $CONTAINER -p 8081:80 registry.access.redhat.com/ubi8/ubi-init
podman exec -it httpd-manual-init
yum install -y httpd
yum install clean all
systemctl enable httpd
mkdir /etc/systemd/httpd.service.d/
echo -e '[Service]\nRestart=always' > /etc/systemd/httpd.service.d/httpd.conf
curl localhost:8081/index.html
podman stop $CONTAINER
podman rm $CONTAINER
```

## Containerfile
```
source /vars.config
podman build -t $CONTAINER .
podman run -d --name $CONTAINER -p 8081:80 httpd-approved
curl localhost:8081/index.html
podman stop $CONTAINER
podman rm $CONTAINER
```

## Bashscript
```
# start a web server
./run_httpd_container.sh

# stop and remove the web server
./clean_httpd_container.sh
```
