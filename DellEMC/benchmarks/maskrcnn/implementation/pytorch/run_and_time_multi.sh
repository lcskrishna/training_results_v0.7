#!/bin/bash

# runs benchmark and reports time to convergence
# to use the script:
#   run_and_time_multi.sh

set -e

# GPU driver path
export PATH=/mnt/driver/bin:$PATH
export LD_LIBRARY_PATH=/mnt/driver/lib64:$LD_LIBRARY_PATH

# container wise env vars
export OMP_NUM_THREADS=1
export OPENCV_FOR_THREADS_NUM=1

cd /mnt/current
readonly _config_file="./config_${SYSTEM}.sh"
source $_config_file

# start timing
start=$(date +%s)
start_fmt=$(date +%Y-%m-%d\ %r)
echo "STARTING TIMING RUN AT $start_fmt"

# run benchmark
set -x

echo "running benchmark"

DATASET_DIR='/data'
ln -sTf "${DATASET_DIR}/coco2017" /coco
#echo `ls /data`

declare -a CMD
#if [ -n "${SLURM_LOCALID-}" ]; then
  # Mode 1: Slurm launched a task for each GPU and set some envvars; no need for parallel launch
#  CMD=( 'python' '-u' )
#else
  # Mode 2: Single-node Docker; need to launch tasks with Pytorch's distributed launch
  # TODO: use bind.sh instead of bind_launch.py
  #       torch.distributed.launch only accepts Python programs (not bash scripts) to exec
  HTFLAG=''
  if [[ "${HT}" == 1 ]]; then   
      HTFLAG="--no_hyperthreads" 
  fi      
  CMD=( 'python' '-u' '-m' 'bind_launch' ${HTFLAG} "--nsockets_per_node=${NSOCKET}" \
    "--ncores_per_socket=${SOCKETCORES}" "--nproc_per_node=${NGPU}" ${MULTI_NODE} )
#fi

"${CMD[@]}" tools/train_mlperf.py \
  ${EXTRA_PARAMS} \
  --config-file 'configs/e2e_mask_rcnn_R_50_FPN_1x.yaml' \
  DTYPE 'float16' \
  PATHS_CATALOG 'maskrcnn_benchmark/config/paths_catalog_dbcluster.py' \
  MODEL.WEIGHT '/coco/models/R-50.pkl' \
  DISABLE_REDUCED_LOGGING True \
  ${EXTRA_CONFIG} ; ret_code=$?


set +x

sleep 3
if [[ $ret_code != 0 ]]; then exit $ret_code; fi

# end timing
end=$(date +%s)
end_fmt=$(date +%Y-%m-%d\ %r)
echo "ENDING TIMING RUN AT $end_fmt"

# report result
result=$(( $end - $start ))
result_name="OBJECT_DETECTION"

echo "RESULT,$result_name,,$result,dellemc,$start_fmt"

