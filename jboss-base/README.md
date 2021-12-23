# MANUAL PROCEDURE
docker login registry.redhat.io
Username: {REGISTRY-SERVICE-ACCOUNT-USERNAME}
Password: {REGISTRY-SERVICE-ACCOUNT-PASSWORD}
Login Succeeded!

docker pull registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:7.3.9-3.1638383381

# DOCKERFILE
$ podman build --layers=false -t jboss73 .

# SCRIPTS
### CLEANUP SCRIPT REMOVES IMAGES
./cleanup_script.sh 
