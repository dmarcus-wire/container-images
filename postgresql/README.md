# Container running PostgreSQL
Provide a containerized package of the PostgreSQL postgres daemon and client application.
- postgres server daemon accepts connections from clients and provides access to content from the database on behalf of the clients.

## using Postgresql manually with Podman
1. log in to registry.redhat.io/rhel8/postgresql
1. search fo the container image from a trusted source
1. pull and run a container using the trusted source with database `db` and user with creds `pass`

```
podman login registry.redhat.io
podman search registry.redhat.io/rhel8/postgresql
podman run -d --name postgresql_database \
	-e POSTGRESQL_USER=user \
	-e POSTGRESQL_PASSWORD=pass \
	-e POSTGRESQL_DATABASE=db \
	-p 5432:5432 \
	registry.redhat.io/rhel8/postgresql-13
```

## using the Postgresql with Bash script automation


## using Postgresql on OpenShift with a template
1. Use an OpenShift templates or curl a template example from https://github.com/sclorg/postgresql-container/tree/master/examples

```
curl https://github.com/sclorg/postgresql-container/blob/master/examples/postgresql-persistent-template.json

oc process --parameters ./postrgresql-persistent-template.json

oc process -f examples/postgresql-ephemeral-template.json \
	-p POSTGRESQL_VERSION=13 \
	-p POSTGRESQL_USER=user \
	-p POSTGRESQL_PASSWORD=pass \
	-p POSTGRESQL_DATABASE=db \
	oc create -f -
```
