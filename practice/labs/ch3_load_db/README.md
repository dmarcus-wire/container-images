# Load the Database

1. create a mysql container with persistent storage and port forwarding
1. populate the database 

```
$ podman login registry.redhat.io
$ mkdir ./local/mysql
$ sudo semanage fcontext -a -t container_file_t '/home/user/local/mysql(/.*)?'
$ sudo restorecon -Rv /home/user/local/mysql
$ podman unshare chown 27:27 /home/user/local/mysql
$ podman run --name mysqldb -d \
	-v /home/user/local/mysql:/var/lib/mysql/data \
	-p 13306:3306 \
	-e MYSQL_USER=user1 \
	-e MYSQL_PASSWORD=PASSWORD \
	-e MYSQL_DATABASE=items \
	-e MYSQL_ROOT_PASSWORD=rootpas \
	registry.redhat.io/rhel8/mysql-80:1
$ mysql -uuser1 -h 127.0.0.1 -pmypa55 -P13306 items < ./db.sql
$ podman exec -it mysqldb mysql -uroot items -e "SELECT * FROM Item" 
```
