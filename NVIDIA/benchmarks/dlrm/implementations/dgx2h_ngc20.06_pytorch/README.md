## Steps to launch training

### NVIDIA DGX-2H (single node)

Launch configuration and system-specific hyperparameters for the NVIDIA DGX-2H
single node submission are in the `config_DGX2.sh` script.

Steps required to launch DLRM training with Pytorch on a single NVIDIA DGX-2H:


1. Build the container and push to a docker registry:

```
cd ../implementations/pytorch
docker build --pull -t <docker/registry>/mlperf-nvidia:recommendation .
docker push <docker/registry>/mlperf-nvidia:recommendation
```

2. Launch the train on Slurm
```
source config_DGX2.sh
CONT=<docker/registry>/mlperf-nvidia:recommendation DATADIR=<path/to/data/dir> LOGDIR=<path/to/output/dir> DGXSYSTEM=DGX2H sbatch -N 1 run.sub
```

#### Alternative launch with nvidia-docker

When generating results for the official v0.7 submission with one node, the
benchmark was launched onto a cluster managed by a SLURM scheduler. The
instructions in [NVIDIA DGX-2H (single node)](#nvidia-dgx-2h-single-node) explain
how that is done.

However, to make it easier to run this benchmark on a wider set of machine
environments, we are providing here an alternate set of launch instructions
that can be run using nvidia-docker. Note that performance or functionality may
vary from the tested SLURM instructions.

```
source config_DGX2.sh
CONT=<docker/registry>mlperf-nvidia:recommendation DATADIR=<path/to/data/dir> LOGDIR=<path/to/output/dir> DGXSYSTEM=DGX2H ./run_with_docker.sh
```
