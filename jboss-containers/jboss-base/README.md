# DIFFERENT WAYS TO LAUNCH, EXTEND AND MANAGE JBOSS CONTAINERS

## Facts about JBOSS EAP
- app server provides an environment to run a web app
- provides pre-config. features (HA, clustering, messaging, distributed caching)
- provides API to connect to components (database, etc.)
- organizes APIs in subsystems for different behaviors
- compatible with Jakarta EE 8 specs (web profile, full-platform)
- Jakarta EE 8 defines different profiles (Web, Platform
- each major version is tested, stabilized and certified
- major versions are forked from WildFly community project
- WildFly is a powerful, modular, & lightweight application server that helps you build amazing applications.
- Standalone server for individual instances and Managed Domain for groups of isntances from a single control point
- standalone server that supports 1x server instance
- centralized management of multiple server instances and physical hosts
- batch mode that scripts and automates management tasks

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
