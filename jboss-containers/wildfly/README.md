# Launching and Managing a WildFly container on RHEL and OCP
Wildfly is a lightweight, open source application server, formerly known as JBoss, that implements the latest enterprise Java standards.
container image source: https://hub.docker.com/r/bitnami/wildfly

## using Podman manually on RHEL
1. pull the image from docker and run container in standalone
1. to boot in standalone mode with admin console available remotely
1. to boot in domain mode
```
podman run -it docker.io/jboss/wildfly
podman run -p 8080:8080 -p 9990:9990 -it docker.io/jboss/wildfly /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
podman run -it docker.io/jboss/wildfly /opt/jboss/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0
```

## using Contianerfile automation on RHEL 
Based on the deployment scanner method placing the app inside the /deployments/ directory.
- /opt/jboss/wildfly/standalone/deployments/
- /opt/jboss/wildfly/domain/deployments/

```
FROM docker.io/jboss/wildfly
ADD my-awesome-app.war /opt/jboss/wildfly/standalone/deplyoments
```

## extending the image
1. Pull the image
1. Create a management user to access the admin console will be available on the port 9990 
1. Build the image
1. Run the image 

```
FROM docker.io/jboss/wildfly
RUN /opt/jboss/widfly/bin/add-user.sh admin Admin#70365 --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

podman build -t jboss/wildfly-admin .

podman run -it jboss/wildfly-admin
```

## using Bash script automation on RHEL


## using Ansible automation on RHEL


## using OpenShift automation 

## References:
1. https://design.jboss.org/redhatdeveloper/marketing/docker_cheatsheet/cheatsheet/images/docker_cheatsheet_r2v2.pdf
1. https://access.redhat.com/documentation/en-us/red_hat_developer_studio/12.9/html/getting_started_with_container_and_cloud-based_development/developing_with_docker
