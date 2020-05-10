#!/bin/bash
###################################################################################
# Name : link.sh
# Author: sw23
# Date: 29 Apr 2020
# Function : create symbol links
###################################################################################

source ${SINGULARITY_R_COR_HOME}/config

for((i=0;i<$((${NODE_NUM}));i++))
do
	for((j=0;j<$((${NODE_NUM}));j++))
	do
		if [[ ! -f ${RES}/block_${j}_${i} ]]; then
			ln -s ${RES}/block_${i}_${j} ${RES}/block_${j}_${i} 
		fi
	done
done
