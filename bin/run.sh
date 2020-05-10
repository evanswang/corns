#!/bin/bash
###################################################################################
# Name : Main Entrance to the SingularityRCor calculation
# Author: sw23
# Date: 30 Apr 2020
# Function : This is the Main Entrance to the SingularityRCor calculation. Please make
# sure you have filled the config file correctly, before you run this script.
###################################################################################

date

# load the config file
source ${SINGULARITY_R_COR_HOME}/config

# clean result and tmp files
echo Cleaning
#rm -fr ${TMP}
#rm -fr ${RES}
#mkdir -p ${TMP}
#mkdir -p ${RES}
#mkdir -p ${TMP}/logs

export LOG_FOLDER=${TMP}/logs

if [ "$1" == "resume" ]; then
	${SINGULARITY_R_COR_HOME}/bin/nextflow run ${SINGULARITY_R_COR_HOME}/bin/workflow.nf -resume 
else
	${SINGULARITY_R_COR_HOME}/bin/nextflow run ${SINGULARITY_R_COR_HOME}/bin/workflow.nf
fi

