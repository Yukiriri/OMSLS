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
if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12    ]]; then gc_flags=$shell_dir/flags/g1gc-gt12.txt; fi
if [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then gc_flags=$shell_dir/flags/g1gc-gt12.txt; fi
if [[ $(cat /proc/cpuinfo | grep "processor" | wc -l) -ge 8 ]]; then
  if [[ $preset_java_version -ge 17 ]]; then
    if [[ $is_fixedmem == 1 ]]; then gc_flags=$shell_dir/flags/zgc.txt; fi
    if [[ $is_fixedmem == 0 ]]; then gc_flags=$shell_dir/flags/zgc-min.txt; fi
  fi
  if [[ $preset_java_version -ge 11 ]]; then
    if [[ $is_fixedmem == 1 ]]; then gc_flags=$shell_dir/flags/sgc.txt; fi
    if [[ $is_fixedmem == 0 ]]; then gc_flags=$shell_dir/flags/sgc-min.txt; fi
  fi
fi
common_flags=$shell_dir/flags/common.txt

if [[ $preset_java_version -ge 11 ]]; then
  $custom_java_path -Xmx$2 $Xms @$gc_flags $fixedmem_flags @$common_flags $yggdrasil_flags -jar $1 --nogui
else
  arg="$(<$gc_flags) "
  arg+="$(<$common_flags) "
  if [[ "$yggdrasil_flags_txt" != "" ]]; then arg+="$(<$yggdrasil_flags_txt) "; fi
  $custom_java_path -Xmx$2 $Xms $arg $fixedmem_flags -jar $1 --nogui
fi
