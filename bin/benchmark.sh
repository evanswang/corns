#!/bin/bash

for((n=0;n<3;n++))
do
	for((i=2000;i<2001;i=i+1000))
	do
		rm -fr ${SINGULARITY_R_COR_HOME}/.nextflow* ${SINGULARITY_R_COR_HOME}/work/

		time ${SINGULARITY_R_COR_HOME}/bin/run.sh
	done
done
