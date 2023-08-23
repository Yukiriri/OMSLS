#!/bin/bash

if [[ "$custom_java_path" == "" ]]; then
  custom_java_path=java
fi

if [[ "$3" == "" ]]; then
  Xms=-Xms$2
  omsls_extend_common_flags+="-XX:+UseTransparentHugePages "
else
  Xms=-Xms$3
fi

shell_dir=$(cd $(dirname $0); pwd)
omsls_common_flags=$shell_dir/flags/common.txt

if [[ "$omsls_is_legacy_java_cmd" == "0" ]]; then
  omsls_final_flags="@$omsls_gc_flags @$omsls_common_flags $omsls_extend_common_flags "
  if [[ "$omsls_yggdrasil_flags" != "" ]]; then
    omsls_final_flags+="@$omsls_yggdrasil_flags "
  fi
else
  omsls_final_flags="$(<$omsls_gc_flags) $(<$omsls_common_flags) $omsls_extend_common_flags "
  if [[ "$omsls_yggdrasil_flags" != "" ]]; then
    omsls_final_flags+="$(<$omsls_yggdrasil_flags) "
  fi
fi

export omsls_gc_flags=
export omsls_extend_common_flags=
export omsls_yggdrasil_flags=
export omsls_is_legacy_java_cmd=

echo $custom_java_path -Xmx$2 $Xms $omsls_final_flags -jar $1 --nogui
