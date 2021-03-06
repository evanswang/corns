params.prepare = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/prepare.sh"
params.input_blocks = "/tmp/sw23/tmp/block_*"
params.calc = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/singr_wrapper.sh"
params.link = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/link.sh"
params.subMerge = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/sub_merge.sh"
params.merge = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/merge.sh"


process spilt_proc {
  echo false
  
  output:
  val 0 into ch_inputBlocks
  
  script:
  """
  echo "split_proc"
  bash $params.prepare
  """
}

process calc_proc {
  echo false
  
  input:
  val block_file from ch_inputBlocks
  val x from Channel.from(0..27)

  output:
  val 0 into ch_calc  

  when:
  block_file == 0

  script:
  """
  echo "calc_proc"
  #echo $block_file
  #echo $x
  $params.calc $x
  """
  
}

process link_proc {
  echo false

  input:
  val input_val from ch_calc.sum()

  output:
  val 0 into ch_link

  when:
  input_val == 0

  script:
  """
  echo "link_proc"
  #echo $input_val
  bash $params.link
  """
}

process subMerge_proc {
  echo false

  input:
  val input_val from ch_link
  val x from Channel.from(0..27)

  output:
  val 0 into ch_subMerge

  when:
  input_val == 0

  script:
  """
  echo "subMerge_proc"
  $params.subMerge $x
  """
}

process merge_proc {
  echo false

  input:
  val input_val from ch_subMerge.sum()

  when:
  input_val == 0

  script:
  """
  echo "merge_proc"
  $params.merge
  """
}
