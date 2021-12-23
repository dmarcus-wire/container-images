# create a dockerfile that creates a base image from jboss eap
FROM registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:7.3.9-3.1638383381
EXPOSE 9990
CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
