#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path]

shell_dir=$(cd $(dirname $0); pwd)
export omsls_extend_common_flags+="--add-modules jdk.incubator.vector "

if [[ "$omsls_gc_flags" == "" ]]; then
  if [[ "$3" == "" ]]; then
    export omsls_gc_flags=$shell_dir/flags/zgc.txt
  else
    export omsls_gc_flags=$shell_dir/flags/zgc.min.txt
  fi
fi

omsls11.sh $1 $2 $3
