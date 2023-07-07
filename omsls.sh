#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path] [preset_java_version]

if [ "$custom_java_path" == "" ]; then
  custom_java_path=java
fi
if [ "$preset_java_version" == "" ]; then
  preset_java_version=11
fi

if [ "$3" == "" ]; then
  Xms=-Xms$2
  fixedmem_flags=-XX:+UseTransparentHugePages
else
  Xms=-Xms$3
  fixedmem_flags=
fi
mem_unit=${2:0-1:1}
mem_amount=${2%$mem_unit}

shell_dir=$(cd $(dirname $0); pwd)
if [[ $(cat /proc/cpuinfo | grep "processor" | wc -l) -ge 8 ]] && 
   [[ $preset_java_version -ge 11 ]]; then
  gc_flags=@$shell_dir/flags/sgc.txt
else
  gc_flags=@$shell_dir/flags/g1gc.txt
  if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12 ]] || 
     [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then
      gc_flags=@$shell_dir/flags/g1gc-gt12.txt
  fi
fi

$custom_java_path -Xmx$2 $Xms $gc_flags $fixedmem_flags @$shell_dir/flags/common.txt $yggdrasil_arg -jar $1 --nogui
