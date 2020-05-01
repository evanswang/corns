#!/bin/bash
###################################################################################
# Name : sub_merge.sh
# Author: sw23
# Date: 30 Apr 2020
# Function : merge result sub-matrices.
###################################################################################

source ${SINGULARITY_R_COR_HOME}/config

for((j=0;j<$((${NODE_NUM}));j++))
do
  cat ${RES}/block_$1_${j} >> ${RES}/block_$1
done

csvtool transpose ${RES}/block_$1 > ${RES}/res_$1

echo $1

date

