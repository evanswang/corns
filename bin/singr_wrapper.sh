#!/bin/bash

##########################################################################
# Name : singr_wrapper.sh
# @author : sw23
# @created date : 29 Apr 2020
# Function : wrapper to run R cor in LSF
##########################################################################

/software/singularity-v3.5.3/bin/singularity run --app Rscript ${SINGULARITY_R_COR_HOME}/singularity-r.simg ${SINGULARITY_R_COR_HOME}/R/sing.R ${LSB_JOBINDEX}

