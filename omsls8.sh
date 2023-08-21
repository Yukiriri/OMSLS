#!/bin/bash
#bat arg: <jar> <Xmx>
#env arg: [custom_java_path]

if [ "$custom_java_path" == "" ]; then
  custom_java_path=java
fi

mem_unit=${2:0-1:1}
mem_amount=${2%$mem_unit}
shell_dir=$(cd $(dirname $0); pwd)
gc_txt=$shell_dir/flags/g1gc.small.txt
common_txt=$shell_dir/flags/common.txt

if [[ "${mem_unit^}" == "G" && $mem_amount -gt 12    ]]; then gc_txt=$shell_dir/flags/g1gc.txt; fi
if [[ "${mem_unit^}" == "M" && $mem_amount -gt 12000 ]]; then gc_txt=$shell_dir/flags/g1gc.txt; fi

flags="$(<$gc_txt) "
flags+="$(<$common_txt) "
if [[ "$yggdrasil_txt" != "" ]]; then
  flags+="$(<$yggdrasil_txt) "
fi

$custom_java_path -Xmx$2 -Xms$2 $flags -XX:+UseTransparentHugePages -jar $1 --nogui

export yggdrasil_txt=
