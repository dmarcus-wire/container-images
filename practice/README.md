# Skills testings

## RUN JBOSS EAP in a container

```
# search for image
podman search docker.io/jboss/wildfly

# pull the image
podman pull docker.io/jboss/wildfly

# search for the image on Quay
podman search quay.io/bitnami/wildfly

# pull the image from quay
podman pull quay.io/bitnami/wildfly:latest

# list local images
podman images

# basic run of jboss/wildfly
podman run --name wildlfy -e WILDFLY_PASSWORD=redhat12 jboss/wildfly:latest

# basic run of bitnami/wildfly
# notice   JBOSS_HOME: /opt/bitnami/wildfly
podman run --name wildfly -e WILDFLY_PASSWORD=redhat12 bitnami/wildfly:latest

# spec run with ports forwarded from host to container
podman run -p 8080:8080 -p 9090:9090 jboss/wildfly:latest

# create custom user for wildfly
podman run --name wildfly -e WILDFLY_USERNAME=my_user -e WILDFLY_PASSWORD=my_password jboss/wildfly:latest

# run wildfly image, mounting a directory from the host
podman run --name wildfly -v /path/to/persistence:/bitnami/wildfly jboss/wildfly:latest

# run wildfly in an existing pod, mounted to host vol, with exposed ports
mkdir -pv ./wildfly-persist
sudo semanage fcontext -a -t container_file_t '/path/to/wildfly-persist(/.*)?'
sudo restorecon -Rv /path/to/wildfly-persist
podman unshare chown -Rv UID:UID /path/to/wildfly-persist
podman pod create --name my_pod -p 8080:8080 -p 9990:9990 
podman run -d --name wildfly -e WILDFLY_PASSWORD -v /path/to/wildfly-persist:/bitnami/wildfly -e WILDFLY_PASSWORD=my_password bitnami/wildfly:latest 
touch wildfly.log
podman logs >> wildfly.log
```

## RUN Portgresql in a container

```
# search for the postgresql image
podman search quay.io/postgresql

# pull the iamge
podman pull quay.io/postgresql

# list local images
podman images

# run the postgresql container
podman run -d --name postgresql -e POSTGRESQL_PASSWORD=password postgresql
```

## Create a pod
```
# list pods
podman pod ps 
podman ps -a --pods

# create pod with ports exposed for containers
podman pod create --name my_pod -p 8080:8080 -p 9990:9990
```

## RUN both jboss and postrgesql containers in a single existing pod
```
# pull jboss container image
podman pull quay.io/bitnami/wildfly

# pull postgresql container image
podman pull quay.io/bitnami/postgresql

# create a pod
podman pod create --name my_pod -p 8080:8080 -p 9990:9990

# run jboss container in my_pod
podman run -d --name wildfly --pod my_pod -e WILDFLY_PASSWORD=password bitnami/wildfly:latest

podman run -d --name postgresql --pod my_pod -e POSTGRESQL_PASSWORD=password bitnami/wildfly:latest

# create the container and pod in the same commandd
podman run -d --pod new:my_pod --name postgresql --restart=always -e POSTGRESQL_PASSWORD=password quay.io/bitnami/postgresql

podman run -d --pod my_pod --name wildfly --restart=always -e WILDFLY_PASSWORD=password quay.io/bitnami/wildfly:latest
```

WRITE a shell script to run, extract logs and cleanup pods with more than 1 container

```
# view the wildfly logs
podman logs wildfly

# tail last 10 log lines
podman logs --tail=10 wildfly

# write logs to a file
touch wildfly.logs
touch postgresql.logs

podman logs --tail=10 wildfly >> wildfly.logs
podman logs --tail=10 postgresql >> postgresql.logs
```

EXTEND JBOSS container image via Containerfile 
Set an environment variable
Set workdir and currentdir
add managmenet user with password
expose port 9090
RUN CMD if not commands are passed
RUN JBOSS EAP from an OCP template, use labels
```
oc process -f
```

RUN Postgresql from an OCP template, use labels to connect to JBOSS

References:

