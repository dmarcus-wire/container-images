# pull jboss and postgresql images, run containers in a single pod, extract logs
echo "pull images"
podman pull quay.io/bitnami/wildfly:latest
podman pull quay.io/bitnami/postgresql:latest

echo "create a pod with ports exposed"
podman pod create --name my_pod -p 8080:8080 -p 9990:9990

echo "list pods"
podman pod ps

echo "create wildfly container in pod"
podman run -d --pod my_pod --name wildfly -e WILDFLY_PASSWORD=password wildfly

echo "create postgresql container in pod"
podman run -d --pod my_pod --name postgresql -e POSTGRESQL_PASSWORD=password postgresql

echo "extract logs to logfiles"
touch wildfly.log
podman logs wildfly >> wildfly.log
touch postgresql.log
podman logs postgresql >> postgresql.log
