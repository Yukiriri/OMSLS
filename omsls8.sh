#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [JAVA_BIN]

export JAVA_OPTS="$JAVA_OPTS"


if [[ "$omsls_gc_flags" == "" ]]; then
  mem_unit=${2:0-1:1}
  mem_amount=${2%$mem_unit}
  shell_dir=$(cd $(dirname $0); pwd)

  export omsls_gc_flags=$shell_dir/flags/g1gc.txt
  if [[ "${mem_unit^}" == "G" && $mem_amount -ge 12    ]]; then export omsls_gc_flags=$shell_dir/flags/g1gc.higher.txt; fi
  if [[ "${mem_unit^}" == "M" && $mem_amount -ge 12000 ]]; then export omsls_gc_flags=$shell_dir/flags/g1gc.higher.txt; fi
fi

omsls.sh $1 $2
