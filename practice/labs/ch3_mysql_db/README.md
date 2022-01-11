# Manage MySQL Db container

1. login to registry.redhat.io
1. pull and run a container with the mysql-80:1 container image
1. should fail, check logs
1. pull and run a container with the mysql-80:1 container image and parameters
1. populate the mysql database
```
$ podman login registry.redhat.io
$ podman run --name mysql-db registry.redhat.io/rhel8/mysql-80:1
$ podman logs mysql-db
$ podman run --name mysql -d \
	-e MYSQL_USER=user1 \
	-e MYSQL_PASSWORD=password \
	-e MYSQL_DATABASE=items \
	-e MYSQL_ROOT_PASSWORD=rootpass \
	registry.redhat.io/rhel8/mysql-80:1
$ podman ps --format="{{.ID}} {{.Names}} {{.Status}}"
$ podman cp ./db.sql mysql:/
$ podman exec mysql /bin/bash -c 'mysql -uuser1 -ppassword items < /db.sql'
$ podman exec mysql /bin/bash -c 'mysql -uuser1 -ppassword -e "select * from items.Projects;"'
```
