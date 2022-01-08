# start a database from a container image and store data inside
#!/bin/bash
echo "grab the environment variables"
source ./vars.config

echo "start container from RH Container Catalog"
podman run -d --name $CONTAINER \
	-e MYSQL_USER=user \
	-e MYSQL_PASSWORD=mypa55 \
	-e MYSQL_DATABASE=items \
	-e MYSQL_ROOT_PASSWORD=r00tpa55 \
	-d registry.redhat.io/rhel8/mysql-80:1

echo "check the status after 5 seconds"
sleep 5
podman ps --format "{{.ID}} {{.Name}} {{.ID}}"
