#!/bin/bash

##########################################################################
# Name : singr_wrapper.sh
# @author : sw23
# @created date : 29 Apr 2020
# Function : wrapper to run R cor in LSF
##########################################################################

/software/singularity-v3.5.3/bin/singularity exec --bind /lustre:/lustre ${SINGULARITY_R_COR_HOME}/csvtool_latest.sif R CMD BATCH --no-save ${SINGULARITY_R_COR_HOME}/R/sing.R ${LOG_FOLDER}/Rout.${LSB_JOBINDEX}

