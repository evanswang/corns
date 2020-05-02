#!/bin/bash
###################################################################################
# Name : Main Entrance to the SingularityRCor calculation
# Author: sw23
# Date: 30 Apr 2020
# Function : This is the Main Entrance to the SingularityRCor calculation. Please make
# sure you have filled the config file correctly, before you run this script.
###################################################################################

# Performance test purpose
date

# load the config file
source ${SINGULARITY_R_COR_HOME}/config

# clean result and tmp files
echo Cleaning
rm -fr ${TMP}
rm -fr ${RES}
mkdir -p ${TMP}
mkdir -p ${RES}
mkdir -p ${TMP}/logs

export LOG_FOLDER=${TMP}/logs

echo Preparing
${SINGULARITY_R_COR_HOME}/bin/prepare.sh

echo Running

/software/singularity-v3.5.3/bin/singularity pull --name singularity-r.simg shub://nickjer/singularity-r

bsub -I -R "select[mem>8000] rusage[mem=8000] span[hosts=1]" -M 8000 -G team238-grp "/software/singularity-v3.5.3/bin/singularity pull docker://norbnorb/stats"

JOB=singr
FOLDER_NUMBER=${NODE_NUM}
CPU_NUMBER=10
bsub -G team238-grp -q normal -o ${LOG_FOLDER}/${JOB}.outfile.%J.%I -e ${LOG_FOLDER}/${JOB}.err.%J.%I -J ${JOB}[1-${FOLDER_NUMBER}]%${CPU_NUMBER} "${SINGULARITY_R_COR_HOME}/bin/singr_wrapper.sh"

# remove data block files in TMP
# to save space to data merging.
#echo Cleaning tmp block
#rm -fr ${TMP}/block*

# write the data merging script to
# the NFS TMP folder for the Spark master (spark1).
# run the data merging scrpt in the master.
echo Merging data

# install csvtools and create an image

${SINGULARITY_R_COR_HOME}/bin/merge.sh

date