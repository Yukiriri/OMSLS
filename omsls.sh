#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path] [preset_java_version]

if [ "$custom_java_path" == "" ]; then
  custom_java_path=java
fi
if [ "$preset_java_version" == "" ]; then
  preset_java_version=17
fi
if [ "$3" == "" ]; then
  Xms=-Xms$2
  fixedmem_flags=-XX:+UseTransparentHugePages
  is_fixedmem=1
else
  Xms=-Xms$3
  fixedmem_flags=
  is_fixedmem=0
fi

mem_unit=${2:0-1:1}
mem_amount=${2%$mem_unit}
shell_dir=$(cd $(dirname $0); pwd)
gc_flags=$shell_dir/flags/g1gc.txt
common_flags=@$shell_dir/flags/common.txt

if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12    ]]; then gc_flags=$shell_dir/flags/g1gc-gt12.txt; fi
if [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then gc_flags=$shell_dir/flags/g1gc-gt12.txt; fi
if [[ $preset_java_version -ge 11 ]]; then
  common_flags+=" -XX:+UseVectorCmov"
fi
if [[ $preset_java_version -ge 17 ]]; then
  common_flags+=" --add-modules jdk.incubator.vector"
  if [[ $is_fixedmem == 1 ]]; then gc_flags=$shell_dir/flags/zgc.txt; fi
  if [[ $is_fixedmem == 0 ]]; then gc_flags=$shell_dir/flags/zgc.min.txt; fi
fi
if [[ $preset_java_version -ge 21 ]]; then
  if [[ $is_fixedmem == 1 ]]; then gc_flags=$shell_dir/flags/zgc.gen.txt; fi
  if [[ $is_fixedmem == 0 ]]; then gc_flags=$shell_dir/flags/zgc.gen.min.txt; fi
fi

$custom_java_path -Xmx$2 $Xms @$gc_flags $fixedmem_flags $common_flags @$yggdrasil_flags -jar $1 --nogui
