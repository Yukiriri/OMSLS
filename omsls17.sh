#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path]

shell_dir=$(cd $(dirname $0); pwd)
export extend_common_flags+=" --add-modules jdk.incubator.vector"

if [[ "$gc_flags" == "" ]]; then
  if [[ "$3" == "" ]]; then
    export gc_flags=$shell_dir/flags/zgc.txt
  else
    export gc_flags=$shell_dir/flags/zgc.min.txt
  fi
fi

omsls.sh $1 $2 $3
