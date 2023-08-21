#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [custom_java_path]

mem_unit=${2:0-1:1}
mem_amount=${2%$mem_unit}
shell_dir=$(cd $(dirname $0); pwd)
export gc_flags=$shell_dir/flags/g1gc.small.txt

if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12    ]]; then export gc_flags=$shell_dir/flags/g1gc.txt; fi
if [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then export gc_flags=$shell_dir/flags/g1gc.txt; fi

omsls.sh $1 $2
