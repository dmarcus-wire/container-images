# Creating a MySQL Database

1. login to Red Hat registry
1. create mysql container instance
1. start a container from mysql image
1. check the container status
1. access a terminal in the container
1. check database availability
1. use the items database
1. create a new table Projects
1. show the new table
1. add new data values to Projects table
1. show the new data
1. exit

```
$ podman login registry.redhat.io
$ podman run --name mysql-basic \
	-e MYSQL_USER=user1 \
	-e MYSQL_PASSWORD=password \
	-e MYSQL_DATABASE=items \
	-e MYSQL_ROOT_PASSWORD=rootpass \
	-d registry.redhat.io/rhel8/mysql-80:1
$ podman ps --format "{{.ID}} {{.Image}} {{.Names}}"
$ podman exec -it mysql-basic /bin/bash
$ mysql -uroot
> show databases;
> use items;
> CREATE TABLE Projects (id int NOT NULL, name varchar(255) DEFAULT NULL, code varchar(@%%) DEFAULT NULL, PRIMARY KEY (id));
> show tables;
> insert into Projects (id, name, code) values (1, 'DevOps', 'DO180');
> select * from Projects;
> exit
$ exit
 ```
