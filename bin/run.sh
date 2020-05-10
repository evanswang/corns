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

${SINGULARITY_R_COR_HOME}/bin/nextflow run ${SINGULARITY_R_COR_HOME}/bin/workflow.nf 

exit 0

echo "start LSF"
bsub -w "done(${PRE_JOB})" -G team238-grp -q cosmic -o ${LOG_FOLDER}/${JOB}.outfile.%J.%I -e ${LOG_FOLDER}/${JOB}.err.%J.%I -J ${JOB}[1-${FOLDER_NUMBER}]%${CPU_NUMBER} "${SINGULARITY_R_COR_HOME}/bin/singr_wrapper.sh"


PRE_JOB=${JOB}
JOB=link
FOLDER_NUMBER=1
CPU_NUMBER=1
bsub -w "done(${PRE_JOB})" -G team238-grp -q cosmic -o ${LOG_FOLDER}/${JOB}.outfile.%J.%I -e ${LOG_FOLDER}/${JOB}.err.%J.%I -J ${JOB}[1-${FOLDER_NUMBER}]%${CPU_NUMBER} "${SINGULARITY_R_COR_HOME}/bin/link.sh"

PRE_JOB=${JOB}
JOB=sub_merge
FOLDER_NUMBER=${NODE_NUM}
CPU_NUMBER=${NODE_NUM}
bsub -w "done(${PRE_JOB})" -G team238-grp -q cosmic -o ${LOG_FOLDER}/${JOB}.outfile.%J.%I -e ${LOG_FOLDER}/${JOB}.err.%J.%I -J ${JOB}[1-${FOLDER_NUMBER}]%${CPU_NUMBER} "${SINGULARITY_R_COR_HOME}/bin/sub_merge.sh"

PRE_JOB=${JOB}
JOB=merge
FOLDER_NUMBER=1
CPU_NUMBER=1
bsub -w "done(${PRE_JOB})" -G team238-grp -q cosmic -o ${LOG_FOLDER}/${JOB}.outfile.%J.%I -e ${LOG_FOLDER}/${JOB}.err.%J.%I -J ${JOB}[1-${FOLDER_NUMBER}]%${CPU_NUMBER} "${SINGULARITY_R_COR_HOME}/bin/merge.sh"
