#!/bin/bash
###################################################################################
# Name : sub_merge.sh
# Author: sw23
# Date: 30 Apr 2020
# Function : merge result sub-matrices.
###################################################################################

INDEX=$(expr ${LSB_JOBINDEX} - 1)

source ${SINGULARITY_R_COR_HOME}/config

for((j=0;j<$((${NODE_NUM}));j++))
do
  cat ${RES}/block_${INDEX}_${j} >> ${RES}/block_${INDEX}
done

/software/singularity-v3.5.3/bin/singularity exec --bind /lustre:/lustre ${SINGULARITY_R_COR_HOME}/csvtool_latest.sif csvtool transpose ${RES}/block_${INDEX} > ${RES}/res_${INDEX}

date
