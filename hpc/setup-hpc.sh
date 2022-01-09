# The example is based on the ring.c program taken from Open MPI. In this example, a value is passed around by all processes in a ring-like fashion. Each time the message passes rank 0, the value is decremented. When each process receives the 0 message, it passes it on to the next process and then quits. 

echo "Install OpenMPI"
sudo yum install openmpi

echo "activate the environment modules"
. /etc/profile.d/modules.sh

echo "load mpi/openmpi module"
module load mpi/openmpi-x86_64

echo "build the Containerfile"
podman build --tag=mpi-ring .

echo "start the container"
mpirun \
   --mca orte_tmpdir_base /tmp/podman-mpirun \
   podman run --env-host \
     -v /tmp/podman-mpirun:/tmp/podman-mpirun \
     --userns=keep-id \
     --net=host --pid=host --ipc=host \
     mpi-ring /home/ring
