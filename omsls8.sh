#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [custom_java_path]

if [[ "$omsls_gc_flags" == "" ]]; then
  mem_unit=${2:0-1:1}
  mem_amount=${2%$mem_unit}
  shell_dir=$(cd $(dirname $0); pwd)

  export omsls_gc_flags=$shell_dir/flags/g1gc.small.txt
  if [[ "${mem_unit^}" == "G" && $mem_amount -ge 12    ]]; then export omsls_gc_flags=$shell_dir/flags/g1gc.txt; fi
  if [[ "${mem_unit^}" == "M" && $mem_amount -ge 12000 ]]; then export omsls_gc_flags=$shell_dir/flags/g1gc.txt; fi

  if [[ "$omsls_is_legacy_java_cmd" == "" ]]; then export omsls_is_legacy_java_cmd=1; fi
  omsls.sh $1 $2
else
  omsls.sh $1 $2 $3
fi
