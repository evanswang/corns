params.prepare = ${SINGULARITY_R_COR_HOME}/bin/prepare.sh

process spilt_proc {
  echo true
  script:
  """
  bash $params.prepare
  """
}

