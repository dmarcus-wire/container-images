# Creating and restoring container checkpoints

CRUI (checkpoint/restore in userspace) is a software that enables you to set a checkpoint on a running container or individual apps and store state to disk.

You can use data saved to restore the container after reboot at the same point in time it was checkpointed.

## Example
Based on a Python based web server which returns a single integer which is incremented after each request.

```
# create a Python based server
# cat counter.py
#!/usr/bin/python3

import http.server

counter = 0

class handler(http.server.BaseHTTPRequestHandler):
    def do_GET(s):
        global counter
           s.send_response(200)
           s.send_header('Content-type', 'text/html')
           s.end_headers()
           s.wfile.write(b'%d\n' % counter)
           counter += 1


server = http.server.HTTPServer(('', 8088), handler)
server.serve_forever()

# create a Containerfile with the following definition
# cat Containerfile
FROM registry.access.redhat.com/ubi8/ubi

COPY counter.py /home/counter.py

RUN useradd -ms /bin/bash counter

RUN yum -y install python3 && chmod 755 /home/counter.py

USER counter
ENTRYPOINT /home/counter.py

# build the container
podman build . --tag counter

# start the container
podman run --name criu-test -d counter

# display the ip address of the container
podman inspect criu-test --format "{{.NetworkSettings.IPAddress}}"

# send a request to the container
curl <ip addr>

# create a checkpoint
podman container checkpoint criu-test

# reboot the host system

# restore the container
podman container restore --keep criu-test

```

## References
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/building_running_and_managing_containers/index#assembly_creating-and-restoring-container-checkpoints_building-running-and-managing-containers
