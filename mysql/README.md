# MYSQL Container 

## using Podman to manually create
download a MySQL 8.0 container image with 1 tag, and then starts a container based on the image. Creates a database called `items`, owned by user `user` with `mypa55` password. The database admin password is set to r00tpa55 and the container runs in the background.

```
podman run -d --name mysql \
-e MYSQL_USER=user \
-e MYSQL_PASSWORD=pass \
-e MYSQL_DATABASE=items \
-e MYSQL_ROOT_PASSWORD=r00tpa55 \
registry.redhat.io/rhel8/mysql-80:1

podman exec -it mysql /bin/bash

mysql -uroot

showdatabases;

insert into Projects (id, name, code) values (1, 'DevOps', 'DO180');

SELECT * FROM Projects;
```
