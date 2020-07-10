params.prepare = "/home/ubuntu/corns/bin/prepare.sh"
params.input_blocks = "/mnt/data/corns/input/block_*"
params.calc = "/home/ubuntu/corns/bin/singr_wrapper.sh"
params.link = "/home/ubuntu/corns/bin/link.sh"
params.subMerge = "/home/ubuntu/corns/bin/sub_merge.sh"
params.merge = "/home/ubuntu/corns/bin/merge.sh"


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
  val x from Channel.from(0..3)

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

