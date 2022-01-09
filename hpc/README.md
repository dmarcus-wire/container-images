# Podman in HPC

Use Podman with Open MPI (Message Passing Interface) to run containers in a an HPC (High Performance Compute) environment.

## Example with ring.c program

A value is passwed around by all processes in a ring-like fashion. 
Each time the message passes rank 0, the value is decremented.  
When each process receives the 0 message, it psases it on to the next process then quits.

```
# Install Open MPI
sudo yum install openmpi

# activate the environment modules
. /etc/profile.d/modules.sh

# load the mpi/openmpi-x86_64 module
module load mpi/openmpi-x86_64

# to automaticall load the mldules, add the line to the .bashrc
echo "module load mpi/openmpi-x86_64" >> .bashrc

# write a Containerfile to combine mpirun and podman
FROM registry.access.redhat.com/ubi8/ubi

RUN yum -y install openmpi-devel wget && \
    yum clean all

RUN wget https://raw.githubusercontent.com/open-mpi/ompi/master/test/simple/ring.c && \
    /usr/lib64/openmpi/bin/mpicc ring.c -o /home/ring && \
    rm -f ring.c

# build the container
podman build --tag=mpi-ring .

# start the container
mpirun \
   --mca orte_tmpdir_base /tmp/podman-mpirun \
   podman run --env-host \
     -v /tmp/podman-mpirun:/tmp/podman-mpirun \
     --userns=keep-id \
     --net=host --pid=host --ipc=host \
     mpi-ring /home/ring

# As a result, mpirun starts up 4 Podman containers and each container is running one instance of the ring binary. All 4 processes are communicating over MPI with each other.

## References
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/building_running_and_managing_containers/index#assembly_using-podman-in-hpc-environment_building-running-and-managing-containers

- https://podman.io/blogs/2019/09/26/podman-in-hpc.html
``` 
