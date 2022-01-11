# Containers with persistenct

1. create dir
1. apply the SELinux context
1. change the ownership for the mysql group:user 27
1. run a container that mounts the volume
1. list the contents under the mount
```
$ mkdir -pv ./local/mysql
$ sudo semanage fcontext -a -t container_file_t '/home/user/local/mysql(/.*)?'
$ sedo restorecon -Rv /home/user/local/mysql
$ podman unshare chown 27:26 /home/user/local/mysql
$ podman run -d --name mysql \
	-v /home/user/local/mysql:/var/lib/mysql/data \	
	-e MYSQL_USER=user1 \
	-e MYSQL_PASSWORD=password \
	-e MYSQL_DATABASE=items \
	-e MYSQL_ROOT_PASSWORD=rootpass \
	registry.redhat.io/rhel8/mysql-80:1
$ ls -ld /home/users/local/mysql
```
