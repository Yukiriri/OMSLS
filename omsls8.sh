#!/bin/bash
#bat arg: <jar> <Xmx> [Xms]
#env arg: [custom_java_path]

if [ "$custom_java_path" == "" ]; then
  custom_java_path=java
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
gc_txt=$shell_dir/flags/g1gc.txt
common_txt=$shell_dir/flags/common.txt

if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12    ]]; then gc_txt=$shell_dir/flags/g1gc.gt12.txt; fi
if [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then gc_txt=$shell_dir/flags/g1gc.gt12.txt; fi

arg="$(<$gc_txt) "
arg+="$(<$common_txt) "
if [[ "$yggdrasil_txt" != "" ]]; then
  arg+="$(<$yggdrasil_txt) "
fi
$custom_java_path -Xmx$2 $Xms $arg $fixedmem_flags -jar $1 --nogui
