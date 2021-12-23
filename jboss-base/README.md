# MANUAL PROCEDURE
podman login registry.redhat.io
Username: 
Password: 

docker pull registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:7.3.9-3.1638383381

# DOCKERFILE
$ podman build --layers=false -t jboss73 .

# SCRIPTS
### BUILD JBOSS IMAGE
./build_jboss.sh
### CLEANUP SCRIPT REMOVES IMAGES
./cleanup_script.sh 
