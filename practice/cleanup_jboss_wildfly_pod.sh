# pull jboss and postgresql images, run containers in a single pod, extract logs
echo "stop pod and containers"
podman pod stop my_pod

echo "remove pod and containers"
podman pod rm my_pod

echo "remove container images"
podman rmi -a

echo "remove log files"
rm -f wildfly.log
rm -f postgresql.log

echo "list pods"
podman pod ps
