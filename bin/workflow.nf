params.prepare = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/prepare.sh"
params.input_blocks = "/tmp/sw23/tmp/block_*"
params.calc = "/lustre/scratch117/casm/cosmic/sw23/SingularityRCor/bin/singr_wrapper.sh"

process spilt_proc {
  echo true
  
  output:
  val '0' into ch_inputBlocks
  
  script:
  """
  echo "split_proc"
  bash $params.prepare
  """
}

process calc_proc {
  echo true
  
  input:
  val block_file from ch_inputBlocks
  val x from Channel.from(0..9)
  
  when:
  block_file == '0'

  script:
  """
  echo "calc_proc"
  echo $block_file
  echo $x
  $params.calc $x
  """
  
}

