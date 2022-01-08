# create a container named postgresql_database running PostgreSQL with database db and creds user:pass
#!/bin/bash
echo "grab the env variables"
source ./vars.config

echo "create the database volume"
mkdir -pv $VOLUME

echo "fix the $VOLUME permissions"
setfacl -m u:26:-wx $VOLUME

#echo "set the selinux for the directory"
#sudo semanage fcontext container_file_t -at "$VOLUME(/.*)?"
#sudo restorecon -Rv $VOLUME
#podman unshare chown -Rv 26:26 $VOLUME

echo "create container with postgresql"
podman run -d --name $CONTAINER \
-v $VOLUME:/var/lib/pgsql/data:Z \
-e POSTGRESQL_USER=user \
-e POSTGRESQL_PASSWORD=pass \
-e POSTGRESQL_DATABASE=db \
-p 5432:5432 \
registry.redhat.io/rhel8/postgresql-13

echo "verify running postgresql container"
podman ps --format "{{.ID}} {{.Names}} {{.Image}}"
