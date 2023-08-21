#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path]

shell_dir=$(cd $(dirname $0); pwd)
extend_common_flags+=" "

if [[ "$gc_flags" == "" ]]; then
  if [[ "$3" == "" ]]; then
    gc_flags=$shell_dir/flags/zgc.gen.txt
  else
    gc_flags=$shell_dir/flags/zgc.gen.min.txt
  fi
fi

omsls17.sh $1 $2 $3
