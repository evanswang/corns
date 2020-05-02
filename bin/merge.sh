#!/bin/bash
###################################################################################
# Name : merge.sh
# Author: sw23
# Date: 29 Apr 2020
# Function : merge final results
###################################################################################

for((i=0;i<$((${NODE_NUM}));i++))
do
  cat ${RES}/res_${i} >> ${RES}/res_raw
done

head -n ${SAMPLE_NUM} ${RES}/res_raw > ${RES}/res_tmp

/software/singularity-v3.5.3/bin/singularity exec --bind /lustre:/lustre ${SINGULARITY_R_COR_HOME}/csvtool_latest.sif csvtool setcolumns ${SAMPLE_NUM} ${RES}/res_tmp > ${RES}/res
